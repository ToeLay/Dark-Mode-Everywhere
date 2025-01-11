@react.component
let make = () => {
  let (url, setURL) = React.useState(() => "")
  let (isLightMode, setIsLightMode) = React.useState(() => true)
  let (currentTab, setCurrentTab) = React.useState(() => None)

  React.useEffect(() => {
    Utils.getCurrentTab(tab => {
      setCurrentTab(_ => tab)
      switch tab {
      | Some(t) => {
          let domainName = Utils.domainNameFromURL(t.url)
          setURL(_ => domainName)
        }
      | None => ()
      }
    })
    None
  }, [])

  let onModeChange = _ => {
    setIsLightMode(isLightMode => !isLightMode)

    let tabId = switch currentTab {
    | Some(tab) => tab.id
    | None => -1
    }

    Chrome.Tabs.sendMessage(tabId, {"darkMode": isLightMode}, _ => ())
  }

  <div className="w-64 max-w-md bg-gray-900 text-white shadow-lg select-none">
    <div className="p-4 border-b border-gray-800">
      <h2 className="text-center text-lg"> {React.string(url)} </h2>
    </div>
    {isLightMode
      ? <div className="flex justify-center py-8 bg-gray-900">
          <button onClick={onModeChange}>
            <LightModeIcon />
          </button>
        </div>
      : <div className="flex justify-center py-8 bg-white">
          <button onClick={onModeChange}>
            <DarkModeIcon />
          </button>
        </div>}
  </div>
}
