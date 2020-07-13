module GraphqlClientGenerator.MakeModule.Enum where

import GraphqlClientGenerator.IntrospectionSchema
import GraphqlClientGenerator.IntrospectionSchema.TypeKind
import GraphqlClientGenerator.MakeModule.Lib.Utils
import Language.PS.CST
import Language.PS.CST.Printers
import Language.PS.CST.Sugar
import Protolude

import Data.Array as Array
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Array.NonEmpty as NonEmpty
import Data.List ((:))
import Data.List as List
import Data.Map (Map)
import Data.Map as Map
import Data.Predicate (Predicate(..))
import Data.String.Extra (pascalCase)
import Data.String.Extra as StringsExtra
import Data.String.Utils (startsWith)
import GraphqlClientGenerator.IntrospectionSchema.Fields (__schema)

makeModule :: ModuleName -> InstorpectionQueryResult__FullType -> Module
makeModule moduleName fullType =
  let
    enumValues' :: Maybe $ NonEmptyArray InstorpectionQueryResult__EnumValue
    enumValues' = fullType.enumValues <#> NonEmpty.fromFoldable # join
  in
  Module
  { moduleName
  , imports:
    [ ImportDecl
      { moduleName: mkModuleName $ NonEmpty.singleton "Prelude"
      , names: []
      , qualification: Nothing
      }
    , ImportDecl
      { moduleName: mkModuleName $ NonEmpty.singleton "GraphqlClient"
      , names: []
      , qualification: Nothing
      }
    , ImportDecl
      { moduleName: mkModuleName $ NonEmpty.cons' "Data" ["Tuple"]
      , names: []
      , qualification: Nothing
      }
    ]
  , exports: []
  , declarations:
    [ DeclData
      { comments: Just $ OneLineComments ["original name - " <> fullType.name]
      , head: DataHead
          { dataHdName: ProperName $ StringsExtra.pascalCase fullType.name
          , dataHdVars: []
          }
      , constructors:
          fullType.enumValues
          # fromMaybe []
          <#> (\field -> DataCtor { dataCtorName: ProperName $ StringsExtra.pascalCase field.name, dataCtorFields: [] })
      }
    , DeclSignature
      { comments: Nothing
      , ident: Ident "fromToMap"
      , type_: arrayType (tupleDecl (nonQualifiedNameTypeConstructor "String") (nonQualifiedNameTypeConstructor $ StringsExtra.pascalCase fullType.name))
      }
    , DeclValue
      { comments: Nothing
      , valueBindingFields:
        { name: Ident "fromToMap"
        , binders: []
        , guarded: Unconditional
          { expr: ExprArray
              ( fullType.enumValues
              # fromMaybe []
              <#> (\field -> tupleExpr (ExprString field.name) (ExprConstructor $ nonQualifiedName (ProperName $ StringsExtra.pascalCase field.name)))
              )
          , whereBindings: []
          }
        }
      }
    , DeclInstanceChain
        { comments: Nothing
        , instances:
          NonEmpty.singleton
          { head:
            { instClass: nonQualifiedName (ProperName "GraphqlDefaultResponseScalarDecoder" )
            , instConstraints: []
            , instName: Ident (StringsExtra.camelCase fullType.name <> "GraphqlDefaultResponseScalarDecoder")
            , instTypes: NonEmpty.singleton $ nonQualifiedNameTypeConstructor (StringsExtra.pascalCase fullType.name)
            }
          , body:
            [ InstanceBindingName
              { binders: []
              , guarded: Unconditional
                { expr:
                  (ExprIdent (nonQualifiedName $ Ident "enumDecoder"))
                  `ExprApp`
                  (ExprString (StringsExtra.pascalCase fullType.name))
                  `ExprApp`
                  (ExprIdent (nonQualifiedName $ Ident "fromToMap"))
                , whereBindings: []
                }
              , name: Ident "graphqlDefaultResponseScalarDecoder"
              }
            ]
          }
        }
    , DeclInstanceChain
        { comments: Nothing
        , instances:
          NonEmpty.singleton
          { head:
            { instClass: nonQualifiedName (ProperName "ToGraphqlArgumentValue" )
            , instConstraints: []
            , instName: Ident (StringsExtra.camelCase fullType.name <> "ToGraphqlArgumentValue")
            , instTypes: NonEmpty.singleton $ nonQualifiedNameTypeConstructor (StringsExtra.pascalCase fullType.name)
            }
          , body:
            [InstanceBindingName
              { name: Ident "toGraphqlArgumentValue"
              , binders: []
              , guarded: Unconditional
                { whereBindings: []
                , expr: flip (maybe (nonQualifiedExprIdent "ERROR_IS_EMPTY_ARRAY")) enumValues' \enumValues'' ->
                  ExprCase
                    { head: NonEmpty.singleton ExprSection
                    , branches: enumValues'' <#> \enumValue ->
                        { binders: NonEmpty.singleton (BinderConstructor { name: nonQualifiedName $ ProperName $ StringsExtra.pascalCase enumValue.name, args: [] })
                        , body: Unconditional
                            { whereBindings: []
                            , expr: ExprString enumValue.name
                            }
                        }
                    }
                }
              }
            ]
          }
        }
    ]
  }
