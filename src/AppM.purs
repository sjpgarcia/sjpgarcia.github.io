-- | This module contains the application monad as well as
-- | implementations of the different capabilities.
module Website.AppM where

import Prelude

import Data.Newtype (class Newtype)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect, liftEffect)
import Halogen as H
import Halogen.Store.Monad (class MonadStore, StoreT, getStore, runStoreT)
import Safe.Coerce (coerce)
import Simple.JSON (write)
import Routing.Duplex as RD
import Website.Capabilities.Navigation (class Navigate)
import Website.Data.Routes as Routes
import Website.Store as Store

newtype AppM a = AppM (StoreT Store.Action Store.Store Aff a)

derive instance Newtype (AppM a) _

derive newtype instance Functor AppM
derive newtype instance Apply AppM
derive newtype instance Applicative AppM
derive newtype instance Bind AppM
derive newtype instance Monad AppM
derive newtype instance MonadEffect AppM
derive newtype instance MonadAff AppM
derive newtype instance MonadStore Store.Action Store.Store AppM

runAppM :: forall q i o. Store.Store -> H.Component q i o AppM -> Aff (H.Component q i o Aff)
runAppM store = runStoreT store Store.reduce <<< coerce

instance Navigate AppM where
  navigate route = do
    { pushStateInterface } <- getStore
    liftEffect do
      pushStateInterface.pushState (write { }) (RD.print Routes.codec route)
