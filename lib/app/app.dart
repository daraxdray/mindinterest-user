import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/route/app_router.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/state/providers.dart';

import 'package:mindintrest_user/l10n/l10n.dart';

class App extends HookConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return AnnotatedRegion(
      value: theme.themeMode,
      child: MaterialApp.router(
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routerDelegate: AppRouter.router.routerDelegate,
        title: 'MindIntrest App',
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme().getTheme(),
        showSemanticsDebugger: false,
        // darkTheme: AppDarkTheme().getTheme(),
        localizationsDelegates:  [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        themeMode: theme.themeMode,
      ),
    );
  }
}
