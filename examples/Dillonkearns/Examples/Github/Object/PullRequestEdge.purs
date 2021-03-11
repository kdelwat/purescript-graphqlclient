module Dillonkearns.Examples.Github.Object.PullRequestEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__PullRequestEdge, Scope__PullRequest)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__PullRequestEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__PullRequest r
  -> SelectionSet Scope__PullRequestEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
