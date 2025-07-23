import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as transformers;
import 'package:cocoexplorer_mobile/models/caption_model.dart';
import 'package:cocoexplorer_mobile/models/coco_model.dart';
import 'package:cocoexplorer_mobile/models/image_model.dart';
import 'package:cocoexplorer_mobile/models/instance_model.dart';
import 'package:cocoexplorer_mobile/repositories/coco_repository.dart';
import 'package:cocoexplorer_mobile/utils/color_utils.dart';
import 'package:cocoexplorer_mobile/utils/extensions/list_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CocoRepository _repository;

  HomeBloc({required CocoRepository repository})
    : _repository = repository,
      super(HomeInitial()) {
    on<SearchByCatEvent>(_onSearchByCat, transformer: transformers.droppable());
    on<ExtendSearch>(_onExtendSearch, transformer: transformers.droppable());
    on<ClearSearch>(_onClearSearch, transformer: transformers.droppable());
  }

  final List<int> _definedTags = [];
  final List<int> _allIds = [];
  List<CocoModel> _fetchedCocos = [];
  bool _hasReachedMax = false;

  final ScrollController scrollController = ScrollController();

  void init() {
    scrollController.addListener(_detectScrolledToEnd);
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  void _detectScrolledToEnd() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      add(ExtendSearch());
    }
  }

  Future<void> _onSearchByCat(
    SearchByCatEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      _definedTags.clear();
      _allIds.clear();
      _fetchedCocos = [];
      _hasReachedMax = false;
      _definedTags.addAll(event.tagIds);
      final imgIds = await _repository.getImageIds(event.tagIds);
      if (imgIds.isEmpty) {
        return emit(HomeSuccess(cocomodels: []));
      }
      _allIds.addAll(imgIds);
      final cocomodels = await _onSearchImages();
      _fetchedCocos.addAll(cocomodels);
      emit(
        HomeSuccess(
          cocomodels: List.from(_fetchedCocos),
          allSeen: _hasReachedMax,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
        emit(HomeFail());
      }
    }
  }

  Future<void> _onExtendSearch(
    ExtendSearch event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (_allIds.isEmpty) return;
      final currentState = state;
      if (currentState is! HomeSuccess) return;

      final newCocos = await _onSearchImages();
      _fetchedCocos.addAll(newCocos);

      emit(
        HomeSuccess(
          cocomodels: List.from(_fetchedCocos),
          allSeen: _hasReachedMax,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(HomeFail());
    }
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<HomeState> emit,
  ) async {
    _definedTags.clear();
    _allIds.clear();
    _fetchedCocos = [];
    _hasReachedMax = false;

    emit(HomeInitial());
  }

  Future<List<CocoModel>> _onSearchImages() async {
    final randomSelected = _allIds.takeRandomAndRemove(5);
    _hasReachedMax = _allIds.isEmpty;
    final fs = await Future.wait([
      _repository.getImages(randomSelected),
      _repository.getInstances(randomSelected),
      _repository.getCaptions(randomSelected),
    ]);
    final images = fs[0] as List<ImageModel>;
    final instances = fs[1] as List<InstanceModel>;
    final captions = fs[2] as List<CaptionModel>;

    final cocos = _mergeToCocoModels(
      captions: captions,
      images: images,
      instances: instances,
    );
    return cocos;
  }

  List<CocoModel> _mergeToCocoModels({
    required List<CaptionModel> captions,
    required List<ImageModel> images,
    required List<InstanceModel> instances,
  }) {
    final Map<int, List<String>> captionsByImageId = {};
    for (final caption in captions) {
      captionsByImageId
          .putIfAbsent(caption.imageId, () => [])
          .add(caption.caption);
    }

    final Map<int, List<InstanceModel>> instancesByImageId = {};
    for (final instance in instances) {
      instancesByImageId.putIfAbsent(instance.imageId, () => []).add(instance);
    }

    return images.map((image) {
      final imageId = image.id;

      final List<InstanceModel> instanceList =
          instancesByImageId[imageId] ?? [];
      final List<int> catIds =
          instanceList.map((e) => e.catId).toSet().toList();
      final List<Segmentation> segmentations =
          instanceList
              .map(
                (e) => Segmentation(
                  catId: e.catId,
                  segmentations: e.segmentation,
                  color: ColorUtils.random(opacity: 0.5),
                ),
              )
              .toList();

      final List<String> imageCaptions = captionsByImageId[imageId] ?? [];

      return CocoModel(
        imageId: imageId,
        url: image.url,
        captions: imageCaptions,
        cats: catIds,
        segmentations: segmentations,
      );
    }).toList();
  }
}
