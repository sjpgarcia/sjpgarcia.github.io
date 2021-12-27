{ name = "website"
, dependencies =
  [ "aff"
  , "effect"
  , "either"
  , "halogen"
  , "halogen-store"
  , "maybe"
  , "newtype"
  , "prelude"
  , "psci-support"
  , "routing"
  , "routing-duplex"
  , "safe-coerce"
  , "simple-json"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
