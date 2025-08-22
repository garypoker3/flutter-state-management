import 'package:flutter/material.dart';
import 'package:wizard_controller/models/counter_model.dart';

class Provider extends InheritedWidget {
   const Provider(this.notifier, {super.key, required super.child});

   //final CounterModel data;
   final CounterNotifier notifier;

   static CounterNotifier of(BuildContext context) {
     final provider = context.dependOnInheritedWidgetOfExactType<Provider>();
     return provider!.notifier;
   }

   @override
   bool updateShouldNotify(Provider oldWidget) {
     return notifier.value != oldWidget.notifier.value;
   }
 }