import 'package:firebase_auth/firebase_auth.dart';
import 'package:try_flutter_architecture/repositorys/user_entity.dart';

class FirebaseUserRepository{
  final FirebaseAuth auth;

  const FirebaseUserRepository(this.auth);

  Future<UserEntity> login() async {
    final firebaseUser = await auth.signInAnonymously();

    return UserEntity(
      id: firebaseUser.user.uid,
      displayName: firebaseUser.user.displayName,
      photoUrl: firebaseUser.user.photoUrl,
    );
  }
}