class SettingsResponse {
  bool status;
  int code;
  String message;
  Settings settings;

  SettingsResponse({this.status, this.code, this.message, this.settings});

  SettingsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (settings != null) {
      data['settings'] = settings.toJson();
    }
    return data;
  }
}

class Settings {
  int id;
  String url;
  String logo;
  String appStoreUrl;
  String playStoreUrl;
  String infoEmail;
  String mobile;
  String phone;
  String facebook;
  String twitter;
  String linkedIn;
  String instagram;
  String youtube;
  String whatsapp;
  String latitude;
  String longitude;
  String image;
  int rowsPaginationCount;
  String counterTime;
  String counterYesNo;
  int deliveryCostByMeter;
  AboutUs aboutUs;
  AboutUs privacy;
  AboutUs termsConditions;
  AboutUs aboutLoyaltyPoints;
  AboutUs howToRequestServices;
  AboutUs priceDetails;
  AboutUs serviceDetails;
  AboutUs contactTechnicalSupport;
  AboutUs servicePolicies;
  AboutUs specialOrders;
  List<PaymentMethods> paymentMethods;
  String title;
  String address;
  String description;

  Settings(
      {this.id,
        this.url,
        this.logo,
        this.appStoreUrl,
        this.playStoreUrl,
        this.infoEmail,
        this.mobile,
        this.phone,
        this.facebook,
        this.twitter,
        this.linkedIn,
        this.instagram,
        this.youtube,
        this.whatsapp,
        this.latitude,
        this.longitude,
        this.image,
        this.rowsPaginationCount,
        this.counterTime,
        this.counterYesNo,
        this.deliveryCostByMeter,
        this.aboutUs,
        this.privacy,
        this.termsConditions,
        this.aboutLoyaltyPoints,
        this.howToRequestServices,
        this.priceDetails,
        this.serviceDetails,
        this.contactTechnicalSupport,
        this.servicePolicies,
        this.specialOrders,
        this.paymentMethods,
        this.title,
        this.address,
        this.description});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    logo = json['logo'];
    appStoreUrl = json['app_store_url'];
    playStoreUrl = json['play_store_url'];
    infoEmail = json['info_email'];
    mobile = json['mobile'];
    phone = json['phone'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedIn = json['linked_in'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    whatsapp = json['whatsapp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    rowsPaginationCount = json['rows_pagination_count'];
    counterTime = json['counter_time'];
    counterYesNo = json['counter_yes_no'];
    deliveryCostByMeter = json['delivery_cost_by_meter'];
    aboutUs = json['about_us'] != null
        ? AboutUs.fromJson(json['about_us'])
        : null;
    privacy =
    json['privacy'] != null ? AboutUs.fromJson(json['privacy']) : null;
    termsConditions = json['terms_conditions'] != null
        ? AboutUs.fromJson(json['terms_conditions'])
        : null;
    aboutLoyaltyPoints = json['about_loyalty_points'] != null
        ? AboutUs.fromJson(json['about_loyalty_points'])
        : null;
    howToRequestServices = json['how_to_request_services'] != null
        ? AboutUs.fromJson(json['how_to_request_services'])
        : null;
    priceDetails = json['price_details'] != null
        ? AboutUs.fromJson(json['price_details'])
        : null;
    serviceDetails = json['service_details'] != null
        ? AboutUs.fromJson(json['service_details'])
        : null;
    contactTechnicalSupport = json['contact_technical_support'] != null
        ? AboutUs.fromJson(json['contact_technical_support'])
        : null;
    servicePolicies = json['service_policies'] != null
        ? AboutUs.fromJson(json['service_policies'])
        : null;
    specialOrders = json['special_orders'] != null
        ? AboutUs.fromJson(json['special_orders'])
        : null;
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods.add(PaymentMethods.fromJson(v));
      });
    }
    title = json['title'];
    address = json['address'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['logo'] = logo;
    data['app_store_url'] = appStoreUrl;
    data['play_store_url'] = playStoreUrl;
    data['info_email'] = infoEmail;
    data['mobile'] = mobile;
    data['phone'] = phone;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linked_in'] = linkedIn;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['whatsapp'] = whatsapp;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image'] = image;
    data['rows_pagination_count'] = rowsPaginationCount;
    data['counter_time'] = counterTime;
    data['counter_yes_no'] = counterYesNo;
    data['delivery_cost_by_meter'] = deliveryCostByMeter;
    if (aboutUs != null) {
      data['about_us'] = aboutUs.toJson();
    }
    if (privacy != null) {
      data['privacy'] = privacy.toJson();
    }
    if (termsConditions != null) {
      data['terms_conditions'] = termsConditions.toJson();
    }
    if (aboutLoyaltyPoints != null) {
      data['about_loyalty_points'] = aboutLoyaltyPoints.toJson();
    }
    if (howToRequestServices != null) {
      data['how_to_request_services'] = howToRequestServices.toJson();
    }
    if (priceDetails != null) {
      data['price_details'] = priceDetails.toJson();
    }
    if (serviceDetails != null) {
      data['service_details'] = serviceDetails.toJson();
    }
    if (contactTechnicalSupport != null) {
      data['contact_technical_support'] =
          contactTechnicalSupport.toJson();
    }
    if (servicePolicies != null) {
      data['service_policies'] = servicePolicies.toJson();
    }
    if (specialOrders != null) {
      data['special_orders'] = specialOrders.toJson();
    }
    if (paymentMethods != null) {
      data['payment_methods'] =
          paymentMethods.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['address'] = address;
    data['description'] = description;
    return data;
  }
}

class AboutUs {
  int id;
  String image;
  int views;
  String title;
  Null slug;
  String description;
  Null keyWords;

  AboutUs(
      {this.id,
        this.image,
        this.views,
        this.title,
        this.slug,
        this.description,
        this.keyWords});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    views = json['views'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    keyWords = json['key_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['views'] = views;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['key_words'] = keyWords;
    return data;
  }
}

class PaymentMethods {
  int id;
  String image;
  String status;
  String createdAt;
  String name;

  PaymentMethods({this.id, this.image, this.status, this.createdAt, this.name});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}
