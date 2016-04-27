// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){

  // ===============================================ADD STOCK FORM
  // set submit button to be disabled initialially
  var $stock_add_btn = $("#add-stock input:last");
  var $add_stock_val = '';
  $stock_add_btn.attr('disabled', true);

  // on keystroke up check to see if there is value in the box
  // if true then take disabled off button else keep disabled
  $("#add-stock").on('keyup', function(){
    $add_stock_val = $('#add-stock input').val();  // grab value of input box

    if ($add_stock_val.length) {
      $stock_add_btn.attr('disabled', false);
    } else {
      $stock_add_btn.attr('disabled', true);
    }

  });


  // =======================================DELETE STOCK BUTTON
  $('.del-stock').toggle();

  $('#main').on('click', 'a#delete', function(e){
    $('.del-stock').toggle();
    e.preventDefault();
  });

});