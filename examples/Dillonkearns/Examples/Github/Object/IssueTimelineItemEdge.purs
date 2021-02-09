module Dillonkearns.Examples.Github.Object.IssueTimelineItemEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__IssueTimelineItemEdge, Scope__IssueTimelineItem)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__IssueTimelineItemEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__IssueTimelineItem r
  -> SelectionSet Scope__IssueTimelineItemEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
