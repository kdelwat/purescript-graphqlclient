module Dillonkearns.Examples.Github.Object.RepositoryTopicEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__RepositoryTopicEdge, Scope__RepositoryTopic)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__RepositoryTopicEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__RepositoryTopic r
  -> SelectionSet Scope__RepositoryTopicEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
