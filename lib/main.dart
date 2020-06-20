import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:threads/simple_bloc_delegate.dart';
import 'package:threads/authentication_bloc/authentication_bloc.dart';
import 'package:threads/user_repository.dart';
import 'package:threads/screens/screens.dart';
import 'package:threads/login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    // App(userRepository: userRepository,)
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository),
          // AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return ChatScreen();

        },
      ),
    );
  }


}
