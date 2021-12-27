module Website.Components.Navbar where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Website.Utils (class_)

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
    [ HH.nav
      [ class_
          """
            gap-2 h-16 p-2 flex flex-row
            justify-items-center items-center
          """
      ]
      [ HH.img
        [ HP.src "https://avatars.githubusercontent.com/u/91515796?v=4"
        , HP.alt "A logo representing a textured green cube"
        , HP.height 32
        , HP.width 32
        , class_ "m-2 rounded-full"
        ]
      , HH.span
        [ class_ "font-comfortaa text-white text-2xl flex-grow"
        ]
        [ HH.text "sjpgarcia's page"
        ]
      ]
    ]
