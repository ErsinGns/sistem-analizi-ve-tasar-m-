import 'package:borsanet/generated/l10n.dart';
import 'package:borsanet/models/analyst_model.dart';
import 'package:borsanet/views/screens/detail_view/detail_viewmodel.dart';
import 'package:borsanet/views/widgets/appbar_widget.dart';
import 'package:borsanet/views/widgets/decorated_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailView extends StatefulWidget {
  final String name;
  const DetailView({super.key, required this.name});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<DetailViewmodel>();
    viewModel.getDetailAnalyst(widget.name);
    viewModel.getDetailNews(widget.name);
  }

  double _calculateAveragePrice(List<Analysis>? analysisList) {
    if (analysisList == null || analysisList.isEmpty) return 0.0;
    double total = analysisList.map((e) => e.priceTarget).reduce((a, b) => a + b);
    return total / analysisList.length;
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DetailViewmodel>();
    final stockSymbol = data.newsData?.stockSymbol ?? "";
    final confidenceLevel = data.newsData?.metrics.confidenceLevel ?? "";
    final overview = data.newsData?.overview ?? "";

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(
          title: "${S.of(context).Detail} $stockSymbol",
          transparentBackground: true,
        ),
        body: DecoratedContainer(
          topChild: _mathematicalData(context, data),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight - 150,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (data.newsData?.analysisDate == null)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator.adaptive()),
                      )
                    else ...[
                      const SizedBox(height: 16),
                      _overviewSection(overview),
                      const SizedBox(height: 24),
                      _confidenceSection(confidenceLevel),
                      const SizedBox(height: 20),
                      const Spacer(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mathematicalData(BuildContext context, DetailViewmodel data) {
    double avgPrice = _calculateAveragePrice(data.analystData?.info[0].analysis);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Ortalama Hedef Fiyat',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${avgPrice.toStringAsFixed(2)} ₺',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewSection(String overview) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Genel Bakış',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              overview,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _confidenceSection(String confidenceLevel) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Güven Seviyesi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                confidenceLevel,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}