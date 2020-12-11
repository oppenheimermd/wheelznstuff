import 'package:get_it/get_it.dart';
import 'package:wheelznstuff/core/view_models/homeVM.dart';

import 'core/services/api.dart';
import 'core/services/api_service.dart';
/*import 'package:provider_architecture/core/services/api.dart';
import 'package:provider_architecture/core/services/authentication_service.dart';
import 'package:provider_architecture/core/view_models/comments_model.dart';
import 'package:provider_architecture/core/view_models/homemodel.dart';
import 'package:provider_architecture/core/view_models/login_model.dart';

import 'core/services/api_service.dart';*/

GetIt locator = GetIt.instance;

void setupLocator() {
  //  Register the LoginModel with the locator as a lazy singleton
  //  See: https://www.filledstacks.com/snippet/dependency-injection-in-flutter/
  locator.registerLazySingleton(() => HomeVM());
  locator.registerLazySingleton<ApiService>( () => Api());
  //locator.registerLazySingleton<MyAuthenticationService>( () => AuthenticationService());
  //locator.registerLazySingleton(() => AuthenticationService());
  //  We'll use a {Factory] for home model.  This means that every time
  //  you request this type it creates a new one.
  //locator.registerFactory(() =>HomeModel());
  //locator.registerFactory(() => CommentsModel());
}