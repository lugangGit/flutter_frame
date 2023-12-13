// ignore_for_file: non_constant_identifier_names

part of 'app_pages.dart';

// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  static const profile = _Paths.home + _Paths.profile;
  static const products = _Paths.home + _Paths.products;
  static const dashboard = _Paths.home + _Paths.dashboard;

  static const root = _Paths.root;
  static const agreement = _Paths.agreement;
  static const login = _Paths.login;
  static const darkModel = _Paths.darkModel;

  Routes._();
  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static String PRODUCT_DETAILS(String productId) => '$products/$productId';
}

abstract class _Paths {
  static const root = '/';
  static const home = '/home';
  static const products = '/products';
  static const profile = '/profile';
  static const settings = '/settings';
  static const productDetails = '/:productId';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const agreement = '/agreement';
  static const darkModel = '/darkModel';
}
