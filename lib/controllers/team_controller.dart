import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/member.dart';

class TeamController extends GetxController {
  final _box = GetStorage();

  final members = <Member>[].obs;
  final selectedIds = <int>{}.obs;
  final savedTeam = <Member>[].obs;

  static const _storeKey = 'saved_team';

  @override
  void onInit() {
    super.onInit();
    _loadMembers();
    _loadSavedTeam();
  }

  void _loadMembers() {
    const names = [
      'Aom','Beam','Cat','Don','Earn','Film','Game','Hana','Ice','Jane',
      'Kao','Mild','Noon','Oat','Palm','Pim','Q','Ray','Som','Tae',
      'Time','View','Win','Ying'
    ];
    members.assignAll([
      for (var i = 0; i < names.length; i++) Member(id: i + 1, name: names[i]),
    ]);
  }

  void toggle(Member m) {
    if (selectedIds.contains(m.id)) {
      selectedIds.remove(m.id);
      _toast('ยกเลิกเลือก: ${m.name}');
      return;
    }
    if (selectedIds.length >= 3) {
      Get.snackbar('ถึงลิมิตแล้ว', 'ทีมต้องมี **3 คนพอดี**',
          snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 2));
      return;
    }
    selectedIds.add(m.id);
    _toast('เลือก: ${m.name}');
  }

  bool isSelected(Member m) => selectedIds.contains(m.id);

  List<Member> get buildingTeam =>
      members.where((e) => selectedIds.contains(e.id)).toList();

  Future<void> createTeam() async {
    if (selectedIds.length != 3) {
      Get.snackbar('เลือกไม่ครบ', 'กรุณาเลือกให้ครบ 3 คน (ปัจจุบัน ${selectedIds.length})',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final team = buildingTeam;
    savedTeam.assignAll(team);
    await _box.write(_storeKey, team.map((e) => e.toMap()).toList());
    Get.toNamed('/team');
  }

  void _loadSavedTeam() {
    final raw = _box.read(_storeKey);
    if (raw is List) {
      savedTeam.assignAll(
        raw.cast<Map>().map((m) => Member.fromMap(m.cast<String, dynamic>())),
      );
    }
  }

  Future<void> clearSavedTeam() async {
    savedTeam.clear();
    await _box.remove(_storeKey);
    selectedIds.clear();
    Get.back();
    Get.snackbar('ลบทีมแล้ว', 'สร้างทีมใหม่ได้เลย',
        snackPosition: SnackPosition.BOTTOM);
  }

  void _toast(String msg) {
    Get.rawSnackbar(
      messageText: Text(msg, style: const TextStyle(color: Color(0xFF7A294F))),
      backgroundColor: const Color(0xFFFFE4F2),
      duration: const Duration(milliseconds: 900),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
    );
  }
}
