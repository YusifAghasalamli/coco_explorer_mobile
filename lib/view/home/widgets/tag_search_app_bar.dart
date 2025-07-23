import 'package:cocoexplorer_mobile/constants/cat_to_id.dart';
import 'package:cocoexplorer_mobile/logic/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> availableTags;

  const TagSearchAppBar({super.key, required this.availableTags});

  @override
  State<TagSearchAppBar> createState() => _TagSearchAppBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight(130);
  }
}

class _TagSearchAppBarState extends State<TagSearchAppBar> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _selectedTags = [];

  void _handleSubmitted(String value) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty &&
        !_selectedTags.contains(trimmed) &&
        catToId[value] != null) {
      setState(() => _selectedTags.add(trimmed));
    }
    _controller.clear();
  }

  void _handleTextChange(String value) {
    if (value.endsWith(';')) {
      _handleSubmitted(value.replaceAll(';', ''));
    }
  }

  void _toggleTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      setState(() => _selectedTags.add(tag));
    }
  }

  void _removeTag(String tag) {
    setState(() => _selectedTags.remove(tag));
  }

  void _onSearch() {
    _handleSubmitted(_controller.text.trim());
    final tagIds =
        _selectedTags.map((e) => catToId[e]).whereType<int>().toList();

    if (tagIds.isEmpty) {
      context.read<HomeBloc>().add(ClearSearch());
    } else {
      context.read<HomeBloc>().add(SearchByCatEvent(tagIds: tagIds));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 52,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ..._selectedTags.map(
                          (tag) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: InputChip(
                              label: Text(tag),
                              onDeleted: () => _removeTag(tag),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _controller,
                            onChanged: _handleTextChange,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ],
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.availableTags.length,
                itemBuilder: (context, index) {
                  final tag = widget.availableTags[index];
                  final isSelected = _selectedTags.contains(tag);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(tag),
                      selected: isSelected,
                      onSelected: (_) => _toggleTag(tag),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
