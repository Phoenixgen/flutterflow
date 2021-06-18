import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FlutterMetEvo1FirebaseUser {
  FlutterMetEvo1FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

FlutterMetEvo1FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FlutterMetEvo1FirebaseUser> flutterMetEvo1FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FlutterMetEvo1FirebaseUser>(
            (user) => currentUser = FlutterMetEvo1FirebaseUser(user));
