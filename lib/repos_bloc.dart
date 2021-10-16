import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:testovoe/repo.dart';

abstract class ReposEvent {}

class GetReposPage extends ReposEvent {}

class RefreshRepos extends ReposEvent {}

abstract class ReposState {}

class ReposInitial extends ReposState {}

class ReposLoading extends ReposState {}

class ReposLoaded extends ReposState {
  List<RepoInfo> repos;
  ReposLoaded(this.repos);
}

class ReposError extends ReposState {
  dynamic error;
  ReposError(this.error);
}

class ReposBloc extends Bloc<ReposEvent, ReposState> {
  ReposBloc() : super(ReposInitial());

  @override
  Stream<ReposState> mapEventToState(ReposEvent event) async* {
    if (event is GetReposPage) {
      yield* _getReposPage();
    }
  }

  Stream<ReposState> _getReposPage() async* {
    yield ReposLoading();

    try {
      Response res =
          await get(Uri.parse('https://api.github.com/orgs/mintrocket/repos'));
      List body = jsonDecode(res.body);
      final repos = body
          .map((e) => RepoInfo(
                e['id'].toString(),
                e['name'] ?? '',
                e['owner']['login'] ?? '',
                e['description'] ?? '',
              ))
          .toList();
      yield (ReposLoaded(repos));
    } catch (e) {
      yield ReposError(e);
    }
  }
}
