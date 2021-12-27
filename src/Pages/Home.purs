-- | The home page.
module Website.Pages.Home where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))
import Website.Components.Navbar as Navbar

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
    [ HH.slot_ (Proxy :: _ "navbar") unit Navbar.component unit
    ]
