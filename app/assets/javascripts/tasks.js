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
      setTimeout(function(){
        location.reload();
      }, 2000);
    },
    error: function(xhr, textStatus, errorThrown) {
      setTimeout(function(){
        location.reload();
      }, 2000);
    }
  });
});

var ready, set_positions;

$(window).load(function() {
  set_positions();

  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  // after the order changes
  $('#sortable').sortable().bind('sortupdate', function(e, ui) {
    // array to store new order
    updated_order = []
    // set the updated positions
    set_positions();

    // populate the updated_order array with the new task positions
    $('.panel').each(function(i){
      updated_order.push({ id: $(this).data("id"), position: i+1 });
    });

    // send the updated order via ajax
    $.ajax({
      type: "PUT",
      url: '/tasks/sort',
      data: { order: updated_order }
    });
  });
});

set_positions = function(){
  // loop through and give each task a data-pos
  // attribute that holds its position in the DOM
  $('.panel.panel-default').each(function(i){
    $(this).attr("data-pos",i+1);
  });
}
