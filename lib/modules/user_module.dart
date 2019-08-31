import 'package:bobo_ui/modals/user_modal.dart';
import 'package:flutter/material.dart';


class UserModule extends ChangeNotifier{
  //List<UserModal> _users;

  // dummy data
  List<UserModal> _users = [
    UserModal(id:'1', username: 'foo 1'),
    UserModal(id:'2', username: 'foo 2'),
    UserModal(id:'3', username: 'foo 3'),
  ];

  get users => _users;

  get currentUser => (index) {_users[index];};

  set addUser(UserModal user){
    _users.add(user);
    notifyListeners();
  }

  // id is preffered since each user will have a unique id/key
  // set removeUser(int index)
  set removeUser(int index){
    _users.removeAt(index);
  }





}