
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';


var baseUrl = "https://opentdb.com";
Future<ExamsModel> getQuiz() async {
  try {
    http.Response res = await http.get(Uri.parse('$baseUrl/api.php?amount=50'));
    if (res.statusCode == 200) {
      http.Response response=res;
      ExamsModel data = ExamsModel.fromJson(jsonDecode(response.body));
      
      return data;
    }
    else{
      throw "Exception";
    }
  } catch (e) {
    throw 'Exception';
  }

}
