import 'package:feed_me_app/entities/user.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:feed_me_app/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _kmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _nameController.text = UserModel.of(context).userData.name;
      _kmController.text = UserModel.of(context).userData.km.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFf45d27),
        body: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
                height: MediaQuery.of(context).size.height - 110.0,
                child: Column(
                  children: [
                    Text(
                      "Meus dados",
                      style: TextStyle(
                          color: Color.fromARGB(255, 153, 77, 156),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 24.0),
                          ),
                          Text(
                            "Nome",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 4.0, bottom: 16.0),
                            padding: EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nome',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text.isEmpty) return "Insira um nome";
                                }),
                          ),
                          Text(
                            "Distância (Km)",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.only(
                                top: 10, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextFormField(
                              controller: _kmController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Distância (km)',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_nameController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Insira seu nome",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else if (_kmController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("As senhas devem ser iguais",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                User user = new User(
                                    name: _nameController.text,
                                    email: UserModel.of(context).userData.email,
                                    password:
                                        UserModel.of(context).userData.password,
                                    km: double.parse(_kmController.text),
                                    admin: 0);
                                updateUser(UserModel.of(context).userData.id,
                                        user, UserModel.of(context).userToken)
                                    .then((value) {
                                  UserModel.of(context).userData.name =
                                      _nameController.text;
                                  UserModel.of(context).userData.km =
                                      double.parse(_kmController.text);
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Dados atualizados com sucesso",
                                        textAlign: TextAlign.center),
                                    backgroundColor:
                                        Color.fromARGB(255, 119, 195, 72),
                                    duration: Duration(seconds: 2),
                                  ));
                                });
                              }
                            },
                            color: Color.fromARGB(255, 119, 195, 72),
                            child: const Text('Salvar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
