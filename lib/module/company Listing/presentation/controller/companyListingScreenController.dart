import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:joistic_job_portal/module/company%20Listing/data/model/companyListingModel.dart';
import 'package:joistic_job_portal/module/company%20Listing/domain/use_case/company_listing_use_case.dart';
import 'package:joistic_job_portal/network/api_client/api_client.dart';
import 'package:joistic_job_portal/network/api_service/api_constants.dart';

class CompanyListingScreenController extends GetxController {
  late final CompanyListingUseCase? _companyListingUseCase;

  var companyList = <CompanyListingModel>[].obs;
  var loading = true.obs;
  var isSearching = false.obs;

  // CompanyListingScreenController(this._companyListingUseCase);

  @override
  void onInit() {
    log('onInit called');
    getCompanyList();
    super.onInit();
  }

  getCompanyList() async {
    log("Api Call ");
    try {
      ApiClient()
          .get(
            ApiConstants.baseUrl,
            (p0) => companyListingModelFromJson(jsonEncode(p0)),
          )
          .then(
            (value) => value.handleResponse(
              onSuccess: (data) {
                log("Response Got it");
                companyList.value = data;
                log("companyList: ${companyList.length}");
              },
              onFailure: (errorMessage) {},
            ),
          );
    } catch (e) {}
  }

  applyNow(int? id) {
    log("Apply done");
    var index = companyList.indexWhere((element) => element.id == id);
    log("GG: ${companyList[index].isApply.obs.value}");

    companyList[index].isApply = true;
    companyList.refresh();
    log("GG: ${companyList[index].isApply}");
  }
}
