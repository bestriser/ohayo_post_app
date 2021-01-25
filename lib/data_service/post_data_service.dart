import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohayo_post_app/model/post.dart';

class PostDataService {
  final FirebaseFirestore _storeDB = FirebaseFirestore.instance;

  Future<void> createPost(String uid, String nickName, String email) async {
    final _personMap = {
      'uid': uid,
      'nickName': nickName,
      'email': email,
      'createAt': Timestamp.now(),
    };
    _storeDB.collection('posts').doc(uid).set(_personMap);
  }

  Stream<List<Post>> postStream(String firebaseUid) {
    final snaps = _storeDB
        .collection('posts')
        .where('contributorId', isEqualTo: firebaseUid)
        .snapshots();

    return snaps.map(
      (QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return Post.fromDocumentSnapshot(doc);
        }).toList()
          // orderを使うとsnapshotsが0件になるためsort()で降順(新しい投稿順)にした
          ..sort((a, b) => a.updateAt.compareTo(b.updateAt));
      },
    );
  }

  Future<Post> getPost(String postId) async {
    final doc = await _storeDB.collection('posts').doc(postId).get();
    return Post.fromDocumentSnapshot(doc);
  }
}
