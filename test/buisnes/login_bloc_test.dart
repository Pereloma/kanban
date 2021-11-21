import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:kanban/buisnes/login/login_bloc.dart';
import 'package:kanban/data/authentication_repository.dart';
import 'package:kanban/models/password.dart';
import 'package:kanban/models/username.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

main() {
  late LoginBloc bloc;
  late AuthenticationRepository authenticationRepository;

  setUp((){
    authenticationRepository = MockAuthenticationRepository();
    bloc = LoginBloc(authenticationRepository: authenticationRepository);
  });

  group('Test Login state', () {
    test('initial state', () {
      final loginBloc = LoginBloc(authenticationRepository: authenticationRepository);
      expect(
          loginBloc.state,
          const LoginState()
      );
    });
  });

  group('Test Login bloc', () {
    blocTest<LoginBloc, LoginState>(
      '',
      setUp: () {

      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(const LoginUsernameChanged("123"));
        bloc.add(const LoginPasswordChanged("1234567"));
        bloc.add(const LoginUsernameChanged("user"));
        bloc.add(const LoginPasswordChanged("123456789"));
      },
      expect: () => <LoginState>[
        const LoginState(username: Username.dirty("123"),status: FormzStatus.invalid),
        const LoginState(username: Username.dirty("123"),password: Password.dirty("1234567"),status: FormzStatus.invalid),
        const LoginState(username: Username.dirty("user"),password: Password.dirty("1234567"),status: FormzStatus.invalid),
        const LoginState(username: Username.dirty("user"),password: Password.dirty("123456789"),status: FormzStatus.valid)
      ],
    );
  });
}