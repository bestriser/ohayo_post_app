import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ohayo_post_app/model/post.dart';

class PostDataService {
  final FirebaseFirestore _storeDB = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    final postId = _storeDB.collection('_').doc().id;
    final _postMap = {
      'contributorId': post.contributorId,
      'postId': postId,
      'target': post.target,
      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };
    _storeDB.collection('posts').doc(postId).set(_postMap);
  }

  Stream<List<Post>> postStream(String firebaseUid) {
    if (firebaseUid.isEmpty) return null;
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
          ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      },
    );
  }

  Future<Post> getPost(String postId) async {
    final doc = await _storeDB.collection('posts').doc(postId).get();
    return Post.fromDocumentSnapshot(doc);
  }
}
