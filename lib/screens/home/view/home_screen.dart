import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? T,F;
  @override
  Widget build(BuildContext context) {
    T =Provider.of<HomeProvider>(context,listen: true);
    F =Provider.of<HomeProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                child: TextField(
                  controller: T!.txtsearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: IconButton(onPressed: () {
                      var newlink = T!.txtsearch.text;
                      T!.webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse("https://www.google.com/search?q=$newlink"),),);
                    }, icon: Icon(Icons.search)),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 2,
                      blurRadius: 3
                    )
                  ]
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: LinearProgressIndicator(
                 value: T!.IndicatorProgress,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com/"),),
              onWebViewCreated: (controller) {
                T!.webViewController = controller;

              },
              onLoadError: (controller, url, code, message) {
                T!.webViewController = controller;
              },
              onLoadStart: (controller, url) {
                T!.webViewController = controller;
              },
              onLoadStop: (controller, url) {
                T!.webViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                T!.webViewController = controller;
                F!.changeIndecato(progress/100);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 3,
                      spreadRadius: 3,
                      blurStyle: BlurStyle.solid
                    ),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {
                      F!.webViewController!.goBack();
                    }, icon: Icon(Icons.arrow_back),),
                    IconButton(onPressed: () {
                      F!.webViewController!.reload();
                    }, icon: Icon(Icons.refresh),),
                    IconButton(onPressed: () {
                      F!.webViewController!.goForward();

                    }, icon: Icon(Icons.arrow_forward_rounded),),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
