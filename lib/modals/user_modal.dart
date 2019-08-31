import 'package:flutter/material.dart';

class UserModal{
  final String id;
  final String username;

  // TODO:
  // conact
  // icon/profile

  UserModal({
    this.id = '1',
    @required this.username
  });

  get map => _map();

  Map<String, dynamic> _map(){
    return {
      'id': id,
      'username': username
    };
  }

}