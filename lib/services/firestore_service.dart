import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set({
      'name': user.name,
      'email': user.email,
      'age': user.age
    });
  }

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot snapshot = await _db.collection('users').doc(uid).get();
    return UserModel(
        uid: uid,
        name: snapshot['name'],
        email: snapshot['email'],
        age: snapshot['age']
    );
  }
}
