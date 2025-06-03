import 'package:get/get.dart';
import 'package:cekgizi_mobile/app/data/Model/userModel.dart';
import 'package:cekgizi_mobile/app/data/Url/Urls.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailProfileController extends GetxController {
  // Observable variable to hold user data
  Rx<Usermodel?> user = Rx<Usermodel?>(null);
  var isLoading = true.obs; // Loading indicator

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile(); // Fetch user profile when the controller is initialized
  }

  // Method to fetch user profile from the API
  void fetchUserProfile() async {
    try {
      isLoading.value = true;
      final box = GetStorage();
      final token = box.read("token"); // Get the token from GetStorage

      if (token == null) {
        // Handle case where token is not available (user not logged in)
        isLoading.value = false;
        Get.snackbar("Error", "User not logged in.");
        return;
      }

      // Update the API call to use the new /auth/profile endpoint
      final response = await http.get(
        Uri.parse("${Urls().url}/auth/profile"), // <-- Updated endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the JWT token
        },
      );

      print(
        "API Response Status Code: ${response.statusCode}",
      ); // Print status code
      print("API Response Body: ${response.body}"); // Print response body

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        print("Decoded JSON Data: $responseData"); // Print decoded JSON

        // Assuming the response body is the user object directly or within a 'user' key
        if (responseData is Map<String, dynamic>) {
          // Adjust this based on your actual API response structure
          user.value = Usermodel.fromJson(responseData);
        } else if (responseData['user'] is Map<String, dynamic>) {
          user.value = Usermodel.fromJson(responseData['user']);
        } else {
          Get.snackbar("Error", "Invalid API response format.");
        }

        print(
          "User observable value after processing: ${user.value}",
        ); // Print observable value
      } else {
        // Handle API errors
        Get.snackbar(
          "Error",
          "Failed to fetch profile: ${response.statusCode}",
        );
      }
    } catch (e) {
      // Handle network or other errors
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //TODO: Implement DetailProfileController

  final count = 0.obs;
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
