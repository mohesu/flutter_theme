This package made for helping to easy to create a flutter project with themes.


## Features

Fully customizable, flexible and easy to use Flutter theme package for Flutter apps.


## Getting started

add this to your pubspec.yaml

```yaml
dependencies:
  flutter_theme: any
```

## Usage

```dart
void main() async {

  await Hive.initFlutter();
  final ThemeService themeService =
  ThemeServiceHive('flex_color_scheme_v5_box_5');
  await themeService.init();
  themeController = ThemeController(themeService);
  await themeController.loadAll();
  runApp(
    MyApp(controller: themeController),
  );
}
```



```dart
class MyApp extends ConsumerWidget {
  final ThemeController controller;
  const MyApp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider); // <-- watch the router
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          title: 'Flutter App',
          debugShowCheckedModeBanner: false,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          scrollBehavior: const AppScrollBehavior(),
          theme: controller.useFlexColorScheme
              ? flexThemeLight(controller)
              : themeDataFromLight(controller),
          darkTheme: controller.useFlexColorScheme
              ? flexThemeDark(controller)
              : themeDataFromDark(controller),
          themeMode: controller.themeMode,
        );
      },
    );
  }
}
```





## Additional information

This package based on [flex_color_scheme](https://pub.dev/packages/flex_color_scheme) package.
All credits to [Mike Rydstrom](https://twitter.com/RydMike) for his great work.