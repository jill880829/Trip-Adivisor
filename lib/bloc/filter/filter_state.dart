import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<String> show;

  FilterState(this.show);

  @override
  List<Object> get props => [show];

  FilterState toggle(String type) {
    return FilterState(show.contains(type)
        ? show.where((element) => element != type).toList()
        : show + [type]);
  }

  @override
  String toString() => 'FilterState $show';
}
