module Dillonkearns.Examples.Github.Object.SponsorsTierEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__SponsorsTierEdge, Scope__SponsorsTier)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__SponsorsTierEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__SponsorsTier r
  -> SelectionSet Scope__SponsorsTierEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
