import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/gantiPassword/bindings/ganti_password_binding.dart';
import '../modules/gantiPassword/views/ganti_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/listChat/bindings/list_chat_binding.dart';
import '../modules/listChat/views/list_chat_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/lupaPass/bindings/lupa_pass_binding.dart';
import '../modules/lupaPass/views/lupa_pass_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/updateProfil/bindings/update_profil_binding.dart';
import '../modules/updateProfil/views/update_profil_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_PASSWORD,
      page: () => const GantiPasswordView(),
      binding: GantiPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASS,
      page: () => const LupaPassView(),
      binding: LupaPassBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => const ListChatView(),
      binding: ListChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFIL,
      page: () => const UpdateProfilView(),
      binding: UpdateProfilBinding(),
    ),
  ];
}
