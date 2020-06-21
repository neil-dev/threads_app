import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:threads_app/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  // AuthenticationState get initialState => Uninitialized();
  AuthenticationState get initialState => Unauthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // if (event is AppStarted) {
    //   yield* _mapAppStartedToState();
    // } else if (event is LoggedIn) {
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  // Stream<AuthenticationState> _mapAppStartedToState() async* {
  //   final isSignedIn = await _userRepository.isSignedIn();
  //   if (isSignedIn) {
  //     final name = await _userRepository.getUser();
  //     yield Authenticated(name);
  //   } else {
  //     yield Unauthenticated();
  //   }
  // }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    // yield Authenticated(await _userRepository.getUser());
    yield Authenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    // _userRepository.signOut();
  }
}
