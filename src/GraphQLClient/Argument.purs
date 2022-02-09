module GraphQLClient.Argument where

import Prelude
import Data.Array as Array
import Data.Maybe (Maybe)
import Data.Symbol (class IsSymbol, SProxy(..), reflectSymbol)
import Prim.Row as Prim.Row
import Prim.RowList as RowList
import Record as Record
import Type.Data.RowList (RLProxy(..))

data ArgumentValue
  = ArgumentValueString String
  | ArgumentValueEnum String
  | ArgumentValueInt Int
  | ArgumentValueFloat Number
  | ArgumentValueBoolean Boolean
  | ArgumentValueMaybe (Maybe ArgumentValue)
  | ArgumentValueArray (Array ArgumentValue)
  | ArgumentValueObject (Array Argument)

derive instance eqArgumentValue :: Eq ArgumentValue

data Argument
  = RequiredArgument String ArgumentValue
  | OptionalArgument String (Optional ArgumentValue)

derive instance eqArgument :: Eq Argument

class ToGraphQLArgumentValue a where
  toGraphQLArgumentValue :: a -> ArgumentValue

instance toGraphQLArgumentValueString :: ToGraphQLArgumentValue String where
  toGraphQLArgumentValue = ArgumentValueString

instance toGraphQLArgumentValueInt :: ToGraphQLArgumentValue Int where
  toGraphQLArgumentValue = ArgumentValueInt

instance toGraphQLArgumentValueFloat :: ToGraphQLArgumentValue Number where
  toGraphQLArgumentValue = ArgumentValueFloat

instance toGraphQLArgumentValueBoolean :: ToGraphQLArgumentValue Boolean where
  toGraphQLArgumentValue = ArgumentValueBoolean

instance toGraphQLArgumentValueRecord :: (RowList.RowToList row list, ToGraphQLArgumentImplementationRecord list row) => ToGraphQLArgumentValue (Record row) where
  toGraphQLArgumentValue record = ArgumentValueObject (toGraphQLArguments record)

instance toGraphQLArgumentValueMaybe :: ToGraphQLArgumentValue a => ToGraphQLArgumentValue (Maybe a) where
  toGraphQLArgumentValue maybeA = ArgumentValueMaybe (map toGraphQLArgumentValue maybeA)

instance toGraphQLArgumentValueNested :: ToGraphQLArgumentValue a => ToGraphQLArgumentValue (Array a) where
  toGraphQLArgumentValue arguments = ArgumentValueArray (map toGraphQLArgumentValue arguments)

-- | else instance toGraphQLArgumentValueNewtype :: (Newtype a b, ToGraphQLArgumentValue b) => ToGraphQLArgumentValue a where
-- |   toGraphQLArgumentValue = toGraphQLArgumentValue <<< unwrap

toGraphQLArguments
  :: ∀ row list
   . RowList.RowToList row list
  => ToGraphQLArgumentImplementationRecord list row
  => (Record row)
  -> Array Argument
toGraphQLArguments rec = toGraphQLArgumentImplementationRecord (RLProxy :: RLProxy list) rec

-------------------------------------------------------
class ToGraphQLArgumentImplementationRecord (list :: RowList.RowList Type) (row :: Row Type) | list -> row where
  toGraphQLArgumentImplementationRecord :: forall proxy. proxy list -> Record row -> Array Argument

-- for nested records
instance toGraphQLArgumentRecordConsChildRow ::
  ( RowList.RowToList childRow childList
  , ToGraphQLArgumentImplementationRecord childList childRow
  ---
  , ToGraphQLArgumentImplementationRecord tail row
  , IsSymbol field
  , Prim.Row.Cons field (Record childRow) rowTail row
  ) =>
  ToGraphQLArgumentImplementationRecord (RowList.Cons field (Record childRow) tail) row where
  toGraphQLArgumentImplementationRecord _proxy record =
    let
      (currentValue :: Record childRow) = Record.get (SProxy :: SProxy field) record

      (currentValue' :: Array Argument) = toGraphQLArguments currentValue

      (current :: Argument) = RequiredArgument (reflectSymbol (SProxy :: SProxy field)) (ArgumentValueObject currentValue')

      (rest :: Array Argument) = toGraphQLArgumentImplementationRecord (RLProxy :: RLProxy tail) record
    in
      Array.cons current rest
else -- for optional values (optional nested records too)
instance toGraphQLArgumentRecordConsOptional ::
  ( ToGraphQLArgumentValue value
  , ToGraphQLArgumentImplementationRecord tail row
  , IsSymbol field
  , Prim.Row.Cons field (Optional value) rowTail row
  ) =>
  ToGraphQLArgumentImplementationRecord (RowList.Cons field (Optional value) tail) row where
  toGraphQLArgumentImplementationRecord _proxy record =
    let
      (currentValue :: Optional value) = Record.get (SProxy :: SProxy field) record

      (currentValue' :: Optional ArgumentValue) = map toGraphQLArgumentValue currentValue

      (current :: Argument) = OptionalArgument (reflectSymbol (SProxy :: SProxy field)) currentValue'

      (rest :: Array Argument) = toGraphQLArgumentImplementationRecord (RLProxy :: RLProxy tail) record
    in
      Array.cons current rest
else -- for everything else (Nil)
instance toGraphQLArgumentRecordNil :: ToGraphQLArgumentImplementationRecord RowList.Nil row where
  toGraphQLArgumentImplementationRecord _proxy _record = []
else -- for everything else (Cons)
instance toGraphQLArgumentRecordCons ::
  ( ToGraphQLArgumentValue value
  , ToGraphQLArgumentImplementationRecord tail row
  , IsSymbol field
  , Prim.Row.Cons field value rowTail row
  ) =>
  ToGraphQLArgumentImplementationRecord (RowList.Cons field value tail) row where
  toGraphQLArgumentImplementationRecord _proxy record =
    let
      (currentValue :: value) = Record.get (SProxy :: SProxy field) record

      (currentValue' :: ArgumentValue) = toGraphQLArgumentValue currentValue

      (current :: Argument) = RequiredArgument (reflectSymbol (SProxy :: SProxy field)) currentValue'

      (rest :: Array Argument) = toGraphQLArgumentImplementationRecord (RLProxy :: RLProxy tail) record
    in
      Array.cons current rest

--------------------
data Optional x
  = Absent
  | Present x -- it's like Maybe, but with DefaultInput class, and only for input of graphql

derive instance eqOptional :: Eq a => Eq (Optional a)

derive instance ordOptional :: Ord a => Ord (Optional a)

instance showMaybe :: Show a => Show (Optional a) where
  show (Present x) = "(Present " <> show x <> ")"
  show Absent = "Absent"

derive instance optionalFunctor :: Functor Optional

instance optionalDefaultInput :: DefaultInput (Optional a) where
  defaultInput = Absent

--------------------
class DefaultInput a where
  defaultInput :: a

instance recordDefaultInput :: (DefaultInputImplementationRecord row list, RowList.RowToList row list) => DefaultInput (Record row) where
  defaultInput = defaultInputImplementationRecord (RLProxy :: RLProxy list)

-- Implementation for Record
class DefaultInputImplementationRecord (row :: Row Type) (list :: RowList.RowList Type) | list -> row where
  defaultInputImplementationRecord :: RLProxy list -> Record row

instance defaultInputImplementationRecordNil :: DefaultInputImplementationRecord () RowList.Nil where
  defaultInputImplementationRecord _proxy = {}

instance defaultInputImplementationRecordCons ::
  ( DefaultInput value
  , DefaultInputImplementationRecord rowTail tail
  , IsSymbol field
  , Prim.Row.Cons field value rowTail row
  , Prim.Row.Lacks field rowTail
  ) =>
  DefaultInputImplementationRecord row (RowList.Cons field value tail) where
  defaultInputImplementationRecord _proxy =
    let
      rest = defaultInputImplementationRecord (RLProxy :: RLProxy tail)
    in
      Record.insert (SProxy :: SProxy field) defaultInput rest
