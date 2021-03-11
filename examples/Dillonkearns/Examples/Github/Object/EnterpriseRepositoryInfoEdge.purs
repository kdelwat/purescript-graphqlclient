module Dillonkearns.Examples.Github.Object.EnterpriseRepositoryInfoEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__EnterpriseRepositoryInfoEdge, Scope__EnterpriseRepositoryInfo)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__EnterpriseRepositoryInfoEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__EnterpriseRepositoryInfo r
  -> SelectionSet Scope__EnterpriseRepositoryInfoEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
