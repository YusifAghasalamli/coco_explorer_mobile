import 'package:cocoexplorer_mobile/logic/bloc/home_bloc.dart';
import 'package:cocoexplorer_mobile/logic/cubit/filter_segmentations_cubit.dart';
import 'package:cocoexplorer_mobile/utils/get_context.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/center_text.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/image_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    _bloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                return CenterText(text: localizations.searchHint);
              }
              if (state is HomeLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeSuccess) {
                if (state.cocomodels.isEmpty) {
                  return CenterText(
                    text: localizations.nothingFound,
                    color: Colors.yellowAccent,
                  );
                }
                return _buildList(state);
              }
              return CenterText(
                text: localizations.defaultError,
                color: Colors.redAccent,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildList(HomeSuccess state) {
    return ListView.separated(
      key: const PageStorageKey('coco_list'),
      controller: _bloc.scrollController,
      itemCount:
          state.allSeen ? state.cocomodels.length : state.cocomodels.length + 1,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      cacheExtent: MediaQuery.of(context).size.height * 2,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index >= state.cocomodels.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final isLastItem = index == state.cocomodels.length - 1;
        final item = BlocProvider(
          create:
              (context) =>
                  FilterSegmentationsCubit(cocoModel: state.cocomodels[index]),
          child: ImageItem(cocoModel: state.cocomodels[index]),
        );

        return isLastItem
            ? Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 8, right: 8),
              child: item,
            )
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: item,
            );
      },
    );
  }
}
