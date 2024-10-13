import 'dart:async';

import 'package:get_it/get_it.dart';
import '../interfaces/i_service_locator_driver.dart';

class GetItDriver implements IServiceLocatorDriver {
  final _getIt = GetIt.I;

  @override
  T call<T extends Object>({
    String? instanceName,
    param1,
    param2,
  }) {
    return _getIt<T>(
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
    return _getIt.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactory<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) {
    return _getIt.registerFactory<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  @override
  void registerFactoryWithParams<T extends Object, P1, P2>(
    T Function(
      P1 p1,
      P2 p2,
    ) factoryFunc, {
    String? instanceName,
  }) {
    return _getIt.registerFactoryParam(
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
    return _getIt.registerLazySingleton<T>(
      singletonFunc,
      instanceName: instanceName,
      dispose: disposingFunction,
    );
  }

  @override
  T registerSingleton<T extends Object>(
    T singleton, {
    String? instanceName,
    bool? signalsReady,
    FutureOr Function(T params)? dispose,
  }) {
    return _getIt.registerSingleton<T>(
      singleton,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: dispose,
    );
  }

  @override
  Future<void> reset({bool dispose = true}) {
    return _getIt.reset(dispose: dispose);
  }

  @override
  FutureOr resetLazySingleton<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(Object p1)? disposingFunc,
  }) {
    return _getIt.resetLazySingleton(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunc,
    );
  }
}
