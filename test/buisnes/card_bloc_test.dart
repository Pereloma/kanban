import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban/buisnes/cards/card_bloc.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:kanban/models/card.dart';
import 'package:mocktail/mocktail.dart';

class MockCardsRepository extends Mock implements CardsRepository {}

main() {
  late CardsRepository cardsRepository;
  late CardBloc bloc;
  const cards = [
    KCard(id: 1, row: RowCardsStatus.approved, seqNum: 1, text: 'text1'),
    KCard(id: 2, row: RowCardsStatus.approved, seqNum: 1, text: 'text1')
  ];
  setUp(() {
    cardsRepository = MockCardsRepository();
    bloc = CardBloc(cardsRepository);
  });

  group('Test card state', () {
    test('initial state', () {
      final cardBloc = CardBloc(cardsRepository);
      expect(
          cardBloc.state,
          CardState(cardList: null, load: RowCardsStatus.onHold)
      );
    });
  });

  group('Test card bloc', () {
    blocTest<CardBloc, CardState>(
      '',
      setUp: () {
        when(() => cardsRepository.getCards(RowCardsStatus.approved))
            .thenAnswer((invocation) => Future.value(cards));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const CardEvent(RowCardsStatus.approved)),
      expect: () => <CardState>[
        CardState.load(),
        CardState(cardList: cards, load: RowCardsStatus.approved)
      ],
    );
  });

  group('Test card bloc, without Internet', () {
    blocTest<CardBloc, CardState>(
      '',
      setUp: () {
        when(() => cardsRepository.getCards(RowCardsStatus.approved))
            .thenAnswer((invocation) => throw DioError(requestOptions: RequestOptions(path: "")));
        when(() => cardsRepository.hiveGetCards(RowCardsStatus.approved))
            .thenAnswer((invocation) => Future.value(cards));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const CardEvent(RowCardsStatus.approved)),
      expect: () => <CardState>[
        CardState.load(),
        CardState(cardList: cards, load: RowCardsStatus.approved)
      ],
    );
  });
}
