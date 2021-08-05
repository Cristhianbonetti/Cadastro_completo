import 'package:cadastro_completo/models/user.dart';
import 'package:cadastro_completo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cadastro_completo/components/user_tile.dart';
import 'package:provider/provider.dart';
import 'package:cadastro_completo/provider/users.dart';

class UserList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuário'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM
                );
              },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => USerTile(users.byIndex(i)),
      ),
    );
  }

}