import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:albay_1_pas_flutter/models/team_model.dart';

class FeatController extends GetxController {
  var isLoading = true.obs;
  var teamList = <Team>[].obs;

  final String apiUrl =
      "https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php?l=English%20Premier%20League";

  @override
  void onInit() {
    super.onInit();
    fetchTeams();
  }

  void fetchTeams() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final premierLeagueModel = premierLeagueModelFromJson(response.body);
        teamList.assignAll(premierLeagueModel.teams);
      } else {
        Get.snackbar("Error", "Gagal memuat data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }
}
