import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class User {
  String _id, _name, _email;

  User(this._id, this._name, this._email);

  User.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _email = snapshot.value['email'];
  }
  get email => _email;

  set email(value) {
    _email = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
