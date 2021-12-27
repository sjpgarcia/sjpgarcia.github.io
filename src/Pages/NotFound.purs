-- | The 404 page.
module Website.Pages.NotFound where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH

component :: forall q i o m. MonadAff m => H.Component q i o m
component =
  H.mkComponent
  { initialState
  , render
  , eval: H.mkEval $ H.defaultEval
  }
  where
  initialState _ = unit

  render _ =
    HH.div_
    [ HH.text "Under Construction"
    ]
