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

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Home());
  }

  @override
  Widget build(BuildContext context) {
    CardBloc _cardBloc = CardBloc(CardsRepository());
    _cardBloc.add(CardEvent(RowCardsStatus.values[0]));
    return DefaultTabController(
      key: const Key("_Home_DefaultTabController"),
      initialIndex: 0,
      length: 4,
      child: Scaffold(
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
            tabs: const <Widget>[
              Tab(
                text: 'On hold',
              ),
              Tab(
                text: 'In progress',
              ),
              Tab(
                text: 'Needs review',
              ),
              Tab(
                text: 'Approved',
              ),
            ],
            onTap: (value) =>
                _cardBloc.add(CardEvent(RowCardsStatus.values[value])),
          ),
        ),
        body: BlocBuilder<CardBloc, CardState>(
          bloc: _cardBloc,
          builder: (context, state) {
            if (state.isLoad){
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: state.cardList!.length,
              itemBuilder: (context, index) {
                return _Card(state.cardList![index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  _Card(KCard card):
        id = card.id, text = card.text;
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
            Text("ID $id",
              style: TextStyle(fontSize: 10,color: Colors.grey)
              ,),
            SizedBox(height: 4),
            Text(text),
          ],
        ),
      ),
    );
  }


}
