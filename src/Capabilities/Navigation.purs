module Website.Capabilities.Navigation where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen (HalogenM, lift)
import Website.Data.Routes (Route)

class MonadAff m <= Navigate m where
  navigate :: Route -> m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift <<< navigate
