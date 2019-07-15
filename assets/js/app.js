// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from '../css/app.css';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html';

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

const PRISM_SOLARIZED_LIGHT_CSS =
  'https://cdnjs.cloudflare.com/ajax/libs/prism/1.16.0/themes/prism-solarizedlight.min.css';
const PRISM_TOMORROW_NIGHT_CSS = 'https://cdnjs.cloudflare.com/ajax/libs/prism/1.16.0/themes/prism-tomorrow.min.css';
const prismLinkTag = document.getElementById('prism-theme');

// https://kevinchen.co/blog/support-macos-mojave-dark-mode-on-websites/
const darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');
function toggleDarkMode(e) {
  if (e.matches) {
    // Is dark mode
    prismLinkTag.href = PRISM_TOMORROW_NIGHT_CSS;
  } else {
    // Is light mode
    prismLinkTag.href = PRISM_SOLARIZED_LIGHT_CSS;
  }
}
darkModeQuery.addListener(toggleDarkMode);
document.addEventListener('DOMContentLoaded', function() {
  toggleDarkMode(darkModeQuery);
});
