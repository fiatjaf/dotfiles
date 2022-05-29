// ==UserScript==
// @name         Twitter
// @version      1.0.0
// @description  nada
// @author       fiatjaf
// @include      https://twitter.com/*
// ==/UserScript==

const observer = new MutationObserver(twitterHasChanged)

window.addEventListener('popstate', navigationHasOccurred)
window.addEventListener('resize', navigationHasOccurred)
navigationHasOccurred()
watchForNavigation(navigationHasOccurred)

function twitterHasChanged() {
  let d = document.querySelector('[aria-label="Timeline: Trending now"]')
  if (d) {
    console.log('removing', d)
    d.parentNode.removeChild(d)
    observer.disconnect()

    setTimeout(() => {
      let w = document.querySelector('[aria-label="Who to follow"]')
      if (w) w.parentNode.removeChild(w)
    }, 500)

    setTimeout(() => {
      let r = document.querySelector('[aria-label="Relevant people"]')
      if (r) r.parentNode.removeChild(r)
    }, 500)
  }
}

function navigationHasOccurred() {
  observer.observe(document, {childList: true, subtree: true})
}

function watchForNavigation(cb) {
  const navigationObserver = new MutationObserver(maybeNavigationHasOccurred)
  let previousHref = window.location.href
  function maybeNavigationHasOccurred() {
    if (window.location.href !== previousHref) {
      previousHref = window.location.href
      cb()
    }
  }
  navigationObserver.observe(document.head, {childList: true, subtree: true})
}
