// To parse this JSON data, do
//
//     final quoteDay = quoteDayFromJson(jsonString);

import 'dart:convert';

QuoteDay quoteDayFromJson(String str) => QuoteDay.fromJson(json.decode(str));

String quoteDayToJson(QuoteDay data) => json.encode(data.toJson());

class QuoteDay {
  QuoteDay({
    this.success,
    this.contents,
    this.baseurl,
    this.copyright,
  });

  Success success;
  Contents contents;
  String baseurl;
  Copyright copyright;

  factory QuoteDay.fromJson(Map<String, dynamic> json) => QuoteDay(
        success: Success.fromJson(json["success"]),
        contents: Contents.fromJson(json["contents"]),
        baseurl: json["baseurl"],
        copyright: Copyright.fromJson(json["copyright"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
        "contents": contents.toJson(),
        "baseurl": baseurl,
        "copyright": copyright.toJson(),
      };
}

class Contents {
  Contents({
    this.quotes,
  });

  List<Quote> quotes;

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
      };
}

class Quote {
  Quote({
    this.quote,
    this.length,
    this.author,
    this.tags,
    this.category,
    this.language,
    this.date,
    this.permalink,
    this.id,
    this.background,
    this.title,
  });

  String quote;
  String length;
  String author;
  List<String> tags;
  String category;
  String language;
  DateTime date;
  String permalink;
  String id;
  String background;
  String title;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quote: json["quote"],
        length: json["length"],
        author: json["author"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        category: json["category"],
        language: json["language"],
        date: DateTime.parse(json["date"]),
        permalink: json["permalink"],
        id: json["id"],
        background: json["background"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "length": length,
        "author": author,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "category": category,
        "language": language,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "permalink": permalink,
        "id": id,
        "background": background,
        "title": title,
      };
}

class Copyright {
  Copyright({
    this.year,
    this.url,
  });

  int year;
  String url;

  factory Copyright.fromJson(Map<String, dynamic> json) => Copyright(
        year: json["year"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "url": url,
      };
}

class Success {
  Success({
    this.total,
  });

  int total;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
