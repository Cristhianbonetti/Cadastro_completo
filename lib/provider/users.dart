import 'dart:math';
import 'package:cadastro_completo/data/dummy_users.dart';
import 'package:cadastro_completo/models/user.dart';
import 'package:flutter/material.dart';


class Users with ChangeNotifier{
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count{
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

// Metodo para incluir ou alterar um elemento de usuario dentro do Map

  void put(User user){
    if(user == null) {
      return;
    }
    if(user.id != null &&
        user.id.trim().isEmpty &&
        _items.containsKey(user.id)){
      _items.update(user.id, (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ));
    }else{
      final id = Random().nextDouble().toString();
      _items.putIfAbsent('1000', () => User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),);
    }

    notifyListeners();
  }
  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  }

}