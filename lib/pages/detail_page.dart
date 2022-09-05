import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern/controllers/detail_controller.dart';

import '../model/post_model.dart';
import '../services/network_service.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailController controller = Get.put(DetailController());

  @override
  void initState() {
    super.initState();
    controller.init(widget.state, widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.state == DetailState.create
            ? const Text("Add post")
            : const Text("Update post"),
      ),
      body: Obx(() => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: controller.titleController,
                      decoration: InputDecoration(
                          label: const Text("Title"),
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      controller: controller.bodyController,
                      decoration: InputDecoration(
                          label: const Text("Body"),
                          hintText: "Body",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          border: const OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (widget.state == DetailState.create) {
                          controller.addPage(context);
                        } else {
                          controller.updatePost(context);
                        }
                      },
                      child: const Text("Submit Text"),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: controller.isLoading(),
                child: const CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            ],
          )),
    );
  }
}
