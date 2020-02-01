//Todo model 的藍本，對應db
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoEntity {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final Timestamp timestamp;

  TodoEntity(this.task, this.id, this.note, this.complete, this.timestamp);

  @override
  int get hashCode =>
      complete.hashCode ^
      task.hashCode ^
      note.hashCode ^
      id.hashCode ^
      timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id &&
          timestamp == other.timestamp;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
      'timestamp': timestamp
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id, timestamp: $timestamp}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
        json['task'] as String,
        json['id'] as String,
        json['note'] as String,
        json['complete'] as bool,
        json['timestamp'] as Timestamp);
  }
}
