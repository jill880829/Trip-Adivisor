import 'package:equatable/equatable.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationSearch extends NavigationState {
  int getIndex() => 0;
}

class NavigationSchedule extends NavigationState {
  int getIndex() => 1;
}

class NavigationAccount extends NavigationState {
  int getIndex() => 2;
}

class NavigationError extends NavigationState {}
