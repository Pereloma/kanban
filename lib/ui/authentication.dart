import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kanban/buisnes/login/login_bloc.dart';
import 'package:kanban/data/authentication_repository.dart';
import 'package:kanban/generated/l10n.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Authentication());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kanban"),
      ),
      body: SafeArea(
        child: Center(
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              );
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status.isSubmissionFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                          content: Text(state.nonField ??
                              S.of(context).Authentication_Fail)),
                    );
                }
              },
              child: ListView(
                padding: const EdgeInsets.all(32.0),
                children: [
                  _loginTextField(),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  _passTextField(),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return FloatingActionButton.extended(
                        key: const Key('_button_Authentication_Page'),
                        onPressed: () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        },
                        label: Text(S.of(context).Log_In),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _loginTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(value)),
          key: const Key('_loginTextField_Authentication_Page'),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: S.of(context).Enter_your_username,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            filled: true,
            errorText: state.username.invalid
                ? S.of(context).Minimum_4_characters
                : null,
          ),
        );
      },
    );
  }
}

class _passTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          key: const Key('_passTextField_Authentication_Page'),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: S.of(context).Enter_your_password,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            filled: true,
            errorText: state.password.invalid
                ? S.of(context).Minimum_8_characters
                : null,
          ),
        );
      },
    );
  }
}
