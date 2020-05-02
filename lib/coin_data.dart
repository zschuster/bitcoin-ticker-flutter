import 'dart:convert';
import 'key.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  static const String basePath = 'https://rest.coinapi.io/v1/exchangerate';

  Map<String, String> dataCache = {};

  Future<Map<String, String>> getCoinData({String curr}) async {
    String currUp = curr.toUpperCase();
    Map<String, String> returnMap = {};

    for (String crypto in cryptoList) {
      String key = '$crypto$currUp';
      if (dataCache[key] == null) {
        String url = basePath + '/$crypto/$currUp?apikey=$kApiKey';
        http.Response response = await http.get(url);
        double rate = jsonDecode(response.body)['rate'];

        dataCache[key] = rate.toStringAsFixed(2);
      }
      returnMap[key] = dataCache[key];
    }


    return returnMap;
  }
}
