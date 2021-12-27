let app

function main() {
  if (process.env.NODE_ENV === "production") {
    app = require("../dist/index.js").main()
  } else {
    app = require("../output/Main/index.js").main()
  }
}

if (module.hot) {
  module.hot.accept(function() {
    app != null && typeof app.kill === "function" && app.kill()
    Array.prototype.forEach.call(
      document.querySelectorAll("#root>div"),
      function(d) { d.remove() },
    )
    main()
  })
}

main()
