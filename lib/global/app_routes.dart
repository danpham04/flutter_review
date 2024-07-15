import 'package:flutter/material.dart';
import 'package:flutter_review/model/user_model.dart';
import 'package:flutter_review/screens/home_screens/home/widget/create_user/create_infor.dart';
import 'package:flutter_review/screens/home_screens/home/widget/edit_user/edit_user.dart';
import 'package:flutter_review/screens/home_screens/home/widget/show_infor.dart';
import 'package:flutter_review/screens/home_screens/home_screens.dart';
import 'package:flutter_review/screens/home_screens/search_user/my_search.dart';
import 'package:flutter_review/screens/login/login.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => makeRoute(
          context: context,
          routeName: settings.name!,
          arguments: settings.arguments),
    );
  }

  static makeRoute({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) {
    switch (routeName) {
      case login:
        return const Login();
      case homeScress:
        return const HomeScress();
      case showInfor:
        return ShowInfor(showUser: arguments as UserModel);
      case createData:
        return const CreateInfor();
      case updateData:
        return EditUser(users: arguments as UserModel);
      case search:
        return const MySearch();
      default:
        throw 'Route  $routeName is not define';
    }
  }

  // define named Routes
  static const String login = '/login';
  static const String homeScress = '/';
  static const String showInfor = '/show_infor';
  static const String createData = '/create_data';
  static const String updateData = '/update_data';
  static const String search = 'search_user';
}
