class RequestServiceRequest {
  String service_id;
  String details;
  String payment_method_id;
  String coupon;
  String card_number;
  String expired_date;
  String validation_number;
  String name_cardholder;
  String quantity;

  RequestServiceRequest(
      {this.service_id,
      this.details,
      this.payment_method_id,
      this.coupon,
      this.card_number,
      this.expired_date,
      this.validation_number,
      this.name_cardholder,
      this.quantity});

  toJson() {
    return {
      'service_id': service_id,
      'details': details,
      'payment_method_id': payment_method_id,
      'coupon': coupon,
      'card_number': card_number,
      'expired_date': expired_date,
      'validation_number': validation_number,
      'validation_number': validation_number,
      'quantity': quantity
    };
  }
}
