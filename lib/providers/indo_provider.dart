import 'package:covid_monitoring_indo/models/indo_model.dart';
import 'package:covid_monitoring_indo/services/api_service.dart';
import 'package:flutter/material.dart';

class IndoProvider with ChangeNotifier {
  var api = ApiServices();
  IndoModel indo;

  Future<IndoModel> getIndoProvider() async {
    final response = await api.client
        .get(Uri.parse('https://covid19.mathdro.id/api/countries/Indonesia'));

    if (response.statusCode == 200) {
      var res = indoModelFromJson(response.body);

      indo = res;
      notifyListeners();
      return indo;
    } else {
      return throw Exception('Failed to fetch data');
    }
  }
}
