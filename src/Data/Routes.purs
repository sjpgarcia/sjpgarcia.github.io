module Website.Data.Routes where

import Prelude hiding ((/))

import Data.Eq (class Eq)
import Data.Generic.Rep (class Generic)
import Routing.Duplex (RouteDuplex', root)
import Routing.Duplex.Generic (noArgs, sum)
import Routing.Duplex.Generic.Syntax ((/))

data Route
  = Home
  | NotFound

derive instance Generic Route _
derive instance Eq Route

codec :: RouteDuplex' Route
codec = root $ sum
  { "Home": noArgs
  , "NotFound": "404.html" / noArgs
  }
