module Dillonkearns.Examples.Github.Object.PushAllowanceEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__PushAllowanceEdge, Scope__PushAllowance)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__PushAllowanceEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__PushAllowance r
  -> SelectionSet Scope__PushAllowanceEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
