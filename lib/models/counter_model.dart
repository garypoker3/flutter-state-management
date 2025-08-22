import 'package:flutter/material.dart';

class CounterModel {
  CounterModel({
    required this.username,
    this.counter = 0,
  });

  final String username;
  final int counter;

  CounterModel copyWith({
    final String? username,
    final int? counter,
  }) {
    return CounterModel(
      username: username ?? this.username,
      counter: counter ?? this.counter,
    );
  }
}

//single source of truth. 
//With the ChangeNotifier, we made the data private so that nobody could modify it outside the ChangeNotifier. 
//With ValueNotifier, the data is immutable, so it can’t be modified by definition. Data can only change for either by using the functions defined within.

class CounterNotifier extends ValueNotifier<CounterModel> {
  CounterNotifier(super.state);

  void increment() {
    value = value.copyWith(counter: value.counter + 1);
  }
}