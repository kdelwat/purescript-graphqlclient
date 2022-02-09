{ name = "graphqlclient"
, dependencies =
  [ "aff"
  , "affjax"
  , "argonaut-codecs"
  , "argonaut-core"
  , "argonaut-generic"
  , "arrays"
  , "bifunctors"
  , "control"
  , "datetime"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "foreign-object"
  , "http-methods"
  , "integers"
  , "lists"
  , "maybe"
  , "newtype"
  , "numbers"
  , "prelude"
  , "psci-support"
  , "record"
  , "strings"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "Apache-2.0"
, repository =
    "https://github.com/purescript-graphqlclient/purescript-graphqlclient"
}
