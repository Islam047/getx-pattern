import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getx_pattern/controllers/home_controller.dart';
import '../model/post_model.dart';
import 'package:get/get.dart';

import '../views/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: [
              ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return ItemsOfPost(
                      post: controller.items[index],
                      controller: controller,
                    );
                  }),
              Visibility(
                visible: controller.isLoading(),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {
              controller.goToDetailPage(context);
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
