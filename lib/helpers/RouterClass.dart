import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publish_brand/ui/screen/SplashScreen.dart';
import 'package:publish_brand/ui/screen/intro_screen.dart';

class RouterClass {
  RouterClass._();

  static RouterClass routerClass = RouterClass._();
  GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  pushToScreenByName(String screenName) {
    nav.currentState.pushNamed(screenName);
  }

  pushToScreenByNameWithArguments(
      String screenName, String argument1, String argument2) {
    nav.currentState.pushNamed(screenName, arguments: [argument1, argument2]);
  }

  pushToScreenUsingWidget(Widget widget) {
    //BuildContext context = nav.currentContext;
    BuildContext context = nav.currentState.context;
    nav.currentState.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  pushReplacementToScreen(Widget widget) {
    BuildContext context = nav.currentState.context;
    nav.currentState.pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  popScreen() {
    nav.currentState.pop();
  }

  Map<String, Widget Function(BuildContext)> map = {
    "LoginScreen": (context) => SplashScreen(),
    "SubMenuScreen": (context) => IntroScreen(),
  };

}
