module Dillonkearns.Examples.Github.Object.SetEnterpriseIdentityProviderPayload where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  ( Scope__SetEnterpriseIdentityProviderPayload
  , Scope__EnterpriseIdentityProvider
  )
import Data.Maybe (Maybe)

clientMutationId
  :: SelectionSet
     Scope__SetEnterpriseIdentityProviderPayload
     (Maybe String)
clientMutationId = selectionForField
                   "clientMutationId"
                   []
                   graphqlDefaultResponseScalarDecoder

identityProvider
  :: forall r
   . SelectionSet Scope__EnterpriseIdentityProvider r
  -> SelectionSet Scope__SetEnterpriseIdentityProviderPayload (Maybe r)
identityProvider = selectionForCompositeField
                   "identityProvider"
                   []
                   graphqlDefaultResponseFunctorOrScalarDecoderTransformer
