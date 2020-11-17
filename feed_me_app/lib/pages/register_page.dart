import 'package:feed_me_app/entities/user.dart';
import 'package:feed_me_app/models/user_model.dart';
import 'package:feed_me_app/pages/home_page.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('FeedMe',
              style: TextStyle(
                  fontFamily: 'Righteous',
                  fontSize: 18.0,
                  color: Colors.white)),
          backgroundColor: Color(0xFFf45d27),
          centerTitle: true,
        ),
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
                      "Cadastre-se",
                      style: TextStyle(
                          color: Color.fromARGB(255, 153, 77, 156),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 24.0),
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
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 10.0),
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text.isEmpty || !text.contains("@"))
                                    return "Insira um e-mail válido!";
                                }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 10),
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
                              controller: _passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Senha',
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 10),
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
                              controller: _confirmPassController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirmar senha',
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
                              } else if (_emailController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Insira seu e-mail!",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else if (_passController.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Insira uma senha!",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else if (_passController.text !=
                                  _confirmPassController.text) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("As senhas devem ser iguais",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                User user = new User(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passController.text,
                                    km: 10.0,
                                    admin: 0);
                                postUser(user).then((value) => {
                                      UserModel.of(context).signIn(
                                          email: _emailController.text,
                                          password: _passController.text,
                                          onSuccess: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                          },
                                          onFail: () {})
                                    });
                              }
                            },
                            color: Color.fromARGB(255, 119, 195, 72),
                            child: const Text('Registrar',
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
