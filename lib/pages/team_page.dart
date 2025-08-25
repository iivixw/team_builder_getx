import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';
import 'member_list_page.dart' show kPastelPinkBg;

class TeamPage extends GetView<TeamController> {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor: kPastelPinkBg,
      body: Obx(() {
        final team = controller.savedTeam;
        if (team.isEmpty) {
          return const Center(child: Text('ยังไม่มีทีมที่บันทึกไว้'));
        }
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              margin: const EdgeInsets.all(16),
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('ทีมของคุณ (3 คน)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...team.map((m) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFFFD1E7),
                            child: Text(
                              m.name.characters.first.toUpperCase(),
                              style: const TextStyle(color: Color(0xFF7A294F)),
                            ),
                          ),
                          title: Text(m.name),
                        )),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: controller.clearSavedTeam,
                          child: const Text('ลบทีม'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () => Get.offAllNamed('/'),
                          child: const Text('สร้างทีมใหม่'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text('ทีมที่บันทึกไว้'));
  }
}
