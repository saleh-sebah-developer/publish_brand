import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/models/categories_response.dart';
import 'package:publish_brand/models/contact_msg_response.dart';
import 'package:publish_brand/models/data_response.dart';
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
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/models/notifications_response.dart';
import 'package:publish_brand/models/page_response.dart';
import 'package:publish_brand/models/request_package_request.dart';
import 'package:publish_brand/models/request_packages_response.dart';
import 'package:publish_brand/models/request_service_request.dart';
import 'package:publish_brand/models/request_service_response.dart';
import 'package:publish_brand/models/request_special_service_response.dart';
import 'package:publish_brand/models/settings_response.dart';
import 'package:publish_brand/models/sign_up_users_request.dart';
import 'package:publish_brand/models/sign_up_users_response.dart';
import '../models/get_chat_message_response.dart';
import '../models/send_message_request.dart';
import 'api_constants.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class DioClient {
  DioClient._() {
    initDio();
  }

  static final DioClient dioClient = DioClient._();
  Dio dio;

  initDio() {
    dio = Dio();
    dio.options.baseUrl = ApiConstant.baseUrl;
    dio.options.headers['Accept-Language'] = 'ar';

    // if (context.locale == Locale('en')) {
    //   dio.options.headers['Accept-Language'] = 'en';
    // } else {
    //   dio.options.headers['Accept-Language'] = 'ar';
    // }
  }

  // --- Auth
  //----------------------
  Future<SignUpUsersResponse> SignUpUsers(
      SignUpUsersRequest signUpUsersRequest) async {
    try {
      log(signUpUsersRequest.toJson().toString());
      Response response = await dio.post(ApiConstant.signUpUsers,
          data: signUpUsersRequest.toJson());
      SignUpUsersResponse signUpUsersResponse =
          SignUpUsersResponse.fromJson(response.data);
      return signUpUsersResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future<LoginForUsersResponse> LoginForUsers(
      {String mobile, String password}) async {
    try {
      Response response = await dio.post(ApiConstant.loginForUsers,
          data: {'mobile': mobile, 'password': password});
      LoginForUsersResponse loginForUsersResponse =
          LoginForUsersResponse.fromJson(response.data);
      return loginForUsersResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<LoginForUsersResponse> checkCode({String mobile, String code}) async {
    try {
      Response response = await dio
          .post(ApiConstant.checkCode, data: {'mobile': mobile, 'code': code});
      LoginForUsersResponse loginForUsersResponse =
          LoginForUsersResponse.fromJson(response.data);
      return loginForUsersResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DataResponse> reSendCode({String mobile}) async {
    try {
      Response response =
          await dio.post(ApiConstant.reSendCode, data: {'mobile': mobile});
      DataResponse dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<LoginForUsersResponse> profile(BuildContext context) async {
    try {
      Response response = await dio.get(ApiConstant.profile,
          options: Options(headers: {
            'Authorization': 'Bearer ' +
                await Provider.of<SpHelper>(context, listen: false).getToken()
          }));

      LoginForUsersResponse loginForUsersResponse =
          LoginForUsersResponse.fromJson(response.data);
      return loginForUsersResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DataResponse> changePassword(BuildContext context,
      {String old_password, String confirm_password, String password}) async {
    try {
      Response response = await dio.post(
        ApiConstant.changePassword,
        data: {
          'old_password': old_password,
          'confirm_password': confirm_password,
          'password': password,
        },
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      DataResponse dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<LoginForUsersResponse> editProfile(
      BuildContext context, SignUpUsersRequest signUpUsersRequest) async {
    try {
      log(signUpUsersRequest.toJson().toString());
      Response response = await dio.post(
        ApiConstant.editProfile,
        data: signUpUsersRequest.toJson(),
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      LoginForUsersResponse loginForUsersResponse =
          LoginForUsersResponse.fromJson(response.data);
      return loginForUsersResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DataResponse> forgotPassword({String mobile, String type}) async {
    try {
      Response response = await dio.post(ApiConstant.forgotPassword,
          data: {'mobile': mobile, 'type': type});
      DataResponse dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  // --- Home
  //----------------------

  Future<HomeResponse> homeScreen() async {
    try {
      Response response = await dio.get(ApiConstant.homeScreen);
      HomeResponse homeResponse = HomeResponse.fromJson(response.data);
      return homeResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetServicesByCategoryResponse> getServicesByCategory(
      int category_id) async {
    try {
      Response response = await dio.get(ApiConstant.getServicesByCategory,
          queryParameters: {'category_id': category_id});
      GetServicesByCategoryResponse getServicesByCategoryResponse =
          GetServicesByCategoryResponse.fromJson(response.data);
      return getServicesByCategoryResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetServicesDetailsResponse> getServicesDetails(int service_id) async {
    try {
      Response response = await dio.get(ApiConstant.getServicesDetails,
          queryParameters: {'service_id': service_id});
      GetServicesDetailsResponse getServicesDetailsResponse =
          GetServicesDetailsResponse.fromJson(response.data);
      return getServicesDetailsResponse;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<CategoriesResponse> getCategories() async {
    try {
      Response response = await dio.get(ApiConstant.getCategories);
      CategoriesResponse categoriesResponse =
          CategoriesResponse.fromJson(response.data);
      return categoriesResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<PageResponse> pageDetails(int page_id) async {
    try {
      Response response = await dio
          .get(ApiConstant.pageDetails, queryParameters: {'page_id': page_id});
      PageResponse pageResponse = PageResponse.fromJson(response.data);
      return pageResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ContactMsgResponse> sendContactMsg(
      {String name, String phone, String message}) async {
    try {
      Response response = await dio.post(ApiConstant.sendContactMsg,
          data: {'name': name, 'phone': phone, 'message': message});
      ContactMsgResponse contactMsgResponse =
          ContactMsgResponse.fromJson(response.data);
      return contactMsgResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

// --- Services
//----------------------

  Future<RequestServiceResponse> requestService(
      BuildContext context, RequestServiceRequest requestServiceRequest) async {
    try {
      Response response = await dio.post(
        ApiConstant.requestService,
        data: requestServiceRequest.toJson(),
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      RequestServiceResponse requestServiceResponse =
          RequestServiceResponse.fromJson(response.data);
      return requestServiceResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<RequestSpecialServiceResponse> requestSpecialService(
      BuildContext context,
      {String title,
      String details}) async {
    try {
      Response response = await dio.post(
        ApiConstant.requestSpecialService,
        data: {'title': title, 'details': details},
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      RequestSpecialServiceResponse requestSpecialServiceResponse =
          RequestSpecialServiceResponse.fromJson(response.data);
      return requestSpecialServiceResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyProjectsResponse> getMyProjects(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyProjects,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      GetMyProjectsResponse getMyProjectsResponse =
          GetMyProjectsResponse.fromJson(response.data);
      return getMyProjectsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyProjectDetailsResponse> getMyProjectDetails(
      BuildContext context, String project_id) async {
    try {
      Response response = await dio.get(ApiConstant.getMyProjectDetails,
          options: Options(headers: {
            'authorization': 'Bearer ' +
                await Provider.of<SpHelper>(context, listen: false).getToken()
          }),
          queryParameters: {'project_id': project_id});
      GetMyProjectDetailsResponse getMyProjectDetailsResponse =
          GetMyProjectDetailsResponse.fromJson(response.data);
      return getMyProjectDetailsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetPackagesResponse> getPackages(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getPackages,
      );
      GetPackagesResponse getPackagesResponse =
          GetPackagesResponse.fromJson(response.data);
      return getPackagesResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetPackageDetailsResponse> getPackageDetails(
      BuildContext context, String package_id) async {
    try {
      Response response = await dio.get(ApiConstant.getPackageDetails,
          queryParameters: {'package_id': package_id});
      GetPackageDetailsResponse getPackageDetailsResponse =
          GetPackageDetailsResponse.fromJson(response.data);
      return getPackageDetailsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyPointsResponse> getMyPoints(
    BuildContext context,
  ) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyPoints,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      GetMyPointsResponse getMyPointsResponse =
          GetMyPointsResponse.fromJson(response.data);
      return getMyPointsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyContractsResponse> getMyContracts(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyContracts,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      GetMyContractsResponse getMyContractsResponse =
          GetMyContractsResponse.fromJson(response.data);
      return getMyContractsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyPackagesResponse> getMyPackages(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyPackages,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      GetMyPackagesResponse getMyPackagesResponse =
          GetMyPackagesResponse.fromJson(response.data);
      return getMyPackagesResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetMyInvoicesResponse> getMyInvoices(
    BuildContext context,
  ) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyInvoices,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      GetMyInvoicesResponse getMyInvoicesResponse =
          GetMyInvoicesResponse.fromJson(response.data);
      return getMyInvoicesResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<SettingsResponse> settingsApiApp(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.settingsApiApp,
      );
      SettingsResponse settingsResponse =
          SettingsResponse.fromJson(response.data);
      return settingsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<NotificationsResponse> getMyNotifications(BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getMyNotifications,
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      NotificationsResponse notificationsResponse =
          NotificationsResponse.fromJson(response.data);
      return notificationsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GetServicesByPointsResponse> getServicesByPoints(
      BuildContext context) async {
    try {
      Response response = await dio.get(
        ApiConstant.getServicesByPoints,
      );
      GetServicesByPointsResponse getServicesByPointsResponse =
          GetServicesByPointsResponse.fromJson(response.data);
      return getServicesByPointsResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<RequestPackagesResponse> requestPackages(BuildContext context,
      RequestPackageRequest requestPackageRequest, PlatformFile file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        ...requestPackageRequest.toJson(),
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await dio.post(
        ApiConstant.requestPackages,
        data: formData,
        //   data: requestPackageRequest.toJson(),
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      RequestPackagesResponse requestPackagesResponse =
          RequestPackagesResponse.fromJson(response.data);
      return requestPackagesResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

//----------------------------------------------------------------------------
//------------------------------------    chats        -----------------------
//----------------------------------------------------------------------------

  Future<getChatMessageResponse> getChatMessage(
      BuildContext context, String package_id) async {
    try {
      Response response = await dio.get(
        ApiConstant.getChatMessage,
        queryParameters: {'project_id': package_id},
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      getChatMessageResponse chatMessageResponse =
          getChatMessageResponse.fromJson(response.data);
      return chatMessageResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<DataResponse> sendMessage(
      BuildContext context, SendMessageRequest sendMessageRequest) async {
    try {
      Response response = await dio.post(
        ApiConstant.sendMessage,
        data: sendMessageRequest.toJson(),
        options: Options(headers: {
          'authorization': 'Bearer ' +
              await Provider.of<SpHelper>(context, listen: false).getToken()
        }),
      );
      DataResponse requestServiceResponse =
          DataResponse.fromJson(response.data);
      return requestServiceResponse;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
