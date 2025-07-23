part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CocoModel> cocomodels;
  final bool allSeen;

  HomeSuccess({required this.cocomodels, this.allSeen = false});

  HomeSuccess copyWith({List<CocoModel>? cocomodels, bool? allSeen}) {
    return HomeSuccess(
      cocomodels: cocomodels ?? this.cocomodels,
      allSeen: allSeen ?? this.allSeen,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeSuccess &&
        other.allSeen == allSeen &&
        listEquals(other.cocomodels, cocomodels);
  }

  @override
  int get hashCode => cocomodels.hashCode ^ allSeen.hashCode;
}

class HomeFail extends HomeState {}
