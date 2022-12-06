import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_mobile/model/matches_model.dart';

class ListClient {
  static final String baseUrl = "https://copa22.medeiro.tech/matches";
  Future<List<MatchesModel>> getList() async {
    List<MatchesModel> match = [];
    var response = await http.get(Uri.parse(baseUrl));
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    for (var element in jsonData) {
      print(element);
      match.add(MatchesModel.fromJson(element));
    }
    return match;
  }
}
