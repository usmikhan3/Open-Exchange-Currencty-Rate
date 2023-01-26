import 'package:currency_rate/model/all_currencies.dart';
import 'package:currency_rate/model/rates_model.dart';
import 'package:currency_rate/utils/key.dart';
import 'package:http/http.dart' as http;

class APIServices {
  static Future<RatesModel> fetchRates() async {
    try {
      var response = await http.get(
        Uri.parse(
            "https://openexchangerates.org/api/latest.json?base=USD&app_id=" +
                key),
      );
      final result = ratesModelFromJson(response.body);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Map> fetchCurrencies() async {
    try {
      var response = await http.get(
        Uri.parse(
            "https://openexchangerates.org/api/currencies.json?app_id=" + key),
      );
      final allCurrencies = allCurrenciesFromJson(response.body);
      return allCurrencies;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static String convertToUsd(Map exchangeRates, String pkr, String currency) {
    String output =
    ((exchangeRates[currency] * double.parse(pkr)).toStringAsFixed(2))
            .toString();
    return output;
  }

  static String convertToAny(Map exchangeRates, String amount,
      String currencybase, String currencyFinal) {
    String output = (double.parse(amount) /
            exchangeRates[currencybase] *
            exchangeRates[currencyFinal])
        .toStringAsFixed(2)
        .toString();
    return output;
  }
}
