import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ValueListenableExtensions<T> on ValueListenable<T> {
  ValueListenableBuilder<T> observer(
      {required Widget Function(BuildContext, T, Widget?) builder}) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: builder,
    );
  }
}

extension ValueNotifierExtension<T> on ValueNotifier<T> {
  void setValue(T value) {
    this.value = value;
  }
}
