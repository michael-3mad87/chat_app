import 'package:chat_app/Auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteDataSource {
  static CollectionReference<UserModel> getUsersCollections() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (doucSnapshot, _) =>
                UserModel.formJson(doucSnapshot.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  static Future<UserModel> register(
 { required String name,
   required String password,
   required String email,}
  ) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModel(
      email: email,
      name: name,
      id: userCredential.user!.uid,
    );
    final userCollection = getUsersCollections();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final userCollection = getUsersCollections();
    final doucSnapshot = await userCollection.doc(credential.user!.uid).get();
    return doucSnapshot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();
}

    /* to add to fireStore
    create collection 
    create document 
    and add you model in func set
     */ 
    ////////
    /* to get from FireStore
    define the collection
    collection.get that return querySnapShot this have list of queryDocument for all database
    you want docs form query to get data 
    you must do .map to convert list of queryDocument to list of model 
     */