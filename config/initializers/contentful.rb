require "contentful"

ContentfulClient = Contentful::Client.new(
  space: "qvwo3s6zz3y2",
  access_token: "gf2Pskk-4gfnzt2T54F1LZSwD52uLnckrm1IrMcHXfM",
  environment: "master",
  dynamic_entries: :auto,
  raise_errors: true
)
