-- | The home page.
module Website.Pages.Home where

import Prelude

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Type.Proxy (Proxy(..))
import Website.Components.Navbar as Navbar
import Website.Components.Footer as Footer
import Website.Utils (class_)

data Tuple a b = Tuple a b

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
    HH.div [ class_ "flex flex-col min-h-screen" ]
      [ HH.slot_ (Proxy ∷ _ "navbar") unit Navbar.component unit
      , HH.article [ class_ "font-oswald font-extralight text-white text-2xl m-4" ]
          [ HH.text "My name is "
          , underlined "Justin Garcia" "decoration-emerald-500"
          , HH.br_
          , HH.br_
          , HH.text "I am a "
          , underlined "Filipino" "decoration-sky-500"
          , HH.text ", "
          , underlined "Functional Programmer" "decoration-violet-500"
          , HH.text ", and "
          , underlined "Computer Science Student" "decoration-yellow-500"
          , HH.br_
          , HH.br_
          , HH.text "You can contact me over "
          , hyperlink "Twitter" "https://twitter.com/PureFunctor"
          , HH.text " or through Email at "
          , underlined "moe at envs.net" "decoration-green-500"
          , HH.br_
          , HH.br_
          , HH.text "For my open-source work: "
          , hyperlink "PureFunctor" "https://github.com/PureFunctor"
          , HH.br_
          , HH.br_
          , HH.text "For my academic work: "
          , hyperlink "sjpgarcia" "https://github.com/sjpgarcia"
          , HH.br_
          , HH.br_
          , HH.text "I'm not actively looking for career opportunities in the "
          , HH.text "functional programming space, although offers are appreciated."
          ]
      , HH.slot_ (Proxy ∷ _ "footer") unit Footer.component unit
      ]

  underlined text color =
    HH.span [ class_ ("underline " <> color) ] [ HH.text text ]

  hyperlink text href =
    HH.a
      [ HP.href href
      , class_ "underline text-white decoration-sky-500 visited:decoration-violet-500"
      ]
      [ HH.text text
      ]
