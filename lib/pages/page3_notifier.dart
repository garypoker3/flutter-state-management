import 'package:flutter/material.dart';
import 'package:wizard_controller/models/counter_model.dart';
import 'package:wizard_controller/provider.dart';

// Page 3: CounterNotifier with ValueListenableBuilder approach
// This demonstrates reactive programming using ValueNotifier and ValueListenableBuilder
// The UI automatically rebuilds when the notifier's value changes - NO StatefulWidget needed!
class Page3NotifierCounter extends StatelessWidget {
  const Page3NotifierCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the shared CounterNotifier directly - no local state needed!
    CounterNotifier? counterNotifier;
    try {
      counterNotifier = Provider.of(context);
    } catch (e) {
      // Handle case where Provider is not available (e.g., in tests)
      counterNotifier = null;
    }

    if (counterNotifier == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_active,
              size: 64,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'CounterNotifier Approach',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Reactive state management with ValueNotifier & ValueListenableBuilder',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // ValueListenableBuilder automatically rebuilds when notifier changes
            // This is the key: NO StatefulWidget or setState() needed!
            ValueListenableBuilder<CounterModel>(
              valueListenable: counterNotifier,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Text(
                      'Username: ${value.username}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Counter value:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${value.counter}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
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
                    Text('• Uses ValueNotifier for reactive state'),
                    Text('• ValueListenableBuilder rebuilds automatically'),
                    Text('• NO StatefulWidget or setState() needed!'),
                    Text('• Efficient - only rebuilds listening widgets'),
                    Text('• Clean separation of UI and business logic'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              margin: EdgeInsets.all(16),
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This is now a StatelessWidget!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ValueListenableBuilder handles all the reactive updates automatically.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Directly call the notifier's increment method
          // ValueListenableBuilder will automatically rebuild the UI
          counterNotifier?.increment();
        },
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}