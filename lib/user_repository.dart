import 'package:flutter_auth0/flutter_auth0.dart';
import 'info.dart';

class UserRepository {

  final auth = Auth0(
      baseUrl: 'https://${Info().domain}/',
      clientId: Info().clientId,
    );




  Future<void> signInWithCredentials(String email, String password) async {
    print('map email: $email pwd: $password');
    try {
      var response = await auth.auth.passwordRealm({
        'username': email,
        'password': password,
        'realm': 'Username-Password-Authentication'
      });
  print(response);
    } catch (e) {
      print('Error in Signin $e');
      throw e;
    }
  }

  Future<void> signUp({String email, String password}) async {
    try {
      var response = await auth.auth.createUser({
        'email': email,
        'password': password,
        'connection': 'Username-Password-Authentication'
      });
      print(response);
    } catch (e) {
      print('Error in Signup $e');
      throw e;
    }
  }

  // Future<void> signOut() async {
  //   return Future.wait([
  //     _firebaseAuth.signOut(),
  //     _googleSignIn.signOut(),
  //   ]);
  // }

  // Future<bool> isSignedIn() async {
  //   final currentUser = await _firebaseAuth.currentUser();
  //   return currentUser != null;
  // }

  // Future<String> getUser() async {
  //   return (await _firebaseAuth.currentUser()).email;
  // }
}
