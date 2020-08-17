import 'package:flutter/material.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/generated/l10n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Show place data in the search list.
class PlaceDetail extends StatelessWidget {
  final Place _place;
  PlaceDetail({Key key, @required Place place})
      : _place = place,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 15,
                  ),
                  Text(_place.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(_place.formatted_address),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  BlocProvider.of<DraggableListViewBloc>(context)
                      .dispatch(ChangeSearch());
                },
              ),
            ),
          ],
        ),
        Container(
          height: 15,
        ),
        Row(
          children: <Widget>[
            Text(_place.rating.toString(), style: TextStyle(fontSize: 12)),
            Container(
              width: 10,
            ),
            RatingBar(
              initialRating: _place.rating != null ? _place.rating : 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            Container(
              width: 5,
            ),
            Text("( " + _place.user_ratings_total.toString() + " )",
                style: TextStyle(fontSize: 12))
          ],
        ),
        Container(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.my_location),
              label: Text(S.of(context).position),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.bookmark),
              label: Text(S.of(context).favorite),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.search),
              label: Text(S.of(context).search_web),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.near_me),
              label: Text(S.of(context).navigation),
            ),
          ],
        ),
        Container(
            height: 250,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            //child: //Image.asset('assets/images/mountain.jpg'),
            child: _place.photos != null
                ? Image.network(_place.photos[0].toLink(), fit: BoxFit.fill)
                : Image.asset('assets/images/flutter.jpg', fit: BoxFit.fill)),
        Container(
          height: 10,
        ),
        ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.timer),
              Container(width: 10),
              Text(S.of(context).opening_time),
            ],
          ),
          children: <Widget>[
            Text(S.of(context).Monday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Tuesday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Wednesday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Thursday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Friday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Saturday + " 11:00–21:30"),
            Container(height: 10),
            Text(S.of(context).Sunday + " 11:00–21:30"),
            Container(height: 10),
          ],
        ),
        Container(
          height: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 17),
              Icon(Icons.phone),
              Container(width: 10),
              Text(S.of(context).phone, style: TextStyle(fontSize: 16)),
              Container(width: 20),
              Text(
                  _place.formatted_phone_number != null
                      ? _place.formatted_phone_number
                      : S.of(context).no_data,
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Container(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Text(S.of(context).comment,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        for (var length = 0; length < 5; length++) PlaceComment(),
        Container(height: 20),
      ],
    );
  }
}

class PlaceComment extends StatelessWidget {
  PlaceComment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/flutter.jpg',
                width: 50,
                height: 50,
              )
          ),
          Expanded(
            flex: 7,
            child: Text("雞腿，雞塊咬下去真的會噴汁，肉質軟嫩不柴，買餐前建議先電話預訂"),
          ),
        ],
      ),
    );
  }
}
