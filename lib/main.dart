import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/team_controller.dart';
import 'pages/member_list_page.dart';
import 'pages/team_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Team Builder (GetX)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(TeamController());
      }),
      // ⬇️ เอา const ออก และใช้ () => const Widget()
      getPages: [
        GetPage(name: '/', page: () => const MemberListPage()),
        GetPage(name: '/team', page: () => const TeamPage()),
      ],
    );
  }
}
