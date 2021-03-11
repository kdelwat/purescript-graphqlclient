module Dillonkearns.Examples.Github.Object.PinnableItemEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__PinnableItemEdge, Scope__PinnableItem)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__PinnableItemEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__PinnableItem r
  -> SelectionSet Scope__PinnableItemEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
