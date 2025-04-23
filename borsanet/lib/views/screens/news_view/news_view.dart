import 'package:borsanet/views/screens/news_view/news_viewmodel.dart';
import 'package:borsanet/views/widgets/appbar_widget.dart';
import 'package:borsanet/views/widgets/news_card_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsViewmodel>().getNews();
    
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsViewmodel>();
    return Scaffold(
      appBar: AppBarWidget(title: "Borsa Net"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              viewModel.newsModel == null
              ? const CircularProgressIndicator.adaptive()
              : NewsCardListview(
                news: viewModel.newsModel,     
                onLoadMore: () => viewModel.getNewsMore(),
                loadMore: viewModel.loadMore,          
              )
            ],
          ),
        ),
      ),
    );
  }
}


