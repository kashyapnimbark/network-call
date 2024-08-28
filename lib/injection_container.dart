import 'package:get_it/get_it.dart';
import 'package:joistic_job_portal/module/company%20Listing/data/repository/company_listing_impl.dart';
import 'package:joistic_job_portal/module/company%20Listing/domain/repository/company_listing_repository.dart';
import 'package:joistic_job_portal/module/company%20Listing/domain/use_case/company_listing_use_case.dart';
import 'package:joistic_job_portal/module/company%20Listing/presentation/controller/companyListingScreenController.dart';
import 'network/api_client/api_client.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ApiClient>(ApiClient());

  ///News and Updates
  sl.registerSingleton<CompanyListingRepository>(CompanyListingIMPL(sl()));
  sl.registerSingleton<CompanyListingUseCase>(CompanyListingUseCase(sl()));
  // sl.registerFactory<CompanyListingScreenController>(
  //     () => CompanyListingScreenController(sl()));
}
