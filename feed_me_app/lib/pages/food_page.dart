import 'package:feed_me_app/entities/food.dart';
import 'package:feed_me_app/models/user_model.dart';
import 'package:feed_me_app/services/foods_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodPage extends StatefulWidget {
  final int id;

  FoodPage(this.id);

  @override
  _FoodPageState createState() => _FoodPageState(id);
}

class _FoodPageState extends State<FoodPage> {
  final int id;
  String _token;
  Food _food;

  _FoodPageState(this.id);

  @override
  void initState() {
    super.initState();

    setState(() {
      _token = UserModel.of(context).userToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
            child: FutureBuilder(
                future:
                    getFood(id, _token, UserModel.of(context).currentPosition),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _food = snapshot.data;
                    return createCard();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }

  Widget createCard() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
              height: 260.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _food != null
                    ? _food.image
                    : "https://piotrkowalski.pw/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
                fit: BoxFit.cover,
              )),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _food != null ? _food.name : "",
                          style: TextStyle(
                              color: Color.fromARGB(255, 153, 77, 156),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "R\$ ${_food != null ? _food.price.toStringAsFixed(2) : 0.0}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 119, 195, 72),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 220, 220, 220),
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _food != null ? _food.restaurantName : "",
                              style: TextStyle(
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.location_on, size: 22),
                                  ),
                                  TextSpan(
                                      text:
                                          "${_food != null ? _food.distance.toStringAsFixed(2) : 0.0}km",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(128, 128, 128, 1),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _food != null
                                      ? _food.street + ", " + _food.number.toString() + " - " + _food.neighborhood + ", " + _food.city + " - " + _food.state
                                      : "",
                                  style: TextStyle(
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                      fontSize: 14.0),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 220, 220, 220),
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Descrição",
                              style: TextStyle(
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  _food != null ? _food.description : "",
                                  style: TextStyle(
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                      fontSize: 14.0),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            _showOptions(context, 1);
                          },
                          color: Color.fromARGB(255, 119, 195, 72),
                          child: const Text('Reservar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Chamar",
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("tel:54996121920");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Whatsapp",
                          style: TextStyle(color: Colors.green, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("https://wa.me/5554996121920");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
