import 'package:cadastro_completo/models/user.dart';
import 'package:cadastro_completo/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    if(user !=null){
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context).settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de usuario'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: (){
                final isValid = _form.currentState.validate();

                if(isValid) {
                  _form.currentState.save();

                  Provider.of<Users>(context, listen: false).put(
                      User(
                        id:_formData['id'],
                        name:_formData['name'],
                        email:_formData['email'],
                        avatarUrl:_formData['avatarUrl'],
                      ),
                  );
                  Navigator.of(context).pop();
                }
              },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value){
                  if(value ==null || value.trim().isEmpty){
                    return 'Nome Inv??lido';
                  }
                  if(value.trim().length <3){
                    return 'Min. 3 letras';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              )
            ],
          ),
        )
      ),
    );
  }
}
