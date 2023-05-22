import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_ideas/screens/favourites.dart';
import 'package:new_ideas/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  List<String> _imageList = [
    'https://images.unsplash.com/photo-1573408301185-9146fe634ad0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGpld2VsbGVyeXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://plus.unsplash.com/premium_photo-1678730056371-eff9c5356a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=1000&q=60',
    'https://images.unsplash.com/photo-1617038220319-276d3cfab638?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=1000&q=60'
  ];

  int _currentIndex = 0;

  late Timer _timer;
  int _duration = 3000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: 0.85,
    );
    _timer = Timer.periodic(Duration(milliseconds: _duration), (Timer timer) {
      if (_currentIndex < _imageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _imageList.map((String imagePath) {
        int index = _imageList.indexOf(imagePath);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            // width: 38.0,
            width: _currentIndex == index ? 35 : 8,
            height: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              color: _currentIndex == index ? Colors.white : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 234, 215, 215),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Color.fromARGB(255, 45, 44, 44),
            ),
            elevation: 06,
            onPressed: () {}),
      ),
      backgroundColor: greyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hii, Vamshi',
                        style: GoogleFonts.ubuntu(
                          fontSize: 28,
                          color: whiteColor,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Favourites()));
                              },
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                color: whiteColor,
                                size: 28,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        //title: const Text('Scan!'),
                                        children: [
                                          SimpleDialogOption(
                                            padding: const EdgeInsets.all(20),
                                            child: const Text('Logout'),
                                            onPressed: () {
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const Favourites()));
                                            },
                                          ),
                                          SimpleDialogOption(
                                            padding: const EdgeInsets.all(20),
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.power_settings_new,
                                color: whiteColor,
                                size: 28,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SizedBox(
                        height: 200,
                        child: PageView.builder(
                            controller: _pageController,
                            itemCount: _imageList.length,
                            onPageChanged: (int index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double value = 1.0;
                                  if (_pageController.position.haveDimensions) {
                                    value = (_pageController.page! - index);
                                    value = (1 - (value.abs() * 0.3))
                                        .clamp(0.0, 1.0);
                                  }
                                  return Center(
                                    child: SizedBox(
                                      height:
                                          Curves.easeInOut.transform(value) *
                                              200.0,
                                      width: Curves.easeInOut.transform(value) *
                                          2000.0,
                                      child: child,
                                    ),
                                  );
                                },

                                // scale: index == _currentIndex ? 0.8 : 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(250))),
                                    child: Image.network(
                                      _imageList[index],
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _buildIndicator(),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    'Traditional Picks',
                    style:
                        GoogleFonts.comfortaa(fontSize: 22, color: whiteColor),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.network(
                  'https://plus.unsplash.com/premium_photo-1678730056371-eff9c5356a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=1000&q=60',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    'Trending',
                    style:
                        GoogleFonts.comfortaa(fontSize: 22, color: whiteColor),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.network(
                  'https://plus.unsplash.com/premium_photo-1678730056371-eff9c5356a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=1000&q=60',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    'Top picks',
                    style:
                        GoogleFonts.comfortaa(fontSize: 22, color: whiteColor),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.network(
                  'https://plus.unsplash.com/premium_photo-1678730056371-eff9c5356a48?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8amV3ZWxsZXJ5fGVufDB8fDB8fHww&auto=format&fit=crop&w=1000&q=60',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
