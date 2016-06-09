// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( document ).on( 'click', '.js-complete-task', function(e) {
  var task_id = e.target.id;

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
  var task_id = e.target.id;

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
