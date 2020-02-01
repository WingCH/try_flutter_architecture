import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:try_flutter_architecture/repositorys/todo_entity.dart';

class FirestoreReactiveTodosRepository {
  static const String path = 'todo';

  final Firestore firestore;

  const FirestoreReactiveTodosRepository(this.firestore);

  Future<void> addNewTodo(TodoEntity todo) {
    return firestore.collection(path).document(todo.id).setData(todo.toJson());
  }

  Future<void> deleteTodo(List<String> idList) async {
    await Future.wait<void>(idList.map((id) {
      return firestore.collection(path).document(id).delete();
    }));
  }
  Stream<List<TodoEntity>> todos() {
    //TODO: only create add time
    return firestore.collection(path).orderBy('timestamp', descending: false).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return TodoEntity(
          doc['task'],
          doc.documentID,
          doc['note'] ?? '',
          doc['complete'] ?? false,
          doc['timestamp']
        );
      }).toList();
    });
  }

  Future<void> updateTodo(TodoEntity todo) {
    return firestore
        .collection(path)
        .document(todo.id)
        .updateData(todo.toJson());
  }
}
