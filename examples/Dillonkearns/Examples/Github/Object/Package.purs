module Dillonkearns.Examples.Github.Object.Package where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , toGraphQLArguments
  , Optional
  )
import Dillonkearns.Examples.Github.Scopes
  ( Scope__Package
  , Scope__PackageVersion
  , Scope__Repository
  , Scope__PackageStatistics
  , Scope__PackageVersionConnection
  )
import Dillonkearns.Examples.Github.Scalars (Id)
import Data.Maybe (Maybe)
import Dillonkearns.Examples.Github.Enum.PackageType (PackageType)
import Type.Row (type (+))
import Dillonkearns.Examples.Github.InputObject (PackageVersionOrder) as Dillonkearns.Examples.Github.InputObject

id :: SelectionSet Scope__Package Id
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

latestVersion
  :: forall r
   . SelectionSet Scope__PackageVersion r
  -> SelectionSet Scope__Package (Maybe r)
latestVersion = selectionForCompositeField
                "latestVersion"
                []
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

name :: SelectionSet Scope__Package String
name = selectionForField "name" [] graphqlDefaultResponseScalarDecoder

packageType :: SelectionSet Scope__Package PackageType
packageType = selectionForField
              "packageType"
              []
              graphqlDefaultResponseScalarDecoder

repository
  :: forall r
   . SelectionSet Scope__Repository r
  -> SelectionSet Scope__Package (Maybe r)
repository = selectionForCompositeField
             "repository"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

statistics
  :: forall r
   . SelectionSet Scope__PackageStatistics r
  -> SelectionSet Scope__Package (Maybe r)
statistics = selectionForCompositeField
             "statistics"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type VersionInputRowRequired r = ( version :: String | r )

type VersionInput = { | VersionInputRowRequired + () }

version
  :: forall r
   . VersionInput
  -> SelectionSet Scope__PackageVersion r
  -> SelectionSet Scope__Package (Maybe r)
version input = selectionForCompositeField
                "version"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type VersionsInputRowOptional r
  = ( orderBy
      :: Optional
         Dillonkearns.Examples.Github.InputObject.PackageVersionOrder
    , after :: Optional String
    , before :: Optional String
    , first :: Optional Int
    , last :: Optional Int
    | r
    )

type VersionsInput = { | VersionsInputRowOptional + () }

versions
  :: forall r
   . VersionsInput
  -> SelectionSet Scope__PackageVersionConnection r
  -> SelectionSet Scope__Package r
versions input = selectionForCompositeField
                 "versions"
                 (toGraphQLArguments
                  input)
                 graphqlDefaultResponseFunctorOrScalarDecoderTransformer
