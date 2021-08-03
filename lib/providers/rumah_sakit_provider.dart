import 'package:covid_monitoring_indo/models/rumah_sakit_model.dart';
import 'package:covid_monitoring_indo/services/api_service.dart';
import 'package:flutter/material.dart';

class RumahSakitProvider with ChangeNotifier {
  var api = ApiServices();
  List<RumahSakitModel> rumahSakit = [];

  Future<List<RumahSakitModel>> getRumahSakitModel() async {
    final response = await api.client.get(
      Uri.parse('https://dekontaminasi.com/api/id/covid19/hospitals'),
    );

    if (response.statusCode == 200) {
      final res = rumahSakitModelFromJson(response.body);

      rumahSakit = res;
      notifyListeners();

      return rumahSakit;
    } else {
      return throw Exception('Failed to fetch data');
    }
  }
}
