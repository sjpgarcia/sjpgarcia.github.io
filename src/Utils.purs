module Website.Utils where

import Halogen as H
import Halogen.HTML.Properties as HP

class_ :: forall r i. String -> HP.IProp ( "class" :: String | r ) i
class_ name = HP.class_ (H.ClassName name)
