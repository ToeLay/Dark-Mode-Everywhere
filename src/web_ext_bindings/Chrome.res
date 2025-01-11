type tab = {
  active: bool,
  audible: bool,
  autoDiscardable: bool,
  discarded: bool,
  favIconUrl: string,
  frozen: bool,
  groupId: int,
  height: int,
  highlighted: bool,
  id: int,
  incognito: bool,
  index: int,
  lastAccessed: int,
  //   mutedInfo: {
  //     muted: bool,
  //     reason: string,
  //   },
  openerTabId: int,
  pendingUrl: string,
  pinned: bool,
  selected: bool,
  sessionId: string,
  //status: string,
  title: string,
  url: string,
  width: int,
  windowId: int,
}

type stringOrArray =
  | Single(string)
  | Multiple(array<string>)

type queryInfo = {
  active?: bool,
  audible?: bool,
  autoDiscardable?: bool,
  currentWindow?: bool,
  discarded?: bool,
  frozen?: bool,
  highlighted?: bool,
  lastFocusedWindow?: bool,
  muted?: bool,
  pinned?: bool,
  //status?: TypeForStatus, // TODO: Add support for status
  groupId?: int,
  index?: int,
  windowId?: int,
  title?: string,
  url?: stringOrArray,
  //windowType?: TypeForWindowType, // TODO: Add support for windowType
}

type sendMessageOptions = {
  documentId?: string,
  frameId?: int,
}

module Tabs = {
  // Bindings for the chrome.tabs API
  @val external query: (queryInfo, array<tab> => unit) => unit = "chrome.tabs.query"
  @val external sendMessage: (int, 'message, 'response => unit) => unit = "chrome.tabs.sendMessage"
  @val
  external sendMessageWithOptions: (int, 'message, sendMessageOptions, 'response => unit) => unit =
    "chrome.tabs.sendMessage"
}

module Runtime = {
  // Bindings for the chrome.runtime API
  type messageSender = {
    documentId?: string,
    documentLifeCycle?: string,
    frameId?: int,
    id?: int,
    nativeApplication?: string,
    origin?: string,
    tab?: tab,
    tlsChannelId?: string,
    url?: string,
  }

  type addListenerReturnType =
    | IsAsync(bool)
    | NoReturn(unit)

  module OnMessage = {
    @val
    external addListener: (
      ('message, messageSender, 'param => unit) => addListenerReturnType
    ) => unit = "chrome.runtime.onMessage.addListener"
  }
}

module Storage = {
  // Bindings for the chrome.storage API
  @val external get: (array<string>, JSON.t => unit) => unit = "chrome.storage.local.get"
  @val external set: (JSON.t, unit => unit) => unit = "chrome.storage.local.set"
}
