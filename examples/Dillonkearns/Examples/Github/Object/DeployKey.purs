module Dillonkearns.Examples.Github.Object.DeployKey where

import Dillonkearns.GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Dillonkearns.Examples.Github.Scopes (Scope__DeployKey)
import Dillonkearns.Examples.Github.Scalars (DateTime, Id)

createdAt :: SelectionSet Scope__DeployKey DateTime
createdAt = selectionForField "createdAt" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__DeployKey Id
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

key :: SelectionSet Scope__DeployKey String
key = selectionForField "key" [] graphqlDefaultResponseScalarDecoder

readOnly :: SelectionSet Scope__DeployKey Boolean
readOnly = selectionForField "readOnly" [] graphqlDefaultResponseScalarDecoder

title :: SelectionSet Scope__DeployKey String
title = selectionForField "title" [] graphqlDefaultResponseScalarDecoder

verified :: SelectionSet Scope__DeployKey Boolean
verified = selectionForField "verified" [] graphqlDefaultResponseScalarDecoder
