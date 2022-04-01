import 'dart:convert';
import 'package:frase_day/Models/QuoteDay.dart';
import 'package:http/http.dart' as http;

Future<QuoteDay> quoteOfTheDay() async {
  var headers = {
    "Content-Type": "application/json",
  };
  final url = "https://quotes.rest/qod?language=en";

  final resp = await http.get(
    url,
    headers: headers,
  );

  final decodedData = json.decode(resp.body);
  if (resp.statusCode == 403) {
    return null;
  }
  if (resp.statusCode == 500) {
    return null;
  }

  if (resp.statusCode == 429) {
    return null;
  }
  if (resp.statusCode == 200) {
    final quote = new QuoteDay.fromJson(decodedData);

    return quote;
  }

  return null;
}
