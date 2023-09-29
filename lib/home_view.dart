import 'package:fetch_image_via_getx/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      flex: 13,
                      child: Container(
                        color: Colors.yellow,
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
