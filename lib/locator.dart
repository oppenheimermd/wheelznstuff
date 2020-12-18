import 'package:get_it/get_it.dart';
import 'package:wheelznstuff/core/services/FirestoreService.dart';
import 'package:wheelznstuff/core/services/dialog_service.dart';
import 'package:wheelznstuff/core/services/navigation_manager.dart';
import 'package:wheelznstuff/core/services/navigation_service.dart';
import 'package:wheelznstuff/core/view_models/homeVM.dart';
import 'package:wheelznstuff/core/view_models/startupVM.dart';

import 'core/services/auth_service.dart';
import 'core/services/authenticationManager.dart';
import 'core/services/fake_api_service.dart';
import 'core/view_models/loginVM.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  //  Register the LoginModel with the locator as a lazy singleton
  //  See: https://www.filledstacks.com/snippet/dependency-injection-in-flutter/
  locator.registerLazySingleton(() => NavigationManager());
  locator.registerLazySingleton(() => HomeVM());
  locator.registerLazySingleton(() => LoginVM());
  locator.registerLazySingleton(() => StartUpVM());
  locator.registerLazySingleton(() => FakeApiService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationManager());
  locator.registerLazySingleton(() => FirestoreService());
  //locator.registerLazySingleton(() => AuthenticationService());
  //  We'll use a {Factory] for home model.  This means that every time
  //  you request this type it creates a new one.
  //locator.registerFactory(() =>HomeModel());
  //locator.registerFactory(() => CommentsModel());
}