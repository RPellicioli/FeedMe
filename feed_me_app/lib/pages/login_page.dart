import 'package:feed_me_app/models/user_model.dart';
import 'package:feed_me_app/pages/home_page.dart';
import 'package:feed_me_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(242, 242, 242, 255),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'FeedMe',
                        style: TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 42.0,
                            color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 38),
                        child: GestureDetector(
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text.isEmpty || !text.contains("@"))
                                    return "E-mail inválido!";
                                }),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            margin: EdgeInsets.only(top: 32),
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextFormField(
                              controller: _passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.grey,
                                ),
                                hintText: 'Senha',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (_emailController.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Insira seu e-mail para logar!",
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else if (_passController.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Insira uma senha para logar!",
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        }
                        else{
                          UserModel.of(context).signIn(
                              email: _emailController.text,
                              password: _passController.text,
                              onSuccess: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => HomePage()));
                              },
                              onFail: () {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Usuário ou senha inválidos",
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              });
                        }
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Entrar'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _checkPermission() async {
    var locationPermissionStatus = await Permission.location.status;

    if(!locationPermissionStatus.isGranted){
      PermissionStatus status = await Permission.location.request();
    }
    _getCurrentLocation();
  }

  void _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        UserModel.of(context).currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          UserModel.of(context).currentPosition.latitude, UserModel.of(context).currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        UserModel.of(context).currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
