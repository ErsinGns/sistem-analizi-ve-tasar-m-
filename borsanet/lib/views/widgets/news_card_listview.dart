import 'package:borsanet/models/news_model.dart';
import 'package:borsanet/views/widgets/news_cardview.dart';
import 'package:flutter/material.dart';

class NewsCardListview extends StatefulWidget {
  final NewsModel? news;
  final VoidCallback? onLoadMore;
  final bool loadMore;
  const NewsCardListview(
      {super.key, required this.news, this.onLoadMore, required this.loadMore});

  @override
  State<NewsCardListview> createState() => _NewsCardListviewState();
}

class _NewsCardListviewState extends State<NewsCardListview> {
  final _scrollController = ScrollController();
  bool _isLoading = true;
  

  @override
  void initState() {
    _getFavorites();
    _detectScrollBottom();
    super.initState();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  void _getFavorites() async {
    // _favoritedList = locator<PreferencesService>().getSavedCharacters();
    _setLoading(false);
    setState(() {});
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
      return const CircularProgressIndicator.adaptive();
    } else {
      return Flexible(
        child: ListView.builder(
      itemCount: widget.news!.news.length,
          
          controller: _scrollController,
          itemBuilder: (context, index) {
            final characterModel = widget.news?.news[index];
            return Column(
              children: [
                NewsCardview(
                    aNewsModel: characterModel),
                if (widget.loadMore && index == 3)
                  const CircularProgressIndicator.adaptive()
              ],
            );
          },
        ),
      );
    }
  }
}
