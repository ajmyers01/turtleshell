// Name of file and namespace will change based on application name.
enspire = {};

/**
 *
 * @param {jQuery} $el The element to be shown/hidden.
 * @param {boolean} [hide] Pass true to hide the element,
 * pass false to show the element, undefined will toggle the element.
 */
enspire.toggleElement = function($el, hide) {
  if (hide === true) {
    $el.addClass('hidden');
  } else if (hide === false) {
    $el.removeClass('hidden');
  } else {
    if ($el.hasClass('hidden')) {
      $el.removeClass('hidden');
    } else {
      $el.addClass('hidden');
    }
  }
};
