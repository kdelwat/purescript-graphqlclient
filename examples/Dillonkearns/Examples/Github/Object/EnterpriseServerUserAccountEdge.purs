module Dillonkearns.Examples.Github.Object.EnterpriseServerUserAccountEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__EnterpriseServerUserAccountEdge, Scope__EnterpriseServerUserAccount)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__EnterpriseServerUserAccountEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__EnterpriseServerUserAccount r
  -> SelectionSet Scope__EnterpriseServerUserAccountEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
