import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kanban/buisnes/authentication/authentication_bloc.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/authentication_repository.dart';
import 'package:kanban/data/user_repository.dart';
import 'package:kanban/generated/l10n.dart';
import 'package:kanban/ui/authentication.dart';
import 'package:kanban/ui/home.dart';
import 'package:kanban/ui/loading_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(KCardAdapter());

  runApp(KanbanApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class KanbanApp extends StatelessWidget {
  const KanbanApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository
            ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AppViewState();
}
class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      navigatorKey: _navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Spanish, no country code
      ],
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status){
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(Home.route(),(route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
              default:
                _navigator.pushAndRemoveUntil(Authentication.route(), (route) => false);
                break;
            }
        },
          child: child,
        );
      },
      onGenerateRoute: (_) => LoadingPage.route(),
    );
  }

}
