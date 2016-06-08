validator = {};

/**
 * Initializes form validation plugin for the provided form.
 *
 * @param {jQuery} $form The form selector.
 */
validator.initValidators = function ($form) {

  var fields = validator.buildFields($('[data-validators]'));

  validator.configureRemoteForm(
    $form.formValidation({
      framework: 'bootstrap',
      icon: validator.bootstrapIcons,
      fields: fields
    })
    .on('err.field.fv', function(e, data) {
      // Hide the messages
      data.element
          .data('fv.messages')
          .find('.help-block[data-fv-for="' + data.field + '"]').hide();
    })
  );
  // By calling Bootstrap Material Design after calling .formValidation()
  // you don't need to adjust the position of feedback icons
  $.material.init();
};

/**
 * Builds and returns a configuration object for all fields
 * that are to be validated on the form.
 *
 * @param {jQuery} $fields All fields containing the 'data-validators' attribute.
 * @returns {object} Object containing validator configurations required by the form validation plugin.
 */
validator.buildFields = function ($fields) {

  var fieldCfg = {};

  $fields.each(function () {

    var validators = $(this).data('validators').split(' ');
    fieldCfg[$(this).attr('name')] = validator.applyValidators(validators);
  });

  return fieldCfg;
};

/**
 * Configures listeners required for a remote form.
 *
 * @param {FormValidation} validationObj FormValidation object for a form.
 */
validator.configureRemoteForm = function (validationObj) {

  validationObj.on('success.form.fv', function (e) {
    // Called when the form is valid
    var $form = $(e.target);
    if ($form.data('remote')) {
      e.preventDefault();
      return false;
    }
  }).on('submit', function (e) {
    var $form = $(e.target);
    if ($form.data('remote')) {
      var numInvalidFields = $form.data('formValidation').getInvalidFields().length;
      if (numInvalidFields) {
        e.preventDefault();
        return false;
      }
    }
    return true;
  });
};

/**
 * Builds and returns the validator object for each passed validator.
 *
 * @param {string[]} validators An array of validator strings.
 * @returns {object} An object configured with all passed validators.
 */
validator.applyValidators = function (validators) {

  var validatorCfg = {};

  for (var i = 0; i < validators.length; i++) {
    if (validator.hasOwnProperty(validators[i])) {
      $.extend(validatorCfg, validator[validators[i]]);
    }
  }

  return {validators: validatorCfg};
};

/**
 * Builds and returns the required onSelect function for a jQuery datepicker to
 * fully integrate with the FormValidation plugin.
 *
 * @param {jQuery} $input The input configured as a datepicker.
 * @returns {Function} The function to perform on the onSelect event.
 */
validator.datePickerOnSelect = function ($input) {
  return function () {
    $input.closest('form').formValidation('revalidateField', $input.attr('name'));
  }
};

/**
 * Default configuration for bootstrap icons.
 * @type {object}
 */
validator.bootstrapIcons = {
  valid: 'glyphicon glyphicon-ok',
  invalid: 'glyphicon glyphicon-remove',
  validating: 'glyphicon glyphicon-refresh'
};


validator.notEmpty = {
  notEmpty: {
    message: 'This field is required'
  }
};

validator.date = {
  date: {
    format: 'MM-DD-YYYY',
    message: 'The date is not a valid'
  }
};

validator.preventFutureDate = {
  callback: {
    message: 'The date cannot be in the future.',
    callback: function (value, validator, $field) {
      return new Date(value.replace(/-/g, "/")) <= new Date()
    }
  }
};

validator.numeric = {
  numeric: {
    message: 'The value is not a number'
  }
};

validator.stringLength = {
  stringLength: {
    message: 'Must be less than %s characters',
    max: function (value, validator, $field) {
      var maxlength = $field.data('maxlength') || 100;
      return maxlength - (value.match(/\r/g) || []).length;
    }
  }
};

validator.file = {
  file: {
    extension: 'jpeg,jpg,tiff,png,pdf',
    type: 'image/jpeg,image/tiff,image/png,application/pdf',
    message: 'Please choose a jpg, jpeg, png, pdf, or tiff file under 4MB.',
    maxSize: 4e+6
  }
};

validator.emailAddress = {
  emailAddress: {
    message: 'The value is not a valid email address'
  }
};

validator.phone = {
  stringLength: {
    message: 'The value is not a valid phone number',
    min: 14
  }
  // FIXME: This does not work. It does not get added
  // to the field configuration when the formValidation
  // object is built. Building the formValidation completely
  // with JS does not work either.
  //
  //phone: {
  //  country: 'US',
  //  message: 'The value is not a valid phone number'
  //}
};

validator.zipCode = {
  regexp: {
    regexp: /^\d{5}$/,
    message: 'The value is not valid zip code'
  }
};

validator.creditCard = {
  creditCard: {
    message: 'The credit card number is not valid'
  }
};
