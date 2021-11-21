import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban/buisnes/authentication/authentication_bloc.dart';
import 'package:kanban/buisnes/cards/card_bloc.dart';
import 'package:kanban/data/authentication_repository.dart';
import 'package:kanban/data/user_repository.dart';
import 'package:kanban/models/user.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* StreamController<AuthenticationStatus>().stream;
  }
}

main() {
  late AuthenticationRepository authenticationRepository;
  late UserRepository userRepository;
  late AuthenticationBloc bloc;

  setUp((){
    authenticationRepository = MockAuthenticationRepository();
    userRepository = MockUserRepository();
    bloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        userRepository: userRepository
    );
  });


  group('Test Authentication state', () {
    test('initial state', () {
      final authenticationBloc = AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository
      );
      expect(
          authenticationBloc.state,
          const AuthenticationState.unknown()
      );
    });
  });

  group('Test Authentication bloc', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      '',
      setUp: () {

      },
      build: () => bloc,
      act: (bloc) {
        bloc.add(const AuthenticationStatusChanged(AuthenticationStatus.unknown));
        bloc.add(const AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
      },
      expect: () => <AuthenticationState>[
        const AuthenticationState.unknown(),
        const AuthenticationState.unauthenticated()
      ],
    );
  });
}