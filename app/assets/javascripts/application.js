//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
// require private_pub
//= require jquery_nested_form
//= require handlebars.runtime
//= require rails-timeago

// Libs
//= require bootstrap/js/bootstrap
//= require jquery.validate
//= require jquery.knob
// Theme Initializer
//= require theme.plugins

//= require turbolinks
//= require_tree .



// automatically hide notification
$(document).on('page:update', function () {
    var flashCallback;
    flashCallback = function() {
        return $(".alert").fadeOut();
    };
    $(".alert").bind('click', (function(_this) {
        return function(ev) {
            return $(".alert").fadeOut();
        };
    })(this));
    return setTimeout(flashCallback, 4000);
});
