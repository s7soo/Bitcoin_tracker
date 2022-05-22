import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EGP',
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
String urlBTC = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[0]}/';
String urlETH = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[1]}/';
String urlLTC = 'https://rest.coinapi.io/v1/exchangerate/${cryptoList[2]}/';

String apikey = '3218758F-4683-4254-832D-FEF7857890D5';


class CoinData {
  CoinData({this.currency});
  final currency;

  Future<dynamic> getDataFromUrl() async{

    List<double> pricesList = [];

    var url0 = Uri.parse('$urlBTC$currency?apikey=$apikey');
    var url1 = Uri.parse('$urlETH$currency?apikey=$apikey');
    var url2 = Uri.parse('$urlLTC$currency?apikey=$apikey');

    http.Response response0 = await http.get(url0) ;
    http.Response response1 = await http.get(url1) ;
    http.Response response2 = await http.get(url2) ;

    if(response0.statusCode == 200 && response1.statusCode == 200 && response2.statusCode == 200) {
        pricesList.add(jsonDecode(response0.body)['rate']);
        pricesList.add(jsonDecode(response1.body)['rate']);
        pricesList.add(jsonDecode(response2.body)['rate']);

      return pricesList;
    }else{
      print(response0.statusCode);
    }
  }
}
