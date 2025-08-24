import 'package:flutter/material.dart';
import 'package:wizard_controller/models/counter_model.dart';
import 'package:wizard_controller/provider.dart';
import 'package:wizard_controller/pages/page1_stateful.dart';
import 'package:wizard_controller/pages/page2_counter_model.dart';
import 'package:wizard_controller/pages/page3_notifier.dart';
import 'package:wizard_controller/pages/page4_provider.dart';

void main() {
  runApp(
    Provider(
      CounterNotifier(CounterModel(username: "Tadas")),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter State Demo Home Page'),
    );
  }
}

// Wizard-style demo app showing different state management approaches
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Page titles for each state management approach
  final List<String> _pageTitles = [
    "Page 1: StatefulWidget",
    "Page 2: CounterModel", 
    "Page 3: CounterNotifier",
    "Page 4: Provider Pattern",
  ];

  // Page descriptions
  final List<String> _pageDescriptions = [
    "Basic Flutter counter using StatefulWidget with setState",
    "Using immutable CounterModel class for state management",
    "CounterNotifier with ValueListenableBuilder for reactive updates", 
    "Provider pattern with InheritedWidget for state sharing",
  ];

  Future<void> _nextPage() async {
    if (_currentPage < 3) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _previousPage() async {
    if (_currentPage > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_pageTitles[_currentPage]),
      ),
      body: Column(
        children: [
          // Page indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentPage
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
          // Page description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _pageDescriptions[_currentPage],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // PageView with the different counter implementations
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                Page1StatefulCounter(),
                Page2CounterModel(), 
                Page3NotifierCounter(),
                Page4ProviderCounter(),
              ],
            ),
          ),
          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  child: const Text('<< Previous'),
                ),
                Text(
                  'Page ${_currentPage + 1} of 4',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ElevatedButton(
                  onPressed: _currentPage < 3 ? _nextPage : null,
                  child: const Text('Next >>'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
