-- | This component is the top-most component in the application, and is
-- | responsible for routing the user around the single-page application.
-- | It takes the starting `Route` as input, and can be queried in order
-- | to switch the pages.
module Website.Components.Router where

import Prelude

import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))
import Website.Data.Routes (Route(..))
import Website.Pages.Home as Home
import Website.Pages.NotFound as NotFound
import Website.Utils (class_)

data Query a = Navigate Route a

component :: forall o m. MonadAff m => H.Component Query Route o m
component =
  H.mkComponent
  { initialState
  , render
  , eval: H.mkEval H.defaultEval
      { handleQuery = handleQuery
      }
  }
  where
  -- The initial state is simply whatever initial route was passed by
  -- the root component.
  initialState route = route

  -- Component rendering is simply a function that takes the current
  -- state and returns some `HTML` to be rendered using the VDOM and
  -- into the page itself.
  --
  -- In this case, we're not actually emitting HTML directly, instead,
  -- we're making used of Halogen's Slots feature in order to render
  -- different components.
  --
  -- In order, here are the arguments for the `slot` function:
  -- * the slot label
  -- * the slot address
  -- * the component
  -- * the component input
  --
  -- There are a few things to take note here:
  -- 1. The `slot_` function is a synonym of the `slot` function that
  --    omits the last parameter—which is used to translate component
  --    outputs into parent actions. Usually, this would just be some
  --    constructor in the `Action` data type of the parent component.
  --
  -- 2. The slot label is to a group of components, as an address is
  --    to the individual components themselves. This allows us to
  --    either query groups of components or just one.
  render route = 
    HH.div [ class_ "md:px-32 md:py-2" ]
      [ case route of 
        Home -> 
          HH.slot_ (Proxy :: _ "home") unit Home.component unit
        NotFound ->
          HH.slot_ (Proxy :: _ "notFound") unit NotFound.component unit
      ]
  -- The type annotations are here to ensure that the `a` parameter
  -- does not escape its skolem scope due to type inference. But...
  -- why? Halogen is built on the concept of free monads, and this `a`
  -- parameter actually represents the next action to be taken. By
  -- returning a `None`, instead of `Just a`, you're essentially
  -- telling Halogen that something went wrong somewhere.
  handleQuery :: forall a. Query a -> _ (Maybe a)
  handleQuery = case _ of
    Navigate route a -> do
      H.put route
      pure (Just a)
