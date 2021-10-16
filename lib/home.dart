import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repo.dart';
import 'repo_widget.dart';
import 'repos_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReposBloc>(context).add(GetReposPage());
    return Scaffold(
      appBar: AppBar(
        title: Text('Mintrocket repos'),
      ),
      body: BlocBuilder<ReposBloc, ReposState>(
        builder: (context, state) {
          print(state);
          if (state is ReposLoading) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<ReposBloc>(context).add(GetReposPage());
                print(state);
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          }
          if (state is ReposError) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<ReposBloc>(context).add(GetReposPage());
                print(state);
                return Future.value();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height),
                  child: Center(child: Text(state.error.toString())),
                ),
              ),
            );
          }
          if (state is ReposLoaded) {
            return Center(
              child: RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<ReposBloc>(context).add(GetReposPage());
                  print(state);
                  return Future.value();
                },
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: state.repos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RepoWidget(state.repos[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
