import 'package:flutter/material.dart';
import 'package:wizard_controller/models/counter_model.dart';
import 'package:wizard_controller/provider.dart';

// Page 2: CounterModel approach
// This demonstrates using an immutable data class (CounterModel) for state management
// The model is immutable, so we create new instances with copyWith()
class Page2CounterModel extends StatefulWidget {
  const Page2CounterModel({super.key});

  @override
  State<Page2CounterModel> createState() => _Page2CounterModelState();
}

class _Page2CounterModelState extends State<Page2CounterModel> {
  // Local state using immutable CounterModel
  CounterModel _counterModel = CounterModel(username: "");

  void _incrementCounter() {
    setState(() {
      // Create a new CounterModel instance with updated counter
      // This demonstrates the immutability principle
      _counterModel = _counterModel.copyWith(counter: _counterModel.counter + 1);
      
      // Also update the shared counter so other pages can see the same value
      try {
        final counterNotifier = Provider.of(context);
        counterNotifier.value = counterNotifier.value.copyWith(counter: _counterModel.counter);
      } catch (e) {
        // Handle case where Provider is not available (e.g., in tests)
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize local counter model with shared counter value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final counterNotifier = Provider.of(context);
        setState(() {
          _counterModel = CounterModel(
            username: counterNotifier.value.username,
            counter: counterNotifier.value.counter,
          );
        });
      } catch (e) {
        // Handle case where Provider is not available (e.g., in tests)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.data_object,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            const Text(
              'CounterModel Approach',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Using immutable data classes for better state management',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            if (_counterModel.username.isNotEmpty) ...[
              Text(
                'Username: ${_counterModel.username}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Counter value:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${_counterModel.counter}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 32),
            const Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How it works:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('• Uses immutable CounterModel class'),
                    Text('• Creates new instances with copyWith()'),
                    Text('• Prevents accidental state mutations'),
                    Text('• Better structure for complex state'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}