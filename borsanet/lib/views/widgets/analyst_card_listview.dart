import 'package:borsanet/models/analyst_model.dart';
import 'package:borsanet/views/widgets/analyst_cardview.dart';
import 'package:flutter/material.dart';

class AnalystCardListview extends StatefulWidget {
  final StockData? info;
  final VoidCallback? onLoadMore;
  final bool loadMore;

  const AnalystCardListview({
    super.key,
    required this.info,
    this.onLoadMore,
    required this.loadMore,
  });

  @override
  State<AnalystCardListview> createState() => _AnalistCardListviewState();
}

class _AnalistCardListviewState extends State<AnalystCardListview> {
  final _scrollController = ScrollController();
  bool _isLoading = true;
  List<int> _favoritedList = [];

  @override
  void initState() {
    super.initState();
    _detectScrollBottom();
    _getFavorites();
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _getFavorites() async {
    // _favoritedList = locator<PreferencesService>().getSavedCharacters();
    _setLoading(false);
  }

  void _detectScrollBottom() {
    if (widget.onLoadMore != null) {
      _scrollController.addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.position.pixels;
        const int delta = 200;

        if (maxScroll - currentPosition <= delta) {
          widget.onLoadMore!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } 

    final infoList = widget.info?.info ?? [];

    return Flexible(
      child: ListView.builder(
        itemCount: infoList.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final stock = infoList[index];

          return Column(
            children: [
              AnalystCardview(
                stock: stock, 
              ),
              if (widget.loadMore && index == infoList.length - 1)
                const CircularProgressIndicator.adaptive(),
            ],
          );
        },
      ),
    );
  }
}
