import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripadvisor/bloc/bloc.dart';

import 'package:tripadvisor/page/data/viewpoint_classify.dart';

class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<FilterBloc>(context),
      builder: (context, state) {
        return Row(
          children: <Widget>[
            for (ViewpointClassify classify in ViewpointClassify.values)
              IconButton(
                icon: Icon(
                  classify.icon,
                  color: state.show.contains(classify.type)
                      ? classify.color
                      : Colors.grey,
                ),
                onPressed: () => {
                  BlocProvider.of<FilterBloc>(context)
                      .dispatch(FilterOnPressed(classify.type)),
                  BlocProvider.of<SearchBloc>(context).dispatch(SearchRefresh())
                },
              ),
          ],
        );
      },
    );
  }
}
