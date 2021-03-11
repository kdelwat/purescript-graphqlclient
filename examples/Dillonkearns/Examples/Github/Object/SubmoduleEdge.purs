module Dillonkearns.Examples.Github.Object.SubmoduleEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__SubmoduleEdge, Scope__Submodule)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__SubmoduleEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__Submodule r
  -> SelectionSet Scope__SubmoduleEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
