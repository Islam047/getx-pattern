import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/post_model.dart';
import '../pages/detail_page.dart';
import '../services/network_service.dart';

class HomeController extends GetxController{
  RxList items = [].obs;
  RxBool isLoading = false.obs;

  Future<void> apiPostList() async {
    isLoading(true);
    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items.value = Network.parsePostList(response);
    } else {
      items.value = [];
    }
    isLoading(false);

  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading(true);
    String? response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading(false);
   return response != null;

  }

  void goToDetailPage(BuildContext context) async {
    String? response =
    await Get.to(const DetailPage(state: DetailState.create));

    if (response == "add") {
      apiPostList();
    }
  }
  void goToDetailPageUpdate(Post post,BuildContext context) async {
    String? response =
    await Get.to(DetailPage(
      post: post,
      state: DetailState.update,
    ));
    if (response == "refresh") {
      apiPostList();
    }
  }

}