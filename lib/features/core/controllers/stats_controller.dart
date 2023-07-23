import 'package:budget_buddy/features/core/models/stats_info_model.dart';
import 'package:budget_buddy/features/core/models/stats_model.dart';
import 'package:budget_buddy/repositories/core_repository/stats_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  @override
  void onInit() {
    getStats();
    getStatsInfo();
    super.onInit();
  }

  var stats = StatsModel().obs;
  var statsInfoWeek = StatsInfoModel().obs;
  var statsInfoMonth = StatsInfoModel().obs;
  var statsInfoYear = StatsInfoModel().obs;
  List<Daily>? daily;
  final storage = const FlutterSecureStorage();

  getUserId() async {
    var userId = await storage.read(key: 'token');
    return userId;
  }

  getStats() async {
    var userId = await getUserId();
    var response = await StatsRepository().getStats(userId);
    stats.value = response;
    daily = stats.value.daily;
  }

  getStatsInfo() async {
    var userId = await getUserId();
    statsInfoWeek.value = await StatsRepository().getStatsInfo(userId, 0);
    statsInfoMonth.value = await StatsRepository().getStatsInfo(userId, 1);
    statsInfoYear.value = await StatsRepository().getStatsInfo(userId, 2);
  }

  void refreshStats() {
    getStats();

    update(); // Wywołanie update() spowoduje, że GetBuilder, Obx itp. zostaną ponownie zbudowane z aktualnymi danymi
  }
}
