import 'package:bloc/bloc.dart';
import 'package:cocoexplorer_mobile/models/coco_model.dart';
import 'package:meta/meta.dart';

part 'filter_segmentations_state.dart';

class FilterSegmentationsCubit extends Cubit<FilterSegmentationsState> {
  final CocoModel _cocoModel;

  FilterSegmentationsCubit({required CocoModel cocoModel})
    : _cocoModel = cocoModel,
      super(FilterSegmentationsIdle(selected: cocoModel.cats.toList()));

  void toggle(int id) {
    final current = List<int>.from(state.selected);

    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }

    emit(FilterSegmentationsIdle(selected: current));
  }

  void reset() {
    emit(FilterSegmentationsIdle(selected: _cocoModel.cats.toList()));
  }
}
