let getCurrentTab = (callback: option<Chrome.tab> => unit) => {
  let queryInfo: Chrome.queryInfo = {
    active: true,
    lastFocusedWindow: true,
  }

  Chrome.Tabs.query(queryInfo, (tabs: array<Chrome.tab>) => {
    callback(tabs->Array.get(0))
  })
}

let domainNameFromURL = (url: string): string => {
  switch String.split(url, "/")->Array.get(2) {
  | Some(domain) => domain
  | None => ""
  }
}
