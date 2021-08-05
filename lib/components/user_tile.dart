import 'package:cadastro_completo/models/user.dart';
import 'package:cadastro_completo/provider/users.dart';
import 'package:cadastro_completo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class USerTile extends StatelessWidget{

  final User user;

  const USerTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null ||user.avatarUrl.isEmpty
    ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.orangeAccent,
                onPressed: (){
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
            ),
            IconButton(
                icon: Icon(Icons.delete),
              color: Colors.red,
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Excluir usuário'),
                        content: Text('Tem certeza?'),
                        actions: <Widget> [
                          FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();  // comando para fechar o dialog para voltar a tela anterior
                            },
                              child: Text('Não'),
                          ),
                          FlatButton(
                            child: Text('Sim'),
                            onPressed: (){
                              Provider.of<Users>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();  // comando para fechar o dialog para voltar a tela anterior
                            },
                          )
                        ],
                      )
                  );
                  Provider.of<Users>(context, listen: false).remove(user);
                },
            ),
          ],
        ),
      ),
    );
  }


}