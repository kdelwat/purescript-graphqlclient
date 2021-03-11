module Dillonkearns.Examples.Github.Object.CommitEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes (Scope__CommitEdge, Scope__Commit)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__CommitEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__Commit r
  -> SelectionSet Scope__CommitEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
