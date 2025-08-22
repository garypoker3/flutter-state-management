import 'package:flutter/material.dart';
import 'package:wizard_controller/provider.dart';

// Page 1: Classic StatefulWidget approach
// This demonstrates the original Flutter counter app approach using setState()
// for managing local component state
class Page1StatefulCounter extends StatefulWidget {
  const Page1StatefulCounter({super.key});

  @override
  State<Page1StatefulCounter> createState() => _Page1StatefulCounterState();
}

class _Page1StatefulCounterState extends State<Page1StatefulCounter> {
  // Local state variable - this is the traditional approach
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // setState() tells Flutter to rebuild this widget
      // This is the most basic form of state management in Flutter
      _counter++;
      
      // Also update the shared counter so other pages can see the same value
      try {
        final counterNotifier = Provider.of(context);
        counterNotifier.value = counterNotifier.value.copyWith(counter: _counter);
      } catch (e) {
        // Handle case where Provider is not available (e.g., in tests)
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize local counter with shared counter value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final counterNotifier = Provider.of(context);
        setState(() {
          _counter = counterNotifier.value.counter;
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
              Icons.widgets,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'StatefulWidget Approach',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Traditional Flutter state management using setState()',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                    Text('• Uses local state variable (_counter)'),
                    Text('• Calls setState() to trigger rebuild'),
                    Text('• State is managed within the widget'),
                    Text('• Simple but not scalable for complex apps'),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}