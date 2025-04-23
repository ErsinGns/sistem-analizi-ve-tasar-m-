import 'package:borsanet/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:borsanet/views/widgets/appbar_widget.dart';
import 'package:borsanet/views/widgets/news_card_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewmodel>();

    return Scaffold(
      appBar: const AppBarWidget(title: 'favoriler'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              SizedBox(height: 20),
              viewModel.aNewsModel == null
              ? const CircularProgressIndicator.adaptive()
              : NewsCardListview(
                news: viewModel.aNewsModel,
                onLoadMore: () => viewModel.getCharactersMore(),
                loadMore: viewModel.loadMore,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(BuildContext context,
      {required FavouritesViewmodel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: viewModel.getNews,
        decoration: InputDecoration(
            hintText: 'Hisse Ara',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            // suffixIcon: PopupMenuButton(
            //   icon: const Icon(Icons.more_vert),
            //   itemBuilder: (context) {
            //     return [
            //       PopupMenuItem<int>(
            //         value: 1,
            //         child: Text('Option 1'),
            //       ),
            //       PopupMenuItem<int>(
            //         value: 2,
            //         child: Text('Option 2'),
            //       ),
            //     ];
            //   },
            // ),
            ),
      ),
    );
  }
}
