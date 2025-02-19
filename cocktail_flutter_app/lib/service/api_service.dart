import 'package:dio/dio.dart';
import '../model/Cocktail.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Cocktail>> fetchCocktails() async {
    try {
      final response = await dio.get('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rum');

      
      if (response.statusCode == 200 && response.data != null && response.data['drinks'] != null) {
        List data = response.data['drinks'];
        
        return data.map((json) => Cocktail.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cocktails: ${response.statusCode}');
      }
    } catch (e) {
    
      print("Error fetching cocktails: $e");
      throw Exception('Failed to load cocktails');
    }
  }
}
