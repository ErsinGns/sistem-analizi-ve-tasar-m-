class StockAnalysis {
  final String name;
  final List<Analysis> analysis;

  StockAnalysis({required this.name, required this.analysis});

  factory StockAnalysis.fromJson(Map<String, dynamic> json) {
    return StockAnalysis(
      name: json['name'],
      analysis: (json['analysis'] as List)
          .map((item) => Analysis.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'analysis': analysis.map((item) => item.toJson()).toList(),
    };
  }
}

class Analysis {
  final String publishedAt;
  final String code;
  final String title;
  final double priceTarget;
  final String type;

  Analysis({
    required this.publishedAt,
    required this.code,
    required this.title,
    required this.priceTarget,
    required this.type,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      publishedAt: json['published_at'],
      code: json['code'],
      title: json['title'],
      priceTarget: (json['price_target'] as num).toDouble(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'published_at': publishedAt,
      'code': code,
      'title': title,
      'price_target': priceTarget,
      'type': type,
    };
  }
}

class StockData {
  final List<StockAnalysis> info;
   String? before;
   String? after;

  StockData({required this.info,  this.before,  this.after});

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      info: (json['info'] as List)
          .map((item) => StockAnalysis.fromJson(item))
          .toList(),
      before: json['before'],
      after: json['after'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.map((item) => item.toJson()).toList(),
      'before': before,
      'after': after,
    };
  }
}
