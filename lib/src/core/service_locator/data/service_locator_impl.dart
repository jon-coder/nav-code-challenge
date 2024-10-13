import 'dart:async';

import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/core/service_locator/infra/interfaces/i_service_locator_driver.dart';

class ServiceLocatorImpl implements IServiceLocator {
  ServiceLocatorImpl(this._driver);
  final IServiceLocatorDriver _driver;

  @override
  T call<T extends Object>({
    String? instanceName,
    param1,
    param2,
  }) {
    return _driver<T>(
      instanceName: instanceName,
      param1: param1,
      param2: param2,
    );
  }

  @override
  bool isRegistered<T extends Object>({
    T? instance,
    String? instanceName,
  }) {
    return _driver.isRegistered(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) {
    return _driver.registerFactory(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactoryWithParams<T extends Object, P1, P2>(
    T Function(P1 p1, P2 p2) factoryFunc, {
    String? instanceName,
  }) {
    return _driver.registerFactoryWithParams(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    T Function() singletonFunc, {
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunction,
  }) {
    return _driver.registerLazySingleton(
      singletonFunc,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }

  @override
  T registerSingleton<T extends Object>(
    T singleton, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T params)? dispose,
  }) {
    return _driver.registerSingleton(
      singleton,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
  }

  @override
  Future<void> reset({bool dispose = true}) {
    return _driver.reset(dispose: dispose);
  }

  @override
  FutureOr resetLazySingleton<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunc,
  }) {
    return _driver.resetLazySingleton(
      instance: instance,
      instanceName: instanceName,
      disposingFunc: disposingFunc,
    );
  }
}
