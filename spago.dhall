{ name = "website"
, dependencies =
  [ "aff"
  , "console"
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
  , "typelevel-prelude"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
