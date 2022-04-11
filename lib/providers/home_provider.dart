import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publish_brand/data/dio_client.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/categories_response.dart';
import 'package:publish_brand/models/contact_msg_response.dart';
import 'package:publish_brand/models/get_my_contracts_response.dart';
import 'package:publish_brand/models/get_my_invoices_response.dart';
import 'package:publish_brand/models/get_my_packages_response.dart';
import 'package:publish_brand/models/get_my_points_response.dart';
import 'package:publish_brand/models/get_my_project_details_response.dart';
import 'package:publish_brand/models/get_my_projects_response.dart';
import 'package:publish_brand/models/get_package_details_response.dart';
import 'package:publish_brand/models/get_packages_response.dart';
import 'package:publish_brand/models/get_services_by_category_response.dart';
import 'package:publish_brand/models/get_services_by_points_response.dart';
import 'package:publish_brand/models/get_services_details_response.dart';
import 'package:publish_brand/models/home_response.dart';
import 'package:publish_brand/models/notifications_response.dart';
import 'package:publish_brand/models/page_response.dart';
import 'package:publish_brand/models/request_package_request.dart';
import 'package:publish_brand/models/request_packages_response.dart';
import 'package:publish_brand/models/request_service_request.dart';
import 'package:publish_brand/models/request_service_response.dart';
import 'package:publish_brand/models/request_special_service_response.dart';
import 'package:publish_brand/models/settings_response.dart';
import 'package:publish_brand/ui/screen/order_status.dart';
import 'package:publish_brand/ui/screen/order_status_package.dart';
import 'package:publish_brand/ui/screen/order_status_special.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    homeScreen();
    getCategories();
  }

  bool btnIsEnable = true;

  TextEditingController emailConContactTS = TextEditingController();
  TextEditingController nameConContactTS = TextEditingController();
  TextEditingController mobileConContactTS = TextEditingController();
  TextEditingController messageConContactTS = TextEditingController();
  TextEditingController serviceDetailsConSubmitService =
      TextEditingController();
  TextEditingController discountCodeConSubmitService = TextEditingController();
  TextEditingController projectNameConSubmitSpecialRequests =
      TextEditingController();
  TextEditingController projectDetailsConSubmitSpecialRequests =
      TextEditingController();
  TextEditingController detailsConBouquet = TextEditingController();
  TextEditingController countConService = TextEditingController();
  num totalPrice=1;
  String pageText;
  List<Categories> categories;

  List<Categories> searchCategories = [];
  List<Services> services;

  List<Services> searchServices = [];
  List<Ads> listAds;

  List<Services> servicesByCategory = null;
  List<Services> searchServicesByCategory = [];
  List<ServicesPoint> servicesByPoint;

  List<Data> myProjectsData;
  String project_id;

  AdminChat adminChat;
  CategoryChat categoryChat;
 // Chat chatMyProjects;

  List<Packages> packages;

  List<Point> points;

  List<Invoice> invoices;

  List<Contract> contracts;

  List<ListPackage> listPackage;
  List<Notificat> listNotifications;
  String numPoints = '0';
  Category selectedCategory;
  String nameSelectedCategory = '';
  Service selectedServices;
  bool appear = false;
  String urlApp = '';
  String urlFacebookApp = '';
  String urlTwitterApp = '';
  String urlWhatsappApp = '';
  String urlInstagramApp = '';
  String urlYoutubeApp = '';
  PlatformFile platformFile;
  String packageId = '';

  changeEnablity() {
    btnIsEnable = !btnIsEnable;
    notifyListeners();
  }

  changeStatusAppear() async {
    appear == false ? appear = true : appear = false;
    notifyListeners();
  }

  String validate(String value) {
    return null;
  }

  String validateCount(String value) {
    if (int.parse(value) <= 0) {
      return 'error_count'.tr();
    } else {
      return null;
    }
  }

   totalPriceMethod(String value) {
    totalPrice = int.parse(this.countConService.text) * selectedServices.price;
    notifyListeners();
  }

  homeScreen() async {
    HomeResponse homeResponse = await DioClient.dioClient.homeScreen();
    if (homeResponse != null) {
      log('getCategories success');
      if (homeResponse.status == true) {
        categories = homeResponse.categories;
        services = homeResponse.services;
        listAds = homeResponse.ads;
        notifyListeners();
      } else {
        log(homeResponse.message);
      }
    } else {
      log('getCategories failed');
    }
  }

  clearServicesByCategory() {
    servicesByCategory = null;
    nameSelectedCategory = '';
    notifyListeners();
  }

  getServicesByCategory(int category_id) async {
    GetServicesByCategoryResponse getServicesByCategoryResponse =
        await DioClient.dioClient.getServicesByCategory(category_id);
    if (getServicesByCategoryResponse != null) {
      log('getServicesByCategory success');
      if (getServicesByCategoryResponse.status == true) {
        selectedCategory = getServicesByCategoryResponse.category;
        nameSelectedCategory = getServicesByCategoryResponse.category.name;
        servicesByCategory = getServicesByCategoryResponse.services;
        notifyListeners();
      } else {
        log(getServicesByCategoryResponse.message);
      }
    } else {
      log('getServicesByCategory failed');
    }
    notifyListeners();
  }

  getServicesDetails(int service_id) async {
    selectedServices = null;
    notifyListeners();
    GetServicesDetailsResponse getServicesDetailsResponse =
        await DioClient.dioClient.getServicesDetails(service_id);
    if (getServicesDetailsResponse != null) {
      log('getServicesByCategory success');
      if (getServicesDetailsResponse.status == true) {
        selectedServices = getServicesDetailsResponse.service;
        notifyListeners();
      } else {
        log(getServicesDetailsResponse.message);
      }
    } else {
      log('getServicesByCategory failed');
    }
    notifyListeners();
  }

  getCategories() async {
    CategoriesResponse categoriesResponse =
        await DioClient.dioClient.getCategories();
    if (categoriesResponse != null) {
      log('getCategories success');
      if (categoriesResponse.status == true) {
        categories = categoriesResponse.categories;
        notifyListeners();
      } else {
        log(categoriesResponse.message);
      }
    } else {
      log('getCategories failed');
    }
    notifyListeners();
  }

  clearPagetext() {
    pageText = null;
    notifyListeners();
  }

  pageDetails(int page_id) async {
    clearPagetext();
    PageResponse pageResponse = await DioClient.dioClient.pageDetails(page_id);
    log(pageResponse.page.description);
    if (pageResponse != null) {
      log('pageDetails success');
      if (pageResponse.status == true) {
        pageText = pageResponse.page.description;
      } else {
        pageText = pageResponse.message;
      }
    } else {
      log('pageDetails failed');
    }
    notifyListeners();
  }

  sendContactMsg(BuildContext context) async {
    changeEnablity();
    ContactMsgResponse response = await DioClient.dioClient.sendContactMsg(
      email: emailConContactTS.text,
        name: nameConContactTS.text,
        phone: mobileConContactTS.text,
        message: messageConContactTS.text);
    changeEnablity();
    if (response != null) {
      log('pageDetails success');
      if (response.status == true) {
        log(response.message.toString());
        RouterClass.routerClass.popScreen();
        emailConContactTS.text = '';
        nameConContactTS.text = '';
        mobileConContactTS.text = '';
        messageConContactTS.text = '';
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      } else {
        log(response.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('pageDetails failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('pageDetails failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  requestService(BuildContext context) async {
    changeEnablity();
    log('requestService begin');
    RequestServiceRequest requestServiceRequest = RequestServiceRequest(
        service_id: selectedServices.id.toString(),
        details: serviceDetailsConSubmitService.text,
        coupon: discountCodeConSubmitService.text,
        quantity: countConService.text);
    RequestServiceResponse response = await DioClient.dioClient
        .requestService(context, requestServiceRequest);
    changeEnablity();
    if (response != null) {
      log('requestService success');
      if (response.status) {
        RouterClass.routerClass.pushToScreenUsingWidget(OrderStatus());
        serviceDetailsConSubmitService.text = '';
        discountCodeConSubmitService.text = '';
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('requestService failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('requestService failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  requestSpecialService(BuildContext context) async {
    changeEnablity();
    RequestSpecialServiceResponse response = await DioClient.dioClient
        .requestSpecialService(context,
            title: projectNameConSubmitSpecialRequests.text,
            details: projectDetailsConSubmitSpecialRequests.text);
    changeEnablity();
    if (response != null) {
      log('requestSpecialService success');
      if (response.status) {
        RouterClass.routerClass.pushToScreenUsingWidget(OrderStatusSpecial());
        projectNameConSubmitSpecialRequests.text = '';
        projectDetailsConSubmitSpecialRequests.text = '';
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('requestSpecialService failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('requestSpecialService failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  clearMyProjects() {
    myProjectsData = null;
    notifyListeners();
  }

  getMyProjects(BuildContext context) async {
    clearMyProjects();
    log('getMyProjects begin');
    GetMyProjectsResponse response =
        await DioClient.dioClient.getMyProjects(context);
    if (response != null) {
      log('getMyProjects success');
      if (response.status) {
        log('done');
        myProjectsData = response.myProjects.data;

        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyProjects failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyProjects failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getMyProjectDetails(BuildContext context, String project_id) async {
    log('getMyProjects begin');
    GetMyProjectDetailsResponse response =
        await DioClient.dioClient.getMyProjectDetails(context, project_id);
    if (response != null) {
      log('getMyProjects success');
      if (response.status) {
        log('done');
        adminChat = response.project.adminChat;
        categoryChat = response.project.categoryChat;
        //chatMyProjects = response.project.chat;
        notifyListeners();
      } else {
        log(response.status.toString());
      }
    } else {
      log('getMyProjects failed');
    }
    notifyListeners();
  }

  getPackages(BuildContext context) async {
    log('getPackages begin');
    GetPackagesResponse response =
        await DioClient.dioClient.getPackages(context);
    if (response != null) {
      log('getPackages success');
      if (response.status) {
        packages = response.packages;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getPackages failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getPackages failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getPackageDetails(BuildContext context, String package_id) async {
    log('getPackageDetails begin');
    GetPackageDetailsResponse response =
        await DioClient.dioClient.getPackageDetails(context, package_id);
    if (response != null) {
      log('getPackageDetails success');
      if (response.status) {
        log('done');
        // packages = response.packages;
        notifyListeners();
      } else {
        log(response.status.toString());
      }
    } else {
      log('getPackageDetails failed');
    }
    notifyListeners();
  }

  getMyPoints(BuildContext context) async {
    log('getMyPoints begin');
    GetMyPointsResponse response =
        await DioClient.dioClient.getMyPoints(context);
    if (response != null) {
      log('getMyPoints success');
      if (response.status) {
        log('done');
        points = response.myPoints.data;
        numPoints = response.myPoints.total.toString();
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyPoints failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyPoints failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getMyContracts(BuildContext context) async {
    log('getMyContracts begin');
    GetMyContractsResponse response =
        await DioClient.dioClient.getMyContracts(context);
    if (response != null) {
      log('getMyContracts success');
      if (response.status) {
        log('done');
        contracts = response.myContracts.data;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyContracts failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyContracts failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getMyPackages(BuildContext context) async {
    log('getMyPackages begin');
    GetMyPackagesResponse response =
        await DioClient.dioClient.getMyPackages(context);
    if (response != null) {
      log('getMyPackages success');
      if (response.status) {
        log('done');
        listPackage = response.myPackages.data;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyPackages failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyPackages failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getMyInvoices(BuildContext context) async {
    log('getMyInvoices begin');
    GetMyInvoicesResponse response =
        await DioClient.dioClient.getMyInvoices(context);
    if (response != null) {
      log('getMyInvoices success');
      if (response.status) {
        log('done');
        invoices = response.myInvoices.data;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyInvoices failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyInvoices failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  settingsApiApp(BuildContext context) async {
    log('settingsApiApp begin');
    SettingsResponse response =
        await DioClient.dioClient.settingsApiApp(context);
    if (response != null) {
      log('settingsApiApp success');
      if (response.status) {
        log('done');
        urlApp = response.settings.url;
        urlFacebookApp = response.settings.facebook;
        urlTwitterApp = response.settings.twitter;
        urlWhatsappApp = response.settings.whatsapp;
        urlInstagramApp = response.settings.instagram;
        urlYoutubeApp = response.settings.youtube;

        notifyListeners();
      } else {
        log(response.status.toString());
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.red,
        //   content: Text(response.message.toString()),
        //   duration: const Duration(seconds: 3),
        // ));
      }
    } else {
      log('settingsApiApp failed');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: Colors.red,
      //   content: Text('settingsApiApp failed'),
      //   duration: Duration(seconds: 3),
      // ));
    }
    notifyListeners();
  }

  getMyNotifications(BuildContext context) async {
    log('getMyNotifications begin');
    NotificationsResponse response =
        await DioClient.dioClient.getMyNotifications(context);
    if (response != null) {
      log('getMyNotifications success');
      if (response.status) {
        log('done');
        listNotifications = response.notifications.data;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getMyNotifications failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getMyNotifications failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  getServicesByPoints(BuildContext context) async {
    log('getServicesByPoints begin');
    GetServicesByPointsResponse response =
        await DioClient.dioClient.getServicesByPoints(context);
    if (response != null) {
      log('getServicesByPoints success');
      if (response.status) {
        log('done');
        servicesByPoint = response.services;
        notifyListeners();
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('getServicesByPoints failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('getServicesByPoints failed'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();
  }

  requestPackages(BuildContext context, PlatformFile file) async {
    changeEnablity();
    log('requestService begin');
    RequestPackageRequest requestPackageRequest = RequestPackageRequest(
      package_id: packageId,
      details: detailsConBouquet.text,
    );
    RequestPackagesResponse response = await DioClient.dioClient
        .requestPackages(context, requestPackageRequest, file);
    changeEnablity();
    if (response != null) {
      log('requestService success');
      if (response.status) {
        RouterClass.routerClass.pushToScreenUsingWidget(OrderStatusPackage());
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('requestService failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('requestService failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  searchHomeScreen(String value) {
    //valueSearch = value;
    searchCategories = categories
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    searchServices = services
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
    log(searchCategories.length.toString());
    log(searchServices.length.toString());
    // log(searchController.text.toString());
  }

  searchServiceScreen(String value) {
    searchServicesByCategory = servicesByCategory
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
    log(servicesByCategory.length.toString());
  }

 uploadFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      final file = result.files.first;
      platformFile = file;
      notifyListeners();
      log('Name: ' + file.name.toString());
      log('extension: ' + file.extension.toString());
      log('path: ' + file.path.toString());
      // File file = File(result.files.single.path);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text('File saved'),
        duration: Duration(seconds: 3),
      ));
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('File Not saved'),
        duration: Duration(seconds: 3),
      ));
    }
    notifyListeners();

  }

  downloadFile() async {
    final taskId = await FlutterDownloader.enqueue(
      url: 'your download link',
      savedDir: 'the path of directory where you want to save downloaded files',
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }
}
