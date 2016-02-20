// CRITICAL that generated/vendor-bundle must be BEFORE bootstrap-sprockets and turbolinks
// since it is exposing jQuery and jQuery-ujs

//= require generated/vendor-bundle
//= require generated/app-bundle
//= require turbolinks
//= require rails-timeago
//= require bootstrap-sprockets

Turbolinks.enableTransitionCache();

jQuery.timeago.settings.allowFuture = true

