import 'package:flutter/material.dart';
import 'package:flutter_frame/common/utils/app_text_style.dart';
import 'package:gap/gap.dart';
import '../../../utils.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());
  final state = Get.find<LoginController>().state;

  @override
  Widget build(BuildContext context) {
    controller.userModel = Provider.of<UserModel>(context);

    return Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: AppColor.primary50.of(context),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.gap20),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(labelText: 'Username'),
                        autofocus: false,
                        controller: controller.usernameTextController,
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Password'),
                        controller: controller.passwordTextController,
                      ),
                      Gap(Dimens.gap20),
                      MaterialButton(
                        onPressed: (){
                          controller.login(controller.usernameTextController.text, controller.passwordTextController.text);
                        },
                        child: Text("login".tr, style: AppTextStyle.title(context),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: ScreenUtil().statusBarHeight,
                left: Dimens.gap10,
                child: BackButton(
                  color: Colors.white,
                  onPressed: controller.back,
                )),
          ],
        ),
    );
  }
}
