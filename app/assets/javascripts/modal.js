$(document).on('turbolinks:load', function(){
  $(document).on('click', '.dish-item-id', function () {
    var id = $(this).attr('data-id');
    $('.orderdish_' + id).show();
  });
  $(document).on('click', '.combo-item-id', function () {
    var id = $(this).attr('data-id');
    $('.ordercombo_' + id).show();
  });
  $(document).on('click', '.cancel-dish-order', function () {
    var data_split = $(this).attr('data-id').split('_');
    var id = data_split[0];
    var order_id = data_split[1];
    var url = '/admin/orders/' + order_id + '/order_dishes/' + id;
    $.ajax({
      url: url,
      type: 'PATCH',
      data: {'order_dish': {'status': 'cancel'}}
    });
  });
  $(document).on('click', '.cancel-combo-order', function () {
    var data_split = $(this).attr('data-id').split('_');
    var id = data_split[0];
    var order_id = data_split[1];
    var url = '/admin/orders/' + order_id + '/order_combos/' + id;
    $.ajax({
      url: url,
      type: 'PATCH',
      data: {'order_combo': {'status': 'cancel'}}
    });
  });

  $(document).on('click', '.btn-show-customer', function() {
    var id = $(this).parent().parent().find('#customer-id').data('id');
    $('.show-info-customer-' + id).show();
  });

  $(document).on('click', '.btn-sign-in', function() {
    $('.customer-sign-in').show();
  });

  $('#login-box').on('ajax:success', function(e, data) {
    if (data.success) {
      location.reload();
      return $('#submit_comment').slideToggle(1000, 'easeOutBack');
    } else {
      $('.error-sign-in-staff').addClass('alert alert-danger').show().html(data.errors);
    }
  });

  $(document).on('click', '.open-sign-in-staff', function() {
    $('.customer-sign-in').hide();
    $('.staff-sign-in').show();
  });

  $(document).on('click', '.open-sign-in-customer', function() {
    $('.staff-sign-in').hide();
    $('.customer-sign-in').show();
  });

  $(document).on('click', '.btn-edit-customer-2', function() {
    $('.show-edit-customer').show();
  });

  $(document).on('click', '.btn-cancel-customer', function () {
    var url = '/admin/customers/' + $(this).attr('data-id');
    $.ajax({
      url: url,
      type: 'PATCH',
      data: {'customer': {'status': 'cancel'}}
    });
  });
});
