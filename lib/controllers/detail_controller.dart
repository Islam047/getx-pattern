import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern/model/post_model.dart';
import 'package:getx_pattern/pages/detail_page.dart';

import '../services/network_service.dart';

class DetailController extends GetxController{
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  RxBool isLoading = false.obs;

  void init(DetailState state,Post? post) {
    if (state == DetailState.update) {
      titleController = TextEditingController(text: post!.title);
      bodyController = TextEditingController(text: post.body);
    }
  }

  void updatePost(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading(true);
    Network.PUT(Network.API_UPDATE, post.toJson()).then((value) {
      Get.back(result: "refresh");
    });
    isLoading(false);
  }

  void addPage(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading(true);
    Network.POST(Network.API_UPDATE, post.toJson()).then((value) {
      Get.back( result: "add");
    });
    isLoading(false);
  }
}