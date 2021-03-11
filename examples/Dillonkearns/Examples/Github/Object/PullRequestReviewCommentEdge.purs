module Dillonkearns.Examples.Github.Object.PullRequestReviewCommentEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__PullRequestReviewCommentEdge, Scope__PullRequestReviewComment)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__PullRequestReviewCommentEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__PullRequestReviewComment r
  -> SelectionSet Scope__PullRequestReviewCommentEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
