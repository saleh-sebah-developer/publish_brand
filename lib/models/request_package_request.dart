class RequestPackageRequest {
  String package_id;
  String details;
  String contract_file;
  String payment_method_id;
  String coupon;
  String card_number;
  String expired_date;
  String validation_number;
  String name_cardholder;

  RequestPackageRequest(
      {this.package_id,
      this.details,
      this.contract_file,
      this.payment_method_id,
      this.coupon,
      this.card_number,
      this.expired_date,
      this.validation_number,
      this.name_cardholder});

  toJson() {
    return {
      'package_id': package_id,
      'details': details,
      'contract_file': contract_file,
      'payment_method_id': payment_method_id,
      'coupon': coupon,
      'card_number': card_number,
      'expired_date': expired_date,
      'validation_number': validation_number,
      'name_cardholder': name_cardholder
    };
  }
}
