import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeProvider extends ChangeNotifier
{
  InAppWebViewController? webViewController;
  TextEditingController txtsearch = TextEditingController();
  double IndicatorProgress=0;
  void changeIndecato(double value)
  {
    IndicatorProgress = value;
    notifyListeners();
  }
}