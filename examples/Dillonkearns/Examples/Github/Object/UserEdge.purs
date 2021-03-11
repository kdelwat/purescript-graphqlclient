module Dillonkearns.Examples.Github.Object.UserEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes (Scope__UserEdge, Scope__User)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__UserEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__User r
  -> SelectionSet Scope__UserEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
