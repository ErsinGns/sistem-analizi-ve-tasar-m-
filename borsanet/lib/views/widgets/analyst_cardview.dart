import 'package:borsanet/app/router.dart';
import 'package:borsanet/models/analyst_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalystCardview extends StatefulWidget {
  final StockAnalysis stock;
  const AnalystCardview({
    super.key,
    required this.stock,
  });

  @override
  State<AnalystCardview> createState() => _AnalistCardviewState();
}

class _AnalistCardviewState extends State<AnalystCardview> {
  double _calculateAveragePrice(List<Analysis> analysisList) {
    if (analysisList.isEmpty) return 0.0;
    double total = analysisList.map((e) => e.priceTarget).reduce((a, b) => a + b);
    return total / analysisList.length;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '${AppRoutes.analyst}/${AppRoutes.detail}',
        extra: widget.stock.name,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.stock.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                _infoWidget(
                  icon: Icons.trending_up,
                  type: 'Ortalama Hedef Fiyat',
                  value: '${_calculateAveragePrice(widget.stock.analysis).toStringAsFixed(2)} \$',
                ),
                const SizedBox(height: 12),
                
                // Analysts
                _infoWidget(
                  icon: Icons.people,
                  type: 'Analistler',
                  value: widget.stock.analysis.map((e) => e.code).join(', '),
                ),
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoWidget({required IconData icon, required String type, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 12), // Consistent spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}