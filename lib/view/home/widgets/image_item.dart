import 'package:cocoexplorer_mobile/constants/id_to_cat.dart';
import 'package:cocoexplorer_mobile/logic/cubit/filter_segmentations_cubit.dart';
import 'package:cocoexplorer_mobile/models/coco_model.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/coco_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({super.key, required this.cocoModel});
  final CocoModel cocoModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSegmentationsCubit, FilterSegmentationsState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                CocoImageWidget(
                  key: ValueKey(cocoModel.imageId),
                  cocoModel: cocoModel,
                  selectedTags: state.selected,
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Wrap(
                    spacing: 8,
                    children: List.generate(cocoModel.cats.length, (index) {
                      final tag = cocoModel.cats[index];
                      return idToCat[tag] != null
                          ? FilterChip(
                            label: Text(idToCat[tag]!),
                            selected: state.selected.contains(tag),
                            onSelected: (val) {
                              context.read<FilterSegmentationsCubit>().toggle(
                                tag,
                              );
                            },
                          )
                          : SizedBox();
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
