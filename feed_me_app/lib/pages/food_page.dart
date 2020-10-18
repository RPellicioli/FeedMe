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

      getFood(id, _token).then((data) {
        _food = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FeedMe", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 255, 171, 124),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 255, 171, 124),
        body: Card(
          color: Colors.white,
          margin: EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                  height: 220.0,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: _food != null
                        ? _food.image
                        : "https://piotrkowalski.pw/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
                    fit: BoxFit.cover,
                  ))
            ],
          ),
        ));
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
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
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
