import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';
import '../models/member.dart';

const kPastelPinkBg = Color(0xFFFFF1F5);
const kPinkStrong = Color(0xFFC2185B); // สีข้อความ "เลือกแล้ว: x / 3 คน" ให้ตรงรูปที่ 1

class MemberListPage extends GetView<TeamController> {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกสมาชิกเพื่อสร้างทีม (3 คน)')),
      backgroundColor: kPastelPinkBg,
      body: Obx(() {
        final items = controller.members;
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 108),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) => _MemberTile(
            member: items[i],
            selected: controller.isSelected(items[i]),
            onTap: () => controller.toggle(items[i]),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final count = controller.selectedIds.length;
        final enabled = count == 3;
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'เลือกแล้ว: $count / 3 คน',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPinkStrong,        // ใช้ชมพูเข้มเหมือนรูปที่ 1 เสมอ
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FilledButton.tonal(
                  onPressed: enabled ? controller.createTeam : null,
                  child: const Text('สร้างทีม'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: controller.selectedIds.isEmpty
                      ? null
                      : controller.selectedIds.clear,
                  child: const Text('ล้างเลือก'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final Member member;
  final bool selected;
  final VoidCallback onTap;

  const _MemberTile({
    required this.member,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFFFFE7EF) : Colors.white;
    final border = selected ? const Color(0xFFFF8FB1) : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFFFD1E7),
                  child: Text(
                    member.name.characters.first.toUpperCase(),
                    style: const TextStyle(color: Color(0xFF7A294F)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    member.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: selected
                      ? Container(
                          key: const ValueKey('picked'),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC2E9),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text('เลือกแล้ว',
                              style: TextStyle(fontSize: 12, color: Color(0xFF7A294F))),
                        )
                      : const SizedBox.shrink(key: ValueKey('nopick')),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: selected
                      ? const Icon(Icons.check_circle, color: kPinkStrong, key: ValueKey('on'))
                      : const Icon(Icons.radio_button_unchecked, color: Colors.grey, key: ValueKey('off')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
