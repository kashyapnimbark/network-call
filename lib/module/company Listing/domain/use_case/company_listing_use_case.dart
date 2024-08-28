import 'dart:developer';

import 'package:joistic_job_portal/module/company%20Listing/data/model/companyListingModel.dart';
import 'package:joistic_job_portal/module/company%20Listing/domain/repository/company_listing_repository.dart';
import 'package:joistic_job_portal/network/response_method/response.dart';

class CompanyListingUseCase {
  final CompanyListingRepository _companyListingRepository;

  CompanyListingUseCase(this._companyListingRepository);

  Future<Response<List<CompanyListingModel>>> getCompanyList() {
    log("CAlll done");
    return _companyListingRepository.getCompanyList();
  }
}

