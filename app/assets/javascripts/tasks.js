// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).on( 'click', '.js-complete-task', function(e) {
  var task_id = this.id;

  $.ajax({
    type: 'POST',
    url: '/complete_task',
    data: { completed_task_id : task_id },
    dataType: 'html',
    success: function(xhr, textStatus) {
      $(".js-habit-" + task_id).fadeOut("slow");
    },
    error: function(xhr, textStatus, errorThrown) {
      alert('Could not complete this task, Please contact an admin.');
    }
  });
});

$( document ).on( 'click', '.js-delete-task', function(e) {
  var task_id = this.id;

  $.ajax({
    type: 'POST',
    url: '/delete_task',
    data: { target_task_id : task_id },
    dataType: 'html',
    success: function(xhr, textStatus) {
      $(".js-habit-" + task_id).fadeOut("slow");
    },
    error: function(xhr, textStatus, errorThrown) {
      alert('Could not delete this task, Please contact an admin.');
    }
  });
});

$( document ).on( 'click', '.js-create-task', function(e) {
  var task_name = $('#name').val();
  var task_description = $('#description').val();

  $.ajax({
    type: 'POST',
    url: '/create_task',
    data: { name: task_name, description: task_description },
    dataType: 'html',
    success: function(xhr, textStatus) {
    },
    error: function(xhr, textStatus, errorThrown) {
      alert('Could not create this task, Please contact an admin.');
    }
  });
});
