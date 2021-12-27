module Main where

import Prelude

import Data.Either (Either(..), hush)
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.PushState (makeInterface)
import Web.HTML (window)
import Web.HTML.Location as Location
import Web.HTML.Window as Window
import Website.AppM (runAppM)
import Website.Components.Router as Router
import Website.Data.Routes as Routes
import Website.Store as Store

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  initialLocation <- liftEffect $
    window >>= Window.location >>= Location.pathname

  pushStateInterface <- liftEffect makeInterface

  let
    initialStore :: Store.Store
    initialStore = { pushStateInterface }

    initialRoute :: Routes.Route
    initialRoute =
      fromMaybe Routes.NotFound (hush $ parse Routes.codec initialLocation)

  rootComponent <- runAppM initialStore Router.component
  halogenIO <- runUI rootComponent initialRoute body

  liftEffect $ pushStateInterface.listen \location -> do
    case parse Routes.codec location.pathname of
      Left _ ->
        pure unit
      Right route -> launchAff_ do
        halogenIO.query $ H.mkTell $ Router.Navigate route
