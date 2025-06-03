import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cekgizi_mobile/app/data/Model/news_model.dart';

class BeritaController extends GetxController {
  var beritaList = <NewsModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    isLoading.value = true;
    const apiKey = '96fc156bb6fc4e16a194760011e008ff'; // Ganti dengan key NewsAPI kamu
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=gizi OR kesehatan OR nutrisi OR makanan sehat&language=id&sortBy=publishedAt&pageSize=10&apiKey=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      beritaList.value = articles.map((json) => NewsModel.fromJson(json)).toList();
    } else {
      beritaList.clear();
    }
    isLoading.value = false;
  }
}
