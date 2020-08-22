import 'package:flutter/material.dart';
import 'package:tripadvisor/model/place.dart';
import 'package:tripadvisor/bloc/bloc.dart';
import 'package:tripadvisor/generated/l10n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onRatingUpdate: null,
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
            Text(
              "( " + _place.user_ratings_total.toString() + " )",
              style: TextStyle(fontSize: 12),
            )
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
              onPressed: () async {
                var url = 'https://www.google.com/search?q=' + _place.name;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
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
              : Image.asset('assets/images/flutter.jpg', fit: BoxFit.fill),
        ),
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
            if(_place.opening_hours == null)
              Text(S.of(context).no_data)
            else
              for(var text in _place.opening_hours.weekday_text)
                Text(text),
            Container(height: 10),
          ],
        ),
        Container(
          height: 10,
        ),
        FlatButton(
          onPressed: (){
            if(_place.formatted_phone_number != null)
              launch("tel://" + _place.formatted_phone_number );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.phone),
              Container(width: 10),
              Text(S.of(context).phone, style: TextStyle(fontSize: 16)),
              Container(width: 20),
              Text(
                _place.formatted_phone_number != null
                    ? _place.formatted_phone_number
                    : S.of(context).no_data,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Container(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Text(
            S.of(context).comment,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        for (var review in _place.reviews) PlaceComment(review: review),
        Container(height: 20),
      ],
    );
  }
}

class PlaceComment extends StatelessWidget {
  final Review _review;
  PlaceComment({Key key, @required Review review}) : _review = review, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 15 ,right: 15),
                child: _review.profile_photo_url != null
                    ? Image.network(_review.profile_photo_url, fit: BoxFit.fill)
                    : Image.asset('assets/images/flutter.jpg', fit: BoxFit.fill),
              ),
          ),
          Expanded(
            flex: 7,
            child: Text(_review.text),
          ),
        ],
      ),
    );
  }
}
