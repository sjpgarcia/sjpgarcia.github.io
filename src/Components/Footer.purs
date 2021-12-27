-- | This is a static component used in different pages.
module Website.Components.Footer where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Website.Utils (class_)

component ∷ ∀ q i o m. MonadAff m ⇒ H.Component q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval
    }
  where
  initialState _ = unit

  render _ =
    HH.footer
      [ class_
          """
          flex justify-items-center
          font-comfortaa font-light
          text-lg text-white text-center
          h-16 mt-auto 
        """
      ]
      [ HH.text "© Justin Garcia, 2021"
      ]