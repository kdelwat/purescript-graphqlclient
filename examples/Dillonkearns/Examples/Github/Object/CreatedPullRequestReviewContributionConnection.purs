module Dillonkearns.Examples.Github.Object.CreatedPullRequestReviewContributionConnection where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Dillonkearns.Examples.Github.Scopes
  ( Scope__CreatedPullRequestReviewContributionEdge
  , Scope__CreatedPullRequestReviewContributionConnection
  , Scope__CreatedPullRequestReviewContribution
  , Scope__PageInfo
  )
import Data.Maybe (Maybe)

edges
  :: forall r
   . SelectionSet Scope__CreatedPullRequestReviewContributionEdge r
  -> SelectionSet
        Scope__CreatedPullRequestReviewContributionConnection
        (Maybe (Array (Maybe r)))
edges = selectionForCompositeField
        "edges"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes
  :: forall r
   . SelectionSet Scope__CreatedPullRequestReviewContribution r
  -> SelectionSet
        Scope__CreatedPullRequestReviewContributionConnection
        (Maybe (Array (Maybe r)))
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

pageInfo
  :: forall r
   . SelectionSet Scope__PageInfo r
  -> SelectionSet Scope__CreatedPullRequestReviewContributionConnection r
pageInfo = selectionForCompositeField
           "pageInfo"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

totalCount
  :: SelectionSet
     Scope__CreatedPullRequestReviewContributionConnection
     Int
totalCount = selectionForField
             "totalCount"
             []
             graphqlDefaultResponseScalarDecoder
