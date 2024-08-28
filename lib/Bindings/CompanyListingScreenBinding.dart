import 'dart:developer';

import 'package:get/get.dart';
import 'package:joistic_job_portal/injection_container.dart';
import 'package:joistic_job_portal/module/company%20Listing/presentation/controller/companyListingScreenController.dart';

class CompanyListingScreenBinding extends Bindings {
  @override
  void dependencies() {
    log("Bindings call");
    // TODO: implement dependencies
    Get.lazyPut(() => CompanyListingScreenController());
  }
}
