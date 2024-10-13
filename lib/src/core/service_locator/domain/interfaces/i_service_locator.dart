import 'dart:async';

import 'package:navalia_code_challenge/src/core/service_locator/data/service_locator_impl.dart';
import 'package:navalia_code_challenge/src/core/service_locator/infra/interfaces/i_service_locator_driver.dart';

typedef SL = IServiceLocator;

abstract interface class IServiceLocator {
  static final IServiceLocator _instance = ServiceLocatorImpl(
    IServiceLocatorDriver.instance,
  );

  static final I = _instance;
  static final instance = _instance;

  T call<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  bool isRegistered<T extends Object>({
    T? instance,
    String? instanceName,
  });

  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  });

  void registerFactoryWithParams<T extends Object, P1, P2>(
    T Function(P1, P2) factoryFunc, {
    String? instanceName,
  });

  T registerSingleton<T extends Object>(
    T singleton, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T params)? dispose,
  });

  void registerLazySingleton<T extends Object>(
    T Function() singletonFunc, {
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunction,
  });

  Future<void> reset({bool dispose = true});

  FutureOr resetLazySingleton<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunc,
  });
}
