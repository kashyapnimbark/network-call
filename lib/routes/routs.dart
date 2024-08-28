import 'package:get/get.dart';
import 'package:joistic_job_portal/module/company%20Listing/presentation/pages/companyListingScreen.dart';
import '../Bindings/CompanyListingScreenBinding.dart';

class Routes {
  static const String companyListingScreen = "/CompanyListingScreen";

  static final routs = [
    GetPage(
        name: companyListingScreen,
        page: () => const CompanyListingScreen(),
        binding: CompanyListingScreenBinding()),
  ];
}
