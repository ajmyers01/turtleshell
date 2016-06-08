$(document).on('ready', function () {

    // TODO: Leave this until we figure out it's purpose
    ////called from a bootstrap dropdown, this closes the dropdown
    //$('a[data-toggle=modal]').on('click', function () {
    //    $('.dropdown').removeClass('open')
    //});
    //
    ////removes whatever is in the modal body content div upon clicking close/outside modal
    //$(document).on('click', '[data-dismiss=modal], .modal-scrollable', function () {
    //    $('.modal-body-content').empty()
    //});
    //
    //$(document).on('click', '#form-modal', function (e) {
    //    e.stopPropagation();
    //});

});

formModal = {};

/**
 * Replaces the content in the modal with the passed form and
 * performs any callback.
 *
 * @param {string} title The title for the modal.
 * @param {string} form The form to be rendered as HTML
 * @param {Function} callback A function to call after the form has
 *  been added to the modal. Recommended that any needed JS (date pickers,
 *  google apis, etc.) needed for the form be initialized in this callback.
 */
formModal.renderFormModal = function (title, form, callback) {

    var loader = '.ajax-loader';
    var content = '.modal-body-content';
    var dataRemote = 'a[data-remote=true]';
    var toolbar = 'div.modal-footer';
    var modal = '#form-modal';

    // Update the title of the modal.
    $('.modal-title').html(title);

    // Replace the content of the modal with the new form.
    $(content).html(form);

    if (callback) {
        callback();
    }
};

/**
 * Prevents the form being submitted with the enter key.
 * Defaults to finding the form within an instance of the form
 * modal.
 *
 * @param {boolean} [modal] False to use the $('form') selector rather
 * than the form for the modal.
 */
formModal.preventEnterSubmission = function (modal) {

  var $form = $('#form-modal').find('form');

  if (modal === false) {
    $form = $('form');
  }

  $form.on('keypress', function (e) {
    if (e.keyCode == 13) {
      return false
    }
  });
};
