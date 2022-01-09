import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  final String? email;
  final DateTime? createdAt;
  final String? imageUrl;
  final String uid;

  User({required this.email, required this.uid, required this.createdAt, required this.imageUrl});
}
