%%raw("
const darkModeStyles = document.createElement('style');
darkModeStyles.textContent = `
  body.tl-dark-mode {
    background-color: #1a1a1a !important;
    color: #ffffff !important;
  }

  body.tl-dark-mode * {
    background-color: #1a1a1a !important;
    color: #ffffff !important;
    border-color: #333333 !important;
  }

  body.tl-dark-mode a {
    color: #66b3ff !important;
  }

  body.tl-dark-mode img {
    filter: brightness(0.8) contrast(1.2) !important;
  }

  body.tl-dark-mode input, 
  body.tl-dark-mode textarea, 
  body.tl-dark-mode select {
    background-color: #333333 !important;
    color: #ffffff !important;
    border: 1px solid #444444 !important;
  }

  body.tl-dark-mode button {
    background-color: #333333 !important;
    color: #ffffff !important;
    border: 1px solid #444444 !important;
  }
`;
    document.head.appendChild(darkModeStyles);
")

type darkModeMsg = {darkMode: bool}

let domainNameFromURL = (url: string): string => {
  switch String.split(url, "/")->Array.get(2) {
  | Some(domain) => domain
  | None => ""
  }
}

let location = %raw(`document.location.href`)
let domain = domainNameFromURL(location)

Chrome.Storage.get([domain], result => {
  switch result {
  | Object(dict) =>
    switch Dict.get(dict, domain) {
    | Some(value) =>
      if value === JSON.Boolean(true) {
        %raw(`
              document.body.classList.add("tl-dark-mode")
              `)->ignore
      }
    | None => ()
    }
  | _ => ()
  }
})

Chrome.Runtime.OnMessage.addListener((message, _, sendResponse) => {
  sendResponse("Received message")

  switch message {
  | {darkMode: isDarkMode} => {
      let value = JSON.Object(Dict.fromArray([(domain, JSON.Boolean(isDarkMode))]))

      Chrome.Storage.set(value, () => ())

      %raw(`
      document.body.classList.toggle("tl-dark-mode")
      `)->ignore
    }
  }

  IsAsync(false)
})
