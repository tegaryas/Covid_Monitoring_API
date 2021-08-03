import 'package:covid_monitoring_indo/models/province_model.dart';
import 'package:covid_monitoring_indo/services/api_service.dart';
import 'package:flutter/material.dart';

class ProvinceProvider with ChangeNotifier {
  var api = ApiServices();
  ProvinceModel province;

  Future<ProvinceModel> getProvinceModel() async {
    final response = await api.client.get(
      Uri.parse('${api.baseUrl}/api/provinsi/'),
    );

    if (response.statusCode == 200) {
      var res = provinceModelFromJson(response.body);

      province = res;
      notifyListeners();
      return province;
    } else {
      return throw Exception('Failed to fetch data');
    }
  }
}
