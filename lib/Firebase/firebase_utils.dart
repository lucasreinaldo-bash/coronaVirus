import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../User.dart';

class FirebaseUtils {
  FirebaseDatabase _database = new FirebaseDatabase();
  DatabaseError error;

  static final FirebaseUtils _instance = new FirebaseUtils.internal();

  FirebaseUtils.internal();

  factory FirebaseUtils() {
    return _instance;
  }
  void initState() {
    _database.setPersistenceEnabled(true);
    _database.setPersistenceCacheSizeBytes(1024 * 1000000);
  }

  DatabaseError getError() {
    return error;
  }
}
