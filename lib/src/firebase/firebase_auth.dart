import 'package:ISeeYou/src/models/medication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ISeeYou/src/models/user.dart' as userModel;

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<userModel.FirebaseUser?> getUserDetails() async {
    User user = _auth.currentUser!;

    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(user.uid).get();

      return userModel.FirebaseUser.fromSnap(snap);
    } on Exception catch (e) {
      Auth().logout();
    }
    return null;
  }

  void logout() {
    _auth.signOut();
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter email and password";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that user.';
      }
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required List<String> emergencyContacts,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          emergencyContacts.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        userModel.FirebaseUser user = userModel.FirebaseUser(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            emergencyContacts: emergencyContacts,
            uid: userCredential.user!.uid,
            medications: []);
        await _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = "Success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        res = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        res = "The account already exists for that email";
      } else if (e.code == "invalid-email") {
        res = "The email address is badly formatted";
      } else {
        res = e.toString();
      }
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> setMedicationHistory(int index, List<DateTime> history) async {
    userModel.FirebaseUser? user = await getUserDetails();
    if (user == null) {
      return;
    }
    List<Medication> medications = user.meds;

    medications[index].history = history;
    return;

    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update({"medications": medications});
  }
}
