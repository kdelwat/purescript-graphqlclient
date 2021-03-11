module Dillonkearns.Examples.Github.Object.ReleaseAssetEdge where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__ReleaseAssetEdge, Scope__ReleaseAsset)
import Data.Maybe (Maybe)

cursor :: SelectionSet Scope__ReleaseAssetEdge String
cursor = selectionForField "cursor" [] graphqlDefaultResponseScalarDecoder

node
  :: forall r
   . SelectionSet Scope__ReleaseAsset r
  -> SelectionSet Scope__ReleaseAssetEdge (Maybe r)
node = selectionForCompositeField
       "node"
       []
       graphqlDefaultResponseFunctorOrScalarDecoderTransformer
