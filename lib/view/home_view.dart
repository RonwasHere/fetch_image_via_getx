// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_image_via_getx/components.dart';
import 'package:fetch_image_via_getx/controllers/simple_ui_controller.dart';
import 'package:fetch_image_via_getx/main.dart';
import 'package:fetch_image_via_getx/service/api_service.dart';
import 'package:fetch_image_via_getx/view/detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  SimpleUiController simpleUiController = Get.put(SimpleUiController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ApiService().getMethod(
        "https://api.unsplash.com/photos/?per_page=30&order_by=oldest&client_id=8r7hznUswxlk32AM40psd5U7dgaATwKOcTLtOAlxRmU");
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              //MyAppbar
              MyAppBar(size: size),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                      flex: 1,
                      child: _buildTabBar(),
                    ),
                    SizedBox(height: 25),
                    Expanded(
                      flex: 13,
                      child: Obx(
                        () => simpleUiController.isLoading.value
                            ? Center(
                                child: customLoading(),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: GridView.custom(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate: SliverQuiltedGridDelegate(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    pattern: [
                                      QuiltedGridTile(2, 2),
                                      QuiltedGridTile(1, 1),
                                      QuiltedGridTile(1, 1),
                                      QuiltedGridTile(1, 2),
                                    ],
                                  ),
                                  childrenDelegate: SliverChildBuilderDelegate(
                                    childCount: simpleUiController.photo.length,
                                    (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(DetailView(index: index));
                                        },
                                        child: Hero(
                                          tag: simpleUiController.photo[index].id!,
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: simpleUiController.photo[index].urls!['small'],
                                              imageBuilder: (context, img) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: img,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) => Center(
                                                child: customLoading(),
                                              ),
                                              errorWidget: (context, url, error) => Center(
                                                child: errorIcon(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: simpleUiController.orders.length,
      itemBuilder: (context, index) {
        return Obx(
          () => GestureDetector(
            onTap: () {
              simpleUiController.orderFunc(simpleUiController.orders[index]);
              simpleUiController.selectedIndex.value = index;
            },
            child: AnimatedContainer(
              margin: EdgeInsets.fromLTRB(index == 0 ? 15 : 5, 0, 5, 0),
              width: 100,
              decoration: BoxDecoration(
                color: index == simpleUiController.selectedIndex.value
                    ? Colors.grey[700]
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(
                    index == simpleUiController.selectedIndex.value ? 18 : 15),
              ),
              duration: Duration(milliseconds: 300),
              child: Center(
                child: Text(
                  simpleUiController.orders[index].toString(),
                  // '',
                  style: TextStyle(
                    color: index == simpleUiController.selectedIndex.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: size.width,
        height: size.height / 3.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
            image: AssetImage('assets/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'What would you like\n to find?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  width: double.infinity,
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 228, 228, 228),
                      contentPadding: EdgeInsets.only(top: 5),
                      prefix: Icon(
                        Icons.search,
                        size: 20,
                        color: Color.fromARGB(255, 146, 146, 146),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 131, 131, 131),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
