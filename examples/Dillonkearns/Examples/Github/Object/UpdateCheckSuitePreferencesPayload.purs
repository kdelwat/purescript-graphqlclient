module Dillonkearns.Examples.Github.Object.UpdateCheckSuitePreferencesPayload where

import Dillonkearns.GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Dillonkearns.Examples.Github.Scopes
  (Scope__UpdateCheckSuitePreferencesPayload, Scope__Repository)
import Data.Maybe (Maybe)

clientMutationId
  :: SelectionSet
     Scope__UpdateCheckSuitePreferencesPayload
     (Maybe String)
clientMutationId = selectionForField
                   "clientMutationId"
                   []
                   graphqlDefaultResponseScalarDecoder

repository
  :: forall r
   . SelectionSet Scope__Repository r
  -> SelectionSet Scope__UpdateCheckSuitePreferencesPayload (Maybe r)
repository = selectionForCompositeField
             "repository"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer
