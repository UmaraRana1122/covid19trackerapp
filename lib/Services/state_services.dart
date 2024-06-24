import 'dart:convert';

import 'package:covid19trackerapp/Services/Utlities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/worl_state_model.dart';

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
}
