/**
 * Creates an object mapping specific body classes to init functions.
 * Since the initializer is not fired until the document is ready,
 * you can be assured that all JS files have been loaded. STRONGLY
 * RECOMMENDED that any new functionality that is added be added
 * inside this function due to the aforementioned situation.
 */
$(document).on('ready', function () {

  var bodyClass = $('body').attr('class');

  // Object containing all initializers for
  // each controller action pair.
  var initializers = {
    'users new': users.initNew,
    'users edit': users.initEdit,
    'sessions new': sessions.initNew
  };

  if (initializers.hasOwnProperty(bodyClass)) {
    initializers[bodyClass]();
  }

  // Always initialize tooltips
  $('[rel*=tooltip]').tooltip();
});

/**
 * Shows warning to the user when leaving the current page.
 * Only shows if the form is dirty. Skips showing for delete confirmations.
 */
function bindWindowUnload(reinit) {

  if(typeof reinit === typeof undefined || reinit !== true) {
    var isDirty = false;
    var isSubmit = false;
  }

  $(document).on('change', 'input, select, textarea', function (e) {
    isDirty = true;
  });

  $('form').submit(function () {
    isSubmit = true;
  });

  $(document).on('confirm:complete', function (e, answer) {
    if (answer) {
      $(window).off('beforeunload');
    }
  });

  $(window).on('beforeunload', function (e) {
    if (isDirty && !isSubmit) {
      var message = 'You have unsaved changes!';
      e = e || window.event;

      if (e) {
        e.returnValue = message;
      }
      return message;
    }
  });
}

function defaultDisabledTooltip(value) {}
