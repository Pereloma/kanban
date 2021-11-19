import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kanban/buisnes/authentication/authentication_bloc.dart';
import 'package:kanban/buisnes/login/login_bloc.dart';
import 'package:kanban/data/authentication_repository.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Home());
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.select((AuthenticationBloc bloc) => bloc.state.user.token,
    );
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            },)],
          bottom: const TabBar(tabs: <Widget>[
            Tab(text: 'On hold',),
            Tab(text: 'In progress',),
            Tab(text: 'Needs review',),
            Tab(text: 'Approved',),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            _Card(),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        ),
      ),
    );
  }

}
class _Card extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("sdf"),
        subtitle: Text("sdfdsf"),
      ),
    );
  }
}