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

  // ===============================================WATCHLIST FORM
  // set submit button to be disabled initialially
  var $watch_add_btn = $("#spy-list input:last");
  var $spy_list_val = '';
  $watch_add_btn.attr('disabled', true);

  // on keystroke up check to see if there is value in the box
  // if true then take disabled off button else keep disabled
  $("#spy-list").on('keyup', function(){
    $spy_list_val = $('#spy-list input').val();  // grab value of input box

    if ($spy_list_val.length) {
      $watch_add_btn.attr('disabled', false);
    } else {
      $watch_add_btn.attr('disabled', true);
    }

  });


  // =======================================DELETE STOCK BUTTON
  $('.del-stock').toggle();

  // display delete buttons on all stocks
  $('#main').on('click', 'a#delete', function(e){
    $('.del-stock').toggle('slow');
    e.preventDefault();
  });

});