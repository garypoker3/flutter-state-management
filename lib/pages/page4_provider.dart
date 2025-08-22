import 'package:flutter/material.dart';
import 'package:wizard_controller/models/counter_model.dart';
import 'package:wizard_controller/provider.dart';

// Page 4: Provider (InheritedWidget) approach
// This demonstrates the Provider pattern using InheritedWidget for state sharing
// The shared state is accessible throughout the widget tree without prop drilling
class Page4ProviderCounter extends StatelessWidget {
  const Page4ProviderCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the shared CounterNotifier from the Provider
    CounterNotifier? counterNotifier;
    try {
      counterNotifier = Provider.of(context);
    } catch (e) {
      // Handle case where Provider is not available (e.g., in tests)
      counterNotifier = null;
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.share,
              size: 64,
              color: Colors.purple,
            ),
            const SizedBox(height: 24),
            const Text(
              'Provider Pattern',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Shared state management using InheritedWidget Provider',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // ValueListenableBuilder listens to the shared notifier
            if (counterNotifier != null)
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
                      'Shared counter value:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${value.counter}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ) else
              const Text('0', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              '✨ This counter is shared across all pages!',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.purple,
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
                    Text('• Uses InheritedWidget for state sharing'),
                    Text('• Provider.of(context) accesses shared state'),
                    Text('• No prop drilling - available anywhere in tree'),
                    Text('• Perfect for app-wide state management'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              margin: EdgeInsets.all(16),
              color: Colors.purple,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try navigating between pages!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'You\'ll see the same counter value across all approaches, demonstrating shared state management.',
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
        onPressed: counterNotifier != null ? () {
          // Increment the shared counter
          counterNotifier!.increment();
        } : null,
        tooltip: 'Increment Shared Counter',
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}