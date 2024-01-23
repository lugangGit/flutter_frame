class Api {
  /// 正式环境
  // static const String baseUrl = "https://api.ddcat.shop?s=/api";
  /// 测试环境
  static const String baseUrl = "https://api.xiancn.com/xafb/";

  //===用户相关===
  static const String Sms_Code = '/user/send_code';
  static const String User_Login = '/login/login';
  // 隐私政策
  static const String Privacy_Policy = '$baseUrl/article/detail_by_code&code=privacy';
  // 用户协议
  static const String User_Agreement = '$baseUrl/article/detail_by_code&code=agreement';
  //客服网页地址
  static const String Service_Url = "https://kefu.easemob.com/webim/im.html?configId=e2a9e3f6-5da4-4321-9b8f-10bf4342e3c8&language=zh-CN";

}