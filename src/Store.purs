-- | This module contains the global state store.
module Website.Store where

import Routing.PushState (PushStateInterface)

type Store =
  { pushStateInterface :: PushStateInterface
  }

data Action

reduce :: Store -> Action -> Store
reduce store _ = store
