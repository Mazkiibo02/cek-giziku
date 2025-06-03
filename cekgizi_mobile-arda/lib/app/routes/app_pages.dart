import 'package:get/get.dart';

import '../data/middleware/auth.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/detailProfile/bindings/detail_profile_binding.dart';
import '../modules/detailProfile/views/detail_profile_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_page/bindings/home_page_binding.dart';
import '../modules/home_page/views/home_page_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/controllers/login_controller.dart';
import '../modules/mainpages/bindings/mainpages_binding.dart';
import '../modules/mainpages/views/mainpages_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/reset_password_c/bindings/reset_password_c_binding.dart';
import '../modules/reset_password_c/views/reset_password_c_view.dart';
import '../modules/reset_password_e/bindings/reset_password_e_binding.dart';
import '../modules/reset_password_e/views/reset_password_e_view.dart';
import '../modules/reset_password_pb/bindings/reset_password_pb_binding.dart';
import '../modules/reset_password_pb/views/reset_password_pb_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/scan_pages/bindings/scan_pages_binding.dart';
import '../modules/scan_pages/views/scan_pages_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/loading.dart';
import '../modules/splash/views/splash_page_1.dart';
import '../modules/splash/views/splash_page_2.dart';
import '../modules/splash/views/splash_page_3.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/verifikasi_email/bindings/verifikasi_email_binding.dart';
import '../modules/verifikasi_email/views/verifikasi_email_view.dart';

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
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH1,
      page: () => SplashPage1(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH2,
      page: () => SplashPage2(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH3,
      page: () => SplashPage3(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOADING,
      page: () => LoadingPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PROFILE,
      page: () => const DetailProfileView(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.put<LoginController>(LoginController());
      }),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD_C,
      page: () => const ResetPasswordCView(),
      binding: ResetPasswordCBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD_PB,
      page: () => const ResetPasswordPbView(),
      binding: ResetPasswordPbBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD_E,
      page: () => const ResetPasswordEView(),
      binding: ResetPasswordEBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_PAGES,
      page: () => const ScanPagesView(),
      binding: ScanPagesBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI_EMAIL,
      page: () => const VerifikasiEmailView(),
      binding: VerifikasiEmailBinding(),
    ),
    GetPage(
      name: _Paths.MAINPAGES,
      page: () => const MainpagesView(),
      binding: MainpagesBinding(),
      middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          name: _Paths.HOME_PAGE,
          page: () => const HomePageView(),
          binding: HomePageBinding(),
        ),
        GetPage(
          name: _Paths.PROFIL,
          page: () => ProfilView(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: _Paths.SCAN_PAGES,
          page: () => const ScanPagesView(),
          binding: ScanPagesBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BERITA,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
  ];
}
