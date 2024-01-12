import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zds_flutter/zds_flutter.dart';
import 'package:zds_flutter_template/src/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DemoApp());

  // To use custom theme json files, replace the line above with the line below:
  // await setUpJsonThemeService();
}

Future<void> setUpJsonThemeService() async {
  final preferences = await SharedPreferences.getInstance();
  // To edit custom theme values, change assets/colors.json
  final themeService = ZdsThemeService(assetPath: 'assets/colors.json', preferences: preferences);
  final themeData = await themeService.load();
  runApp(DemoApp(data: themeData, themeService: themeService));
}

// GoRouter configuration. This can be changed for any other router.
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

class DemoApp extends StatelessWidget {
  const DemoApp({super.key, this.data, this.themeService});

  final ZetaThemeService? themeService;
  final ZdsThemeData? data;

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      themeService: themeService,
      initialThemeMode: data?.themeMode ?? ThemeMode.system,
      initialThemeData: data?.themeData ?? ZetaThemeData(),
      initialContrast: data?.contrast ?? ZetaContrast.aa,
      builder: (context, themeData, themeMode) {
        return MaterialApp.router(
          routerConfig: _router,
          title: 'ZDS Flutter template',
          builder: (BuildContext context, Widget? child) {
            return ZdsBottomBarTheme(
              data: buildZdsBottomBarThemeData(context),
              child: child ?? const SizedBox(),
            );
          },
          themeMode: themeMode,
          theme: themeData.colorsLight.toScheme().toTheme(
                fontFamily: themeData.fontFamily,
                appBarStyle: data?.lightAppBarStyle ?? ZetaAppBarStyle.primary,
              ),
          darkTheme: themeData.colorsDark.toScheme().toTheme(
                fontFamily: themeData.fontFamily,
                appBarStyle: data?.darkAppBarStyle ?? ZetaAppBarStyle.primary,
              ),
          // To customize localizations, import flutter_localizations package and uncomment the following lines:
          // localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
          //   return locale != null && ComponentStrings.delegate.isSupported(locale)
          //       ? locale
          //       : ComponentStrings.defaultLocale;
          // },
          // localizationsDelegates: <LocalizationsDelegate<dynamic>>[
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   ComponentStrings.delegate,
          // ],
        );
      },
    );
  }
}
