import 'dart:convert';

import 'package:joistic_job_portal/module/company%20Listing/data/model/companyListingModel.dart';
import 'package:joistic_job_portal/module/company%20Listing/domain/repository/company_listing_repository.dart';
import 'package:joistic_job_portal/network/api_client/api_client.dart';
import 'package:joistic_job_portal/network/api_service/api_constants.dart';
import 'package:joistic_job_portal/network/response_method/response.dart';

class CompanyListingIMPL implements CompanyListingRepository {
  final ApiClient apiClient;

  CompanyListingIMPL(this.apiClient);

  ///Create class
  @override
  Future<Response<List<CompanyListingModel>>> getCompanyList() {
    return apiClient.get(
      ApiConstants.baseUrl,
      (p0) => companyListingModelFromJson(jsonEncode(p0)),
    );
  }
}
