
import 'package:borsanet/views/screens/analyst_view/analyst_viewmodel.dart';
import 'package:borsanet/views/widgets/analyst_card_listview.dart';
import 'package:borsanet/views/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalystView extends StatefulWidget {
  const AnalystView({super.key});

  @override
  State<AnalystView> createState() => _AnalistViewState();
}

class _AnalistViewState extends State<AnalystView> {
   @override
  void initState() {
    super.initState();
    context.read<AnalystViewmodel>().getStock();
  }

  @override
  Widget build(BuildContext context) {
  final viewModel = context.watch<AnalystViewmodel>();

    print(viewModel.detail?.info[0].name);

    print("bbbbbbbbb");
    return Scaffold(
      appBar: AppBarWidget(title: "Analist Net"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              viewModel.detail == null
              ? const CircularProgressIndicator.adaptive()
              : AnalystCardListview(
                info: viewModel.detail, 
                onLoadMore: () => viewModel.getStockMore(),
                loadMore: viewModel.loadMore,      
              )
            ],
          ),
        ),
      ),
    );
  }
}
