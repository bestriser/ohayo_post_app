import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohayo_post_app/model/person.dart';

class PersonDataService {
  final FirebaseFirestore _storeDB = FirebaseFirestore.instance;

  Future<void> createPerson(String uid, String nickName, String email) async {
    final _personMap = {
      'uid': uid,
      'nickName': nickName,
      'email': email,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };
    _storeDB.collection('persons').doc(uid).set(_personMap);
  }

  Stream<Person> personStream(String firebaseUid) {
    return _storeDB
        .collection('persons')
        .doc(firebaseUid)
        .snapshots()
        .map((DocumentSnapshot data) => Person.fromDocumentSnapshot(data));
  }

  Future<Person> getPerson(String uid) async {
    final doc = await _storeDB.collection('persons').doc(uid).get();
    return Person.fromDocumentSnapshot(doc);
  }
}
