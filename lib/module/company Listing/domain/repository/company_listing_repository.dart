import 'package:joistic_job_portal/module/company%20Listing/data/model/companyListingModel.dart';
import 'package:joistic_job_portal/network/response_method/response.dart';

abstract class CompanyListingRepository {
  Future<Response<List<CompanyListingModel>>> getCompanyList();
}
