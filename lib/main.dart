import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';
import 'repos_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(create: (_) => ReposBloc(), child: HomeScreen()),
  ));
}
