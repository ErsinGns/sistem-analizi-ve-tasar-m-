import 'package:borsanet/app/router.dart';
import 'package:borsanet/generated/l10n.dart';
import 'package:borsanet/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsCardview extends StatefulWidget {
  final NewsItem? aNewsModel;
  const NewsCardview({super.key, required this.aNewsModel});

  @override
  State<NewsCardview> createState() => _NewsCardviewState();
}

class _NewsCardviewState extends State<NewsCardview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '${AppRoutes.news}/${AppRoutes.detail}',
        extra: widget.aNewsModel?.stockSymbol,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
        child: Card( 
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16), 
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
                    widget.aNewsModel?.stockSymbol ?? S.of(context).Error,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                Text(
                  widget.aNewsModel?.summary.keyPoints ?? S.of(context).Error,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.aNewsModel?.analysisDate ?? S.of(context).Error,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
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
}