// To parse this JSON data, do
//
//     final companyListingModel = companyListingModelFromJson(jsonString);

import 'dart:convert';

List<CompanyListingModel> companyListingModelFromJson(String str) =>
    List<CompanyListingModel>.from(
        json.decode(str).map((x) => CompanyListingModel.fromJson(x)));

String companyListingModelToJson(List<CompanyListingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyListingModel {
  int? albumId;
  bool? isApply;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  CompanyListingModel({
    this.albumId,
    this.isApply = false,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  CompanyListingModel copyWith({
    int? albumId,
    bool? isApply = false,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) =>
      CompanyListingModel(
        albumId: albumId ?? this.albumId,
        isApply: isApply ?? this.isApply,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory CompanyListingModel.fromJson(Map<String, dynamic> json) =>
      CompanyListingModel(
        albumId: json["albumId"],
        isApply: json["isApply"] ?? false,
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "isApply": isApply,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
