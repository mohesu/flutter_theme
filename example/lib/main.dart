import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme/flutter_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final ThemeService themeService = ThemeServiceHive('theme_v5');
  await themeService.init();
  runApp(
    ProviderScope(
      child: MyApp(
        themeService: themeService,
      ),
    ),
  );
}

final themeControllerFutureProvider =
    FutureProvider.family<ThemeController, ThemeService>(
  (ref, themeService) async {
    final controller = ref.watch(themeControllerProvider(themeService));
    await controller.loadAll();
    return controller;
  },
);

class MyApp extends ConsumerWidget {
  final ThemeService themeService;
  const MyApp({Key? key, required this.themeService}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSnapshot =
        ref.watch(themeControllerFutureProvider(themeService));
    return themeSnapshot.when(
      data: (controller) => AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Flutter Theme',
            debugShowCheckedModeBanner: kDebugMode,
            scrollBehavior: const AppScrollBehavior(),
            theme: controller.useFlexColorScheme
                ? flexThemeLight(controller)
                : themeDataLight(controller),
            darkTheme: controller.useFlexColorScheme
                ? flexThemeDark(controller)
                : themeDataDark(controller),
            themeMode: controller.themeMode,
            home: MyHomePage(
              title: "Flutter Theme",
              themeService: themeService,
            ),
          );
        },
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final ThemeService themeService;
  const MyHomePage({Key? key, required this.title, required this.themeService})
      : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++; // for increment
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController =
        ref.watch(themeControllerProvider(widget.themeService));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: const Text('Theme mode'),
              subtitle: Text('Mode ${themeController.themeMode.name}'),
              trailing: ThemeModeSwitch(
                themeMode: themeController.themeMode,
                onChanged: themeController.setThemeMode,
              ),
              // Toggle theme mode also via the ListTile tap.
              onTap: () {
                if (Theme.of(context).brightness == Brightness.light) {
                  themeController.setThemeMode(ThemeMode.dark);
                } else {
                  themeController.setThemeMode(ThemeMode.light);
                }
              },
            ),
            ThemeSelector(controller: themeController),
            ListTile(
              title: const Text('Reset preferences'),
              subtitle: const Text('Reset all settings to default.'),
              trailing: Card(
                child: IconButton(
                  tooltip: 'Reset preferences',
                  icon: const Icon(Icons.replay_rounded),
                  onPressed: () async {
                    final bool? reset = await showDialog<bool?>(
                      context: context,
                      builder: (BuildContext context) {
                        return const ResetSettingsDialog();
                      },
                    );
                    if (reset ?? false) {
                      await themeController.resetAllToDefaults();
                    }
                  },
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'You have pushed the button this times:',
            ),
            Text(
              '$_count',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment of the number',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
