//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){

  $(".add-product").on("click", function(e){
    $(".product-form").slideDown();
    $(this).slideUp();
    e.preventDefault();
  });

  $(".cancel-form").on("click", function(e){
    $(".product-form").slideUp();
    $(".add-product").slideDown();
    e.preventDefault();
  });

  if($("ul.errors li").length > 0) {
    $(".add-product").hide();
    $(".product-form").show();
  }

});