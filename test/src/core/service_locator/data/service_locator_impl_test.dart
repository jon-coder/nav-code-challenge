import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navalia_code_challenge/src/core/service_locator/data/service_locator_impl.dart';
import 'package:navalia_code_challenge/src/core/service_locator/domain/interfaces/i_service_locator.dart';
import 'package:navalia_code_challenge/src/core/service_locator/infra/interfaces/i_service_locator_driver.dart';

class _MockServiceLocatorDriver extends Mock implements IServiceLocatorDriver {}

class TestClassType {}

void main() {
  late IServiceLocatorDriver serviceLocatorDriver;
  late IServiceLocator serviceLocator;

  setUp(() {
    serviceLocatorDriver = _MockServiceLocatorDriver();
    serviceLocator = ServiceLocatorImpl(serviceLocatorDriver);
  });

  group('Method call -', () {
    test('Should throw [$StateError] when [$TestClassType] is not registered',
        () {
      when(() => serviceLocatorDriver.call<TestClassType>()).thenThrow(
        StateError(''),
      );

      final result = serviceLocator.call<TestClassType>;

      expect(() => result(), throwsA(isA<StateError>()));
      verify(() => serviceLocatorDriver.call<TestClassType>()).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test('Should return an instance of [$TestClassType] when it is registered',
        () {
      final tClass = TestClassType();
      when(() => serviceLocatorDriver.call<TestClassType>()).thenReturn(tClass);

      final result = serviceLocator.call<TestClassType>();

      expect(result, isA<TestClassType>());
      verify(
        () => serviceLocatorDriver.call<TestClassType>(),
      ).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });
  group('Method isRegistered -', () {
    test('Should return [false] when [$TestClassType] is not registered', () {
      when(() => serviceLocatorDriver.isRegistered<TestClassType>())
          .thenReturn(false);

      final result = serviceLocator.isRegistered<TestClassType>();

      expect(result, false);
      verify(() => serviceLocatorDriver.isRegistered<TestClassType>())
          .called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test('Should return [true] when [$TestClassType] is registered', () {
      when(() => serviceLocatorDriver.isRegistered<TestClassType>())
          .thenReturn(true);

      final result = serviceLocator.isRegistered<TestClassType>();

      expect(result, true);
      verify(() => serviceLocatorDriver.isRegistered<TestClassType>())
          .called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });

  group('Method registerFactory -', () {
    test(
        'Should throw [$ArgumentError] when $TestClassType is already registered with same instance name ',
        () {
      TestClassType func() => TestClassType();
      when(
        () => serviceLocatorDriver.registerFactory<TestClassType>(func),
      ).thenThrow(ArgumentError());

      final action = serviceLocator.registerFactory<TestClassType>;

      expect(() => action(func), throwsA(isA<ArgumentError>()));
      verify(() => serviceLocatorDriver.registerFactory(func)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test(
        'Should register [$TestClassType] when instance name is not used or type is not registered',
        () {
      TestClassType func() => TestClassType();
      when(
        () => serviceLocatorDriver.registerFactory<TestClassType>(func),
      ).thenReturn(null);

      serviceLocator.registerFactory<TestClassType>(func);

      verify(() => serviceLocatorDriver.registerFactory(func)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });

  group('Method registerFactoryWIthParams', () {
    test(
        'Should throw an [$ArgumentError] when [$TestClassType] is already registered with same instance name',
        () {
      TestClassType func(_, __) => TestClassType();
      when(() => serviceLocatorDriver
          .registerFactoryWithParams<TestClassType, int, int>(func)).thenThrow(
        ArgumentError(),
      );

      final action =
          serviceLocator.registerFactoryWithParams<TestClassType, int, int>;

      expect(() => action(func), throwsA(isA<ArgumentError>()));
      verify(() => serviceLocatorDriver
          .registerFactoryWithParams<TestClassType, int, int>(func)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test(
        'Should register an [$TestClassType] with params when instance name is not used or type is not registered',
        () {
      TestClassType func(_, __) => TestClassType();
      when(
        () => serviceLocatorDriver
            .registerFactoryWithParams<TestClassType, int, int>(func),
      ).thenReturn(null);

      serviceLocator.registerFactoryWithParams<TestClassType, int, int>(func);

      verify(
        () => serviceLocatorDriver
            .registerFactoryWithParams<TestClassType, int, int>(func),
      ).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });

  group('Mehtod registerSingleton =', () {
    test(
        'Should throw an [$ArgumentError] when $TestClassType is already registered with same instance name',
        () {
      final tClass = TestClassType();
      when(() => serviceLocatorDriver.registerSingleton<TestClassType>(tClass))
          .thenThrow(ArgumentError());

      final action = serviceLocator.registerSingleton<TestClassType>;

      expect(() => action(tClass), throwsA(isA<ArgumentError>()));
      verify(() =>
              serviceLocatorDriver.registerSingleton<TestClassType>(tClass))
          .called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test(
        'Should register [$TestClassType] when instance name is not used or type is not registered',
        () {
      final tClass = TestClassType();
      when(() => serviceLocatorDriver.registerSingleton<TestClassType>(tClass))
          .thenReturn(tClass);

      final result = serviceLocator.registerSingleton<TestClassType>(tClass);

      expect(result.hashCode, tClass.hashCode);
      expect(result.runtimeType, tClass.runtimeType);
      verify(() => serviceLocatorDriver.registerSingleton(tClass)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });

  group('Method registerLazySingleton -', () {
    test(
        'Should throw an [$ArgumentError] when $TestClassType is already registered with same instance name',
        () {
      TestClassType tFunc() => TestClassType();
      when(() =>
              serviceLocatorDriver.registerLazySingleton<TestClassType>(tFunc))
          .thenThrow(ArgumentError());

      final action = serviceLocator.registerLazySingleton<TestClassType>;

      expect(() => action(tFunc), throwsA(isA<ArgumentError>()));
      verify(() => serviceLocatorDriver.registerLazySingleton(tFunc)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test(
        'Should register [$TestClassType] when instance name is not used or type is not registered',
        () {
      final tClass = TestClassType();
      TestClassType tFunc() => tClass;
      when(() =>
              serviceLocatorDriver.registerLazySingleton<TestClassType>(tFunc))
          .thenReturn(null);

      serviceLocator.registerLazySingleton<TestClassType>(tFunc);

      expect(tClass.hashCode, tFunc().hashCode);
      expect(tClass.runtimeType, tFunc().runtimeType);
      verify(() => serviceLocatorDriver.registerLazySingleton(tFunc)).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });

  group('Method reset -', () {
    test('Should call reset only once', () {
      when(() => serviceLocatorDriver.reset()).thenAnswer((i) async {
        return;
      });

      serviceLocator.reset();

      verify(() => serviceLocatorDriver.reset()).called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });

    test('Should reset lazySingleton', () {
      final tClass = TestClassType();
      when(() => serviceLocatorDriver.resetLazySingleton(instance: tClass))
          .thenAnswer((invocation) => invocation);

      serviceLocator.resetLazySingleton(instance: tClass);

      verify(() => serviceLocatorDriver.resetLazySingleton(instance: tClass))
          .called(1);
      verifyNoMoreInteractions(serviceLocatorDriver);
    });
  });
}
