import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:joistic_job_portal/constants/app_color.dart';
import 'package:joistic_job_portal/custom_widgets/app_button.dart';
import 'package:joistic_job_portal/custom_widgets/custom_image_view.dart';
import 'package:joistic_job_portal/module/company%20Listing/presentation/controller/companyListingScreenController.dart';
import 'package:joistic_job_portal/utils/size_utils.dart';

class CompanyListingScreen extends GetView<CompanyListingScreenController> {
  const CompanyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final CompanyListingScreenController controller = Get.find();
    return Scaffold(
      drawer: Icon(Icons.drag_handle),
      appBar: AppBar(
        leading: Icon(Icons.drag_handle_outlined),
        actions: [
          Container(
            color: Colors.white,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Obx(() {
        log("companyList: ${controller.companyList.length}");

        return SingleChildScrollView(
          child: Padding(
            padding: getPadding(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Find your Dream job today",
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.w600),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.companyList.length,
                  itemBuilder: (context, index) {
                    var companyDetails = controller.companyList[index];
                    List<String> titleString =
                        (companyDetails.title ?? "").split(' ');
                    String newTitle = titleString.sublist(0, 2).join(' ');
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                clipBehavior: Clip.none,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: getPadding(all: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(height: 35),
                                        Text(
                                          newTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Text(
                                          "${companyDetails.title}",
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 35),
                                        Text(
                                          newTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(5),
                                        ),
                                        Text(
                                          "${companyDetails.title} ${companyDetails.title} ${companyDetails.title}",
                                          // maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: -35,
                                    left: 40,
                                    child: Container(
                                      padding: getPadding(all: 10),
                                      // height: getVerticalSize(30),
                                      // width: getHorizontalSize(30),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SizedBox(
                                        height: getVerticalSize(55),
                                        width: getVerticalSize(55),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.grey,
                                          child: ClipRRect(
                                            clipBehavior: Clip.antiAlias,
                                            child: ClipOval(
                                              child: CustomImageView(
                                                // fit: BoxFit.contain,
                                                url: companyDetails.url,
                                                height: getVerticalSize(40),
                                                width: getHorizontalSize(40),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!(companyDetails.isApply ?? false))
                                    Padding(
                                      padding: getPadding(all: 20),
                                      child: AppButton(
                                        onTap: () {
                                          controller
                                              .applyNow(companyDetails.id);
                                          Get.back();
                                        },
                                        buttonText: "Apply Now",
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        margin: getMargin(bottom: 20),
                        color: Colors.white,
                        child: Padding(
                          padding: getPadding(all: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: getVerticalSize(55),
                                width: getVerticalSize(55),
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.grey.withOpacity(0.3),
                                  child: ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    child: ClipOval(
                                      child: CustomImageView(
                                        url: companyDetails.url,
                                        height: getVerticalSize(40),
                                        width: getHorizontalSize(40),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getHorizontalSize(10),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(5),
                                    ),
                                    Text(
                                      "${companyDetails.title}",
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getHorizontalSize(10),
                              ),
                              Container(
                                padding: getPadding(all: 10),
                                height: getVerticalSize(30),
                                width: getHorizontalSize(30),
                                decoration: BoxDecoration(
                                  color: companyDetails.isApply ?? false
                                      ? Colors.green
                                      : Colors.deepPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
