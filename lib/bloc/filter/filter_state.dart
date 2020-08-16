import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<int> show;

  FilterState(this.show);

  @override
  List<Object> get props => [show];

  FilterState toggle(int index) {
    return FilterState(show.contains(index)
        ? show.where((element) => element != index).toList()
        : show + [index]);
  }

  @override
  String toString() => 'FilterState $show';
}
