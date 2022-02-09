module GraphQLClient.WriteGraphQLHash where

import Prelude (map, show, ($), (<$>), (<>))
import Data.Array as Array
import Data.Int as Int
import Data.Maybe (Maybe(..), maybe)
import Data.String as String
import Data.Tuple (Tuple(..))
import Data.Number.Format (toStringWith, fixed)
import GraphQLClient.Argument (Argument(..), ArgumentValue(..), Optional(..))
import GraphQLClient.Cyrb53 (cyrb53)

filterAbsent :: Array Argument -> Array (Tuple String ArgumentValue)
filterAbsent = Array.mapMaybe go
  where
  go = case _ of
    RequiredArgument n v -> Just (Tuple n v)
    OptionalArgument n (Present v) -> Just (Tuple n v)
    OptionalArgument _ Absent -> Nothing

type Cache = -- | the string representation of `args :: Array Argument`
  -- |
  -- | e.g.
  -- |
  -- | ```purs
  -- | args = [ RequiredArgument "yyy" (ArgumentValueBoolean true) ] -- should be non-empty, because `Maybe Cache`
  -- |
  -- | argsWritten = writeGraphQLArguments args
  -- |
  -- | -- will return
  -- |
  -- | argsWritten = "(yyy: true)"
  -- | ```
  -- |
  -- | NOTE: we DO NOT KEEP the args after they were converted to the string representation
  -- | because I didn't fine a place where to use them
  { argsWritten :: String
  -- | a hash from argsWritten arg, used to be added to field names
  , hash :: String
  }

argsHash :: Array Argument -> Maybe Cache
argsHash args = case filterAbsent args of
  [] -> Nothing
  args' ->
    let
      argsWritten :: String
      argsWritten = writeGraphQLArguments args'

      hash :: String
      hash = show $ cyrb53 argsWritten
    in
      Just { argsWritten, hash }

-------------------------
writeGraphQLArguments :: Array (Tuple String ArgumentValue) -> String
writeGraphQLArguments [] = ""
writeGraphQLArguments args =
  let
    args' = String.joinWith ", " $ writeGraphQLArgumentsNameVal <$> args
  in
    if String.null args' then "" else "(" <> args' <> ")"

writeGraphQLArgumentsNameVal :: Tuple String ArgumentValue -> String
writeGraphQLArgumentsNameVal (Tuple name value) = name <> ": " <> writeGraphQLArgumentsArgumentValue value

writeGraphQLArgumentsArgumentValue :: ArgumentValue -> String
writeGraphQLArgumentsArgumentValue = case _ of
  ArgumentValueString s -> "\"" <> s <> "\""
  ArgumentValueEnum s -> s
  ArgumentValueInt i -> Int.toStringAs Int.decimal i
  ArgumentValueFloat f -> toStringWith (fixed 4) f
  ArgumentValueBoolean b -> if b then "true" else "false"
  ArgumentValueMaybe maybeArg -> maybe "null" writeGraphQLArgumentsArgumentValue maybeArg
  ArgumentValueArray [] -> "[]"
  ArgumentValueArray argsArray -> "[" <> (String.joinWith ", " $ map writeGraphQLArgumentsArgumentValue argsArray) <> "]"
  ArgumentValueObject arguments -> writeGraphQLArgumentsArray arguments

writeGraphQLArgumentsArray :: Array Argument -> String
writeGraphQLArgumentsArray [] = ""
writeGraphQLArgumentsArray args =
  let
    args' = String.joinWith ", " $ writeGraphQLArgumentsNameVal <$> (filterAbsent args)
  in
    if String.null args' then "" else "{ " <> args' <> " }"
