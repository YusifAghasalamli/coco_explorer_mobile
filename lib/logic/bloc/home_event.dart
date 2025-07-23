part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class SearchByCatEvent extends HomeEvent {
  final List<int> tagIds;
  SearchByCatEvent({required this.tagIds});
}

class ExtendSearch extends HomeEvent {}

class ClearSearch extends HomeEvent {}
