part of 'filter_segmentations_cubit.dart';

@immutable
sealed class FilterSegmentationsState {
  final List<int> selected;

  const FilterSegmentationsState({required this.selected});
}

final class FilterSegmentationsIdle extends FilterSegmentationsState {
  const FilterSegmentationsIdle({required super.selected});
}
