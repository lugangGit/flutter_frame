import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils.dart';

class SettingPage extends BasePage {
  const SettingPage({super.key, super.showAppBar});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage> {

  @override
  String? get title => "setting".tr;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow,);
  }

}
