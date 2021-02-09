module Dillonkearns.Examples.Github.Object.StargazerEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes (Scope__StargazerEdge, Scope__User)
import Dillonkearns.Examples.Github.Scalars (DateTime)

cursor :: SelectionSet Scope__StargazerEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__User r
  -> SelectionSet Scope__StargazerEdge r
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

starredAt :: SelectionSet Scope__StargazerEdge DateTime
starredAt = selectionForField "starredAt" [] graphqlDefaultResponseScalarDecoder
