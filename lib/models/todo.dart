// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:try_flutter_architecture/helper/uuid.dart';
import 'package:try_flutter_architecture/repositorys/todo_entity.dart';

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;
  final Timestamp timestamp;

  Todo(this.task,
      {this.complete = false, String note = '', String id, Timestamp timestamp})
      : note = note ?? '',
        id = id ?? Uuid().generateV4(),
        timestamp = timestamp ?? Timestamp.now();

  Todo copyWith(
      {bool complete,
      String id,
      String note,
      String task,
      Timestamp timestamp}) {
    return Todo(task ?? this.task,
        complete: complete ?? this.complete,
        id: id ?? this.id,
        note: note ?? this.note,
        timestamp: timestamp ?? this.timestamp);
  }

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
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id &&
          timestamp == other.timestamp;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id, timestamp: $timestamp}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete,timestamp);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id ?? Uuid().generateV4(),
      timestamp: entity.timestamp
    );
  }
}