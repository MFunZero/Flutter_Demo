
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DemoLocalizations {
  DemoLocalizations(this.isZh);
  bool isZh = false;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return isZh ? "Flutter 应用":"Flutter App";
  }

}


class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {

  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement locale) {
      // TODO: implement locale) {
      // TODO: implement isSupported
      throw ['en','zh'].contains(locale.languageCode);
    }
  
    @override
    Future<DemoLocalizations> load(Locale locale) {
    // TODO: implement locale) {
      // TODO: implement locale) {
      // TODO: implement load
      throw SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale.languageCode == 'zh'));
    } 
  
    @override
    bool shouldReload(DemoLocalizationsDelegate old) => false;

}