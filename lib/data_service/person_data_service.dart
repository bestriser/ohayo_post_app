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
    if (firebaseUid.isEmpty) return null;
    return _storeDB
        .collection('persons')
        .doc(firebaseUid)
        .snapshots()
        .map((DocumentSnapshot data) => Person.fromDocumentSnapshot(data));
  }

  Future<List<Person>> getAllPerson() async {
    final snaps = await _storeDB.collection('persons').get();
    return snaps.docs.map((e) => Person.fromDocumentSnapshot(e)).toList();
  }
}
