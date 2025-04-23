class NewsModel {
  List<NewsItem> news;
  String? before;
  String? after;

  NewsModel({
    required this.news,
    required this.before,
    required this.after,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final news = (json["news"] as List)
        .map((item) => NewsItem.fromJson(item))
        .toList();

    return NewsModel(
      news: news,
      before: json['before'],
      after: json['after'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'news': news.map((item) => item.toJson()).toList(),
      'before': before,
      'after': after,
    };
  }
}

class NewsItem {
  final String stockSymbol;
  final String analysisDate;
  final InputSource inputSource;
  final String overview;
  final Summary summary;
  final Metrics metrics;

  NewsItem({
    required this.stockSymbol,
    required this.analysisDate,
    required this.inputSource,
    required this.overview,
    required this.summary,
    required this.metrics,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      stockSymbol: json['stock_symbol'],
      analysisDate: json['analysis_date'],
      inputSource: InputSource.fromJson(json['input_source']),
      overview: json['overview'],
      summary: Summary.fromJson(json['summary']),
      metrics: Metrics.fromJson(json['metrics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stock_symbol': stockSymbol,
      'analysis_date': analysisDate,
      'input_source': inputSource.toJson(),
      'overview': overview,
      'summary': summary.toJson(),
      'metrics': metrics.toJson(),
    };
  }
}

class InputSource {
  final String type;
  final InputSourceDetails details;

  InputSource({required this.type, required this.details});

  factory InputSource.fromJson(Map<String, dynamic> json) {
    return InputSource(
      type: json['type'],
      details: InputSourceDetails.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'details': details.toJson(),
    };
  }
}

class InputSourceDetails {
  final String sourceIdentifier;
  final List<String> keywords;
  final List<String> sampleContent;

  InputSourceDetails({
    required this.sourceIdentifier,
    required this.keywords,
    required this.sampleContent,
  });

  factory InputSourceDetails.fromJson(Map<String, dynamic> json) {
    return InputSourceDetails(
      sourceIdentifier: json['source_identifier'],
      keywords: List<String>.from(json['keywords']),
      sampleContent: List<String>.from(json['sample_content']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source_identifier': sourceIdentifier,
      'keywords': keywords,
      'sample_content': sampleContent,
    };
  }
}

class Summary {
  final String overallSentiment;
  final String keyPoints;
  final String recommendation;

  Summary({
    required this.overallSentiment,
    required this.keyPoints,
    required this.recommendation,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      overallSentiment: json['overall_sentiment'],
      keyPoints: json['key_points'],
      recommendation: json['recommendation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'overall_sentiment': overallSentiment,
      'key_points': keyPoints,
      'recommendation': recommendation,
    };
  }
}

class Metrics {
  final String confidenceLevel;
  final String dataVolume;

  Metrics({
    required this.confidenceLevel,
    required this.dataVolume,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      confidenceLevel: json['confidence_level'],
      dataVolume: json['data_volume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confidence_level': confidenceLevel,
      'data_volume': dataVolume,
    };
  }
}
