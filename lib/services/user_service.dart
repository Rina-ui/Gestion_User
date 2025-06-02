import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService{
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<User>> fetchUsers() async {
    try{
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        List<dynamic>jsonList = json.decode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors du chargement des utilisateurs');
      }
    }catch (e){
      throw Exception('Erreur de connexion: $e');
    }
  }
}