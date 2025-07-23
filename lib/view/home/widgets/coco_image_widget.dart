import 'package:cached_network_image/cached_network_image.dart';
import 'package:cocoexplorer_mobile/models/coco_model.dart';
import 'package:cocoexplorer_mobile/utils/color_utils.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/segmentation_painter.dart';
import 'package:flutter/material.dart';

class CocoImageWidget extends StatefulWidget {
  final CocoModel cocoModel;
  final List<int> selectedTags;

  const CocoImageWidget({
    super.key,
    required this.cocoModel,
    required this.selectedTags,
  });

  @override
  State<CocoImageWidget> createState() => _CocoImageWidgetState();
}

class _CocoImageWidgetState extends State<CocoImageWidget> {
  Size? _imageSize;
  bool _hasError = false;
  late final ImageProvider _imageProvider;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _imageProvider = CachedNetworkImageProvider(widget.cocoModel.url);
    _resolveImageSizeAndCache();
  }

  void _resolveImageSizeAndCache() {
    _imageProvider
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (info, _) {
              if (mounted) {
                setState(() {
                  _imageSize = Size(
                    info.image.width.toDouble(),
                    info.image.height.toDouble(),
                  );
                  _imageLoaded = true;
                });
              }
            },
            onError: (error, stackTrace) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                });
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Icon(Icons.broken_image, size: 48, color: ColorUtils.random()),
        ),
      );
    }

    if (_imageSize == null || !_imageLoaded) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final displayWidth = MediaQuery.of(context).size.width;
    final displayHeight =
        displayWidth * (_imageSize!.height / _imageSize!.width);

    return SizedBox(
      width: displayWidth,
      height: displayHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(image: _imageProvider, fit: BoxFit.fill),
          ...widget.cocoModel.segmentations.map(
            (e) =>
                widget.selectedTags.contains(e.catId)
                    ? RepaintBoundary(
                      child: CustomPaint(
                        painter: SegmentationPainter(
                          originalWidth: _imageSize!.width,
                          originalHeight: _imageSize!.height,
                          segmentations: e.segmentations as List<List<double>>,
                          color: e.color,
                        ),
                      ),
                    )
                    : SizedBox(),
          ),
        ],
      ),
    );
  }
}
