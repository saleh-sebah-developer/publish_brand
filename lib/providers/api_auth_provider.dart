import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publish_brand/data/dio_client.dart';
import 'package:publish_brand/data/sp_helper.dart';
import 'package:publish_brand/helpers/RouterClass.dart';
import 'package:publish_brand/models/data_response.dart';
import 'package:publish_brand/models/login_for_users_response.dart';
import 'package:publish_brand/models/sign_up_users_request.dart';
import 'package:publish_brand/models/sign_up_users_response.dart';
import 'package:publish_brand/repositories/firestore_helper.dart';
import 'package:publish_brand/ui/screen/activation_code_screen.dart';
import 'package:publish_brand/ui/screen/home.dart';
import 'package:publish_brand/ui/screen/login_screen.dart';
import 'package:publish_brand/ui/widget/custom_button_y.dart';
import 'package:string_validator/string_validator.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApiAuthProvider extends ChangeNotifier {
  bool btnIsEnable = true;
  bool textIsEnable = true;
  TextEditingController mobileConLogin = TextEditingController();
  TextEditingController passwordConLogin = TextEditingController();
  TextEditingController mobileConSignUp = TextEditingController();
  TextEditingController passwordConSignUp = TextEditingController();
  TextEditingController confirmPasswordConSignUp = TextEditingController();
  TextEditingController nameConSignUp = TextEditingController();
  TextEditingController emailConSignUp = TextEditingController();
  TextEditingController phoneConSignUp = TextEditingController();
  TextEditingController mobileConForgetPassword = TextEditingController();
  TextEditingController emailConForgetPassword = TextEditingController();
  TextEditingController nameConProfile = TextEditingController();
  TextEditingController mobileConProfile = TextEditingController();
  TextEditingController phoneConProfile = TextEditingController();
  TextEditingController emailConProfile = TextEditingController();
  TextEditingController passwordConOldChangePassword = TextEditingController();
  TextEditingController passwordConNewChangePassword = TextEditingController();
  TextEditingController confirmPasswordConNewChangePassword =
      TextEditingController();
  String typeUser = 'user'; // or company
  bool agreeTerms = true;
  int passwordRecoveryOption = 1; // 1 phone  ,  2 email
  User currentUser;
  String mobileVerify = '';

  String validateNull(String value) {
    if (value == null || value.trim().isEmpty) {
      return 'required_field'.tr();
    } else {
      return null;
    }
  }

  String validatePhone(String value) {
    if (value.length != 10) {
      return 'error_phone'.tr();
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    if (!isEmail(value)) {
      return 'in_correct_email_syntax'.tr();
    } else {
      return null;
    }
  }

  String validate(String value) {
    return null;
  }

  String validateConfirmedPassword(String value) {
    if (passwordConSignUp.text != confirmPasswordConSignUp.text) {
      return 'passwords_are_not_matched'.tr();
    } else {
      return null;
    }
  }

  String validateConfirmedPassword2(String value) {
    if (passwordConNewChangePassword.text !=
        confirmPasswordConNewChangePassword.text) {
      return 'passwords_are_not_matched'.tr();
    } else {
      return null;
    }
  }

  changeUserType() {
    typeUser == 'user' ? typeUser = 'company' : typeUser = 'user';
    notifyListeners();
  }

  changeAgreeTerms() {
    agreeTerms == true ? agreeTerms = false : agreeTerms = true;
    notifyListeners();
  }

  changePasswordRecoveryOption() {
    passwordRecoveryOption == 1
        ? passwordRecoveryOption = 2
        : passwordRecoveryOption = 1;
    notifyListeners();
  }

  logOut(BuildContext context) async {
    await Provider.of<SpHelper>(context, listen: false).removeToken();
    RouterClass.routerClass.pushReplacementToScreen(LoginScreen());
  }

  changeEnablity() {
    btnIsEnable = !btnIsEnable;
    notifyListeners();
  }

  changeTextEnablity() {
    textIsEnable = !textIsEnable;
    notifyListeners();
  }

  fillTextFiledProfile() {
    nameConProfile.text = currentUser.name ?? '';
    mobileConProfile.text = currentUser.mobile ?? '';
    phoneConProfile.text = currentUser.phone ?? '';
    emailConProfile.text = currentUser.email ?? '';
    notifyListeners();
  }

  SignUpUsers(BuildContext context) async {
    changeEnablity();
    SignUpUsersRequest signUpUsersRequest = SignUpUsersRequest(
        type: typeUser,
        name: nameConSignUp.text,
        password: passwordConSignUp.text,
        confirm_password: passwordConSignUp.text,
        email: emailConSignUp.text,
        mobile: mobileConSignUp.text,
        phone: phoneConSignUp.text);
    SignUpUsersResponse response =
        await DioClient.dioClient.SignUpUsers(signUpUsersRequest);
    changeEnablity();
    if (response != null) {
      log('register success');
      if (response.status) {
        FirestoreHelper.firestoreHelper.registerUser(response.user);
        RouterClass.routerClass.pushToScreenUsingWidget(
            ActivationCodeScreen(mobileConSignUp.text));
        nameConSignUp.text = '';
        passwordConSignUp.text = '';
        emailConSignUp.text = '';
        mobileConSignUp.text = '';
        phoneConSignUp.text = '';
        notifyListeners();
      } else {
        log(response.status.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('register failed'),
        duration: Duration(seconds: 3),
      ));
      log('register failed');
    }
  }

  LoginForUsers(BuildContext context) async {
    changeEnablity();
    LoginForUsersResponse response = await DioClient.dioClient.LoginForUsers(
        mobile: mobileConLogin.text, password: passwordConLogin.text);
    changeEnablity();
    if (response != null) {
      log('login success');
      if (response.status) {
        await Provider.of<SpHelper>(context, listen: false)
            .setToken(response.user.accessToken.toString());
        RouterClass.routerClass.pushReplacementToScreen(Home());

        mobileConLogin.text = '';
        passwordConLogin.text = '';
        notifyListeners();
      } else if (response.code == 201) {
        RouterClass.routerClass
            .pushToScreenUsingWidget(ActivationCodeScreen(mobileConLogin.text));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      } else {
        log(response.status.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('login failed'),
        duration: Duration(seconds: 3),
      ));
      log('login failed');
    }
  }

  checkCode(BuildContext context, String codeVerify) async {
    changeEnablity();
    LoginForUsersResponse response = await DioClient.dioClient
        .checkCode(mobile: mobileVerify, code: codeVerify);
    changeEnablity();
    if (response != null) {
      log('checkCode success');
      if (response.status) {
        RouterClass.routerClass.pushToScreenUsingWidget(LoginScreen());
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
      log('checkCode failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('checkCode failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  reSendCode(BuildContext context) async {
    changeTextEnablity();
    DataResponse response =
        await DioClient.dioClient.reSendCode(mobile: mobileVerify);
    changeTextEnablity();
    if (response != null) {
      log('reSendCode success');
      if (response.status) {
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
      log('reSendCode failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('reSendCode failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  profile(BuildContext context) async {
    log('profile begin');
    LoginForUsersResponse response = await DioClient.dioClient.profile(context);
    if (response != null) {
      log('profile success');
      if (response.status) {
        currentUser = response.user;
        fillTextFiledProfile();
        notifyListeners();
      } else {
        log(response.message.toString());
      }
    } else {
      log('profile failed');
    }
  }

  changePassword(BuildContext context) async {
    changeEnablity();
    DataResponse response = await DioClient.dioClient.changePassword(context,
        old_password: passwordConOldChangePassword.text,
        password: passwordConNewChangePassword.text,
        confirm_password: confirmPasswordConNewChangePassword.text);
    changeEnablity();
    if (response != null) {
      log('changePassword success');
      if (response.status) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
        RouterClass.routerClass.popScreen();
        passwordConOldChangePassword.text = '';
        passwordConNewChangePassword.text = '';
        confirmPasswordConNewChangePassword.text = '';
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      log('changePassword failed');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('changePassword failed'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  editProfile(BuildContext context) async {
    changeEnablity();
    log('editProfile begin');
    SignUpUsersRequest signUpUsersRequest = SignUpUsersRequest(
        type: typeUser,
        name: nameConProfile.text,
        email: emailConProfile.text,
        mobile: mobileConProfile.text,
        phone: phoneConProfile.text);
    LoginForUsersResponse response =
        await DioClient.dioClient.editProfile(context, signUpUsersRequest);
    changeEnablity();
    if (response != null) {
      log('editProfile success');
      if (response.status) {
        //toast
        RouterClass.routerClass.popScreen();
      } else {
        log(response.status.toString());
      }
    } else {
      log('editProfile failed');
    }
  }

  forgotPassword(BuildContext context) async {
    changeEnablity();
    DataResponse response = await DioClient.dioClient.forgotPassword(
        mobile: passwordRecoveryOption == 1
            ? mobileConForgetPassword.text
            : emailConForgetPassword.text,
        type: passwordRecoveryOption == 1 ? 'mobile' : 'email');
    changeEnablity();
    if (response != null) {
      log('forgotPassword success');
      if (response.status) {
        mobileConForgetPassword.text = '';
        emailConForgetPassword.text = '';
        notifyListeners();
        log(response.message.toString());
        RouterClass.routerClass.popScreen();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message.toString()),
          duration: const Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('forgotPassword failed'),
        duration: Duration(seconds: 3),
      ));
      log('forgotPassword failed');
    }
  }

  checkToken(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    topLeft: Radius.circular(30.r),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: 22, left: 22.w, right: 22.w, bottom: 12.h),
                      child: Text(
                        'please_login_first'.tr(),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                  GestureDetector(
                    onTap: () {
                      RouterClass.routerClass
                          .pushReplacementToScreen(LoginScreen());
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 12, left: 22.w, right: 22.w, bottom: 22.h),
                      child: CustomButtonY(
                        labelText: 'login'.tr(),
                        sizeButton: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
