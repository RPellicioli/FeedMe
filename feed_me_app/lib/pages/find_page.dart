import 'package:flutter/material.dart';
import 'package:feed_me_app/models/user_model.dart';
import 'package:feed_me_app/services/foods_service.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:feed_me_app/entities/food.dart';
import 'package:geolocator/geolocator.dart';
import '../services/matchs_service.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  Future _foodFuture;
  Food _food;
  String _token;
  List<int> _foodIds;
  Position _position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _foodIds = UserModel.of(context).foodIds;
    _token = UserModel.of(context).userToken;
    _position = UserModel.of(context).currentPosition;

    _foodFuture = _getRandomFood(_token, _position, foodIds: _foodIds);
  }

  _getRandomFood(token, Position currentPosition, {List<int> foodIds}) async {
    return await getRandomFood(_token, _position, UserModel.of(context).userData.km, foodIds: foodIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _foodFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _food = snapshot.data;
                return _buildContent();
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  height: 320.0,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: _food != null
                        ? _food.image
                        : "https://piotrkowalski.pw/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png",
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.0,
                      child: Text(
                        _food != null ? _food.name : "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 153, 77, 156),
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.location_on, size: 22),
                          ),
                          TextSpan(
                              text: "${_food != null ? _food.distance.toStringAsFixed(2) : 0.0}km",
                              style: TextStyle(
                                  color: Color.fromRGBO(128, 128, 128, 1),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                      child: Text(
                        _food != null
                            ? _food.restaurantName +
                                ", " +
                                _food.city +
                                " - " +
                                _food.state
                            : "",
                        style: TextStyle(
                            color: Color.fromRGBO(128, 128, 128, 1),
                            fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Card(
                margin: EdgeInsets.only(right: 12.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: Center(
                      child: Icon(Icons.close,
                          size: 40.0, color: Color.fromARGB(255, 252, 78, 78))),
                ),
              ),
              onTap: () {
                setState(() {
                  _foodIds.add(_food.id);
                  _foodFuture = _getRandomFood(_token, _position, foodIds: _foodIds);
                });
              },
            ),
            GestureDetector(
              child: Card(
                margin: EdgeInsets.only(left: 12.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: Center(
                      child: Icon(Icons.favorite,
                          size: 40.0,
                          color: Color.fromARGB(255, 119, 195, 72))),
                ),
              ),
              onTap: () {
                setState(() {
                  _foodIds.add(_food.id);
                  postMatch(UserModel.of(context).userData.id, _food.id, _token);

                  _foodFuture = _getRandomFood(_token, _position, foodIds: _foodIds);
                });
              },
            )
          ],
        )
      ],
    );
  }
}
