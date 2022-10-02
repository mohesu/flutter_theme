This package made for helping to easy to create a flutter project with themes.


## Features

Fully customizable, flexible and easy to use Flutter theme package for Flutter apps.

<table>
  <tr>
     <td>Light Mode</td>
     <td>Dark Mode</td>
     <td>Screenshot</td>
  </tr>
  <tr>
<td><img src="https://raw.githubusercontent.com/mohesu/flutter_theme/master/screenshots/theme_light.gif" width=250 height=480 alt=""></td>
<td><img src="https://raw.githubusercontent.com/mohesu/flutter_theme/master/screenshots/theme_dark.gif" width=250 height=480 alt=""></td>
<td><img src="https://raw.githubusercontent.com/mohesu/flutter_theme/master/screenshots/ss.png" width=250 height=480 alt=""></td>
</tr>
</table>


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