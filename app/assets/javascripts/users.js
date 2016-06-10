users = {};

users.initNew = function () {
  validator.initValidators($('form'));
};

users.initEdit = function () {
  validator.initValidators($('form'));
};

$( document ).on( 'click', '.js-delete-recipient', function(e) {
  var recipient_id = this.id;

  $.ajax({
    type: 'POST',
    url: '/delete_recipient',
    data: { target_recipient_id: recipient_id },
    dataType: 'html',
    success: function(xhr, textStatus) {
      $(".js-recipient-" + recipient_id).fadeOut("slow");
    },
    error: function(xhr, textStatus, errorThrown) {
      alert('Could not delete this recipient, Please contact an admin.');
    }
  });
});

$( document ).on( 'click', '.js-create-recipient', function(e) {
  var recipient_first_name = $('#first_name').val();
  var recipient_last_name = $('#last_name').val();
  var recipient_email = $('#email').val();

  $.ajax({
    type: 'POST',
    url: '/create_recipient',
    data: { first_name: recipient_first_name, last_name: recipient_last_name, email: recipient_email},
    dataType: 'html',
    success: function(xhr, textStatus) {
      location.reload();
    },
    error: function(xhr, textStatus, errorThrown) {
      alert('Could not create this Recipient, Please contact an admin.');
    }
  });
});
