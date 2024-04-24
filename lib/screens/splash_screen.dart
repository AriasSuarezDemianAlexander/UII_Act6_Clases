import 'package:arias0315/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:arias0315/data/product_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            color: Color(0xffb26b3a), // Color café
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                      height:
                          20), // Separación adicional desde la parte superior
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: products.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onHorizontalDragEnd: (details) {
                                if (details.primaryVelocity! > 0) {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                } else if (details.primaryVelocity! < 0) {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                }
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                height: 400,
                                width: 400,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(products[index].img),
                                  ),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthScreen()));
                                    },
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                            SizedBox(
                                height:
                                    20), // Separación adicional entre la imagen y el texto
                            Center(
                              child: Text(
                                products[index].title,
                                style: TextStyle(
                                    fontSize: 28, // Texto más grande
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 5),
                            Center(
                              child: Text(
                                products[index].description,
                                style: TextStyle(
                                    fontSize: 18, // Texto más grande
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 10,
                            width: _currentPageIndex == index ? 25 : 10,
                            color: _currentPageIndex == index
                                ? Colors.red
                                : Colors.white);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _currentPageIndex == 2
                          ? ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.arrow_forward_ios))
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
