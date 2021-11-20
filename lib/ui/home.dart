import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kanban/buisnes/authentication/authentication_bloc.dart';
import 'package:kanban/buisnes/cards/card_bloc.dart';
import 'package:kanban/buisnes/login/login_bloc.dart';
import 'package:kanban/buisnes/models/card.dart';
import 'package:kanban/data/authentication_repository.dart';
import 'package:kanban/data/cards_repository.dart';
import 'package:kanban/generated/l10n.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Home());
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CardBloc(CardsRepository()),
      child: DefaultTabController(
        key: const Key("_Home_DefaultTabController"),
        initialIndex: 0,
        length: 4,
        child: Builder(builder: (context) {
          final tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            //RepositoryProvider.of<CardBloc>(context).add(CardEvent(RowCardsStatus.values[tabController.index]));
          });
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FloatingActionButton(
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: S.of(context).On_hold,
                  ),
                  Tab(
                    text: S.of(context).In_progress,
                  ),
                  Tab(
                    text: S.of(context).Needs_review,
                  ),
                  Tab(
                    text: S.of(context).Approved,
                  ),
                ],
               // onTap: (value) => RepositoryProvider.of<CardBloc>(context).add(CardEvent(RowCardsStatus.values[value])),
              ),
            ),
            body: const TabBarView(
              children: [
                _ListCard(RowCardsStatus.onHold),
                _ListCard(RowCardsStatus.inProgress),
                _ListCard(RowCardsStatus.needsReview),
                _ListCard(RowCardsStatus.approved)
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard(this.rowCardsStatus);

  final RowCardsStatus rowCardsStatus;

  @override
  Widget build(BuildContext context) {
    CardBloc _cardBloc = RepositoryProvider.of<CardBloc>(context);
    _cardBloc.add(CardEvent(rowCardsStatus));
    return BlocBuilder<CardBloc, CardState>(
        buildWhen: (previous, current) =>
            current.isLoad[rowCardsStatus] == false &&
            previous.cardList != current.cardList,
        bloc: _cardBloc,
        builder: (context, state) {
          if (state.isLoad[rowCardsStatus] ?? true) {
            return const Center(child: CircularProgressIndicator());
          }
          List<KCard> cardList = [...?state.cardList];
          return ListView.builder(
            itemCount: cardList.length,
            itemBuilder: (context, index) {
              return _Card(cardList[index]);
            },
          );
        });
  }
}

class _Card extends StatelessWidget {
  _Card(KCard card)
      : id = card.id,
        text = card.text;
  final int id;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID $id",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(text),
          ],
        ),
      ),
    );
  }
}
