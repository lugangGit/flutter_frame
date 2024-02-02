
enum Sex {
  male, //男
  female, //女
  unknown //未知
}

class User {
  int? id; //用户id
  int? ssoId; //用户在sso系统中的标识
  int? isRefOauth; //手机号是否关联三方账号，0否，1是
  String? name; //用户名
  String? nickname; //用户昵称
  String? realName; //姓名
  String? address; //地址
  String? email;
  String? registerTime;
  Sex sex; //性别

  User({
    this.id,
    this.ssoId,
    this.isRefOauth,
    this.name,
    this.nickname,
    this.realName,
    this.address,
    this.email,
    this.registerTime,
    this.sex = Sex.male,
  });

  int get registDay => _registDay();

  Future<String> get userId async=> getUserId();

  Future<String> getUserId() async{
    return '$id';
   // return AppConfig.app.userTokenEnable ? await _getSm2UserId():'$id';
  }

  int _registDay() {
    if (null == registerTime) {
      return 1;
    }
    try {
      var register = DateTime.parse(registerTime!);
      var now = DateTime.now();
      int days = now.difference(register).inDays;
      return days+1;
    } catch (e) {
      return 1;
    }
  }

  static User fromJson(Map<String, dynamic> json) {
    List<User> account = [];
    if (json['relatedAccount'] != null) {
      json['relatedAccount'].forEach((v) {
        account.add(User.fromJson(v));
      });
    }
    List<Subs> subs = [];
    if (json['subs'] != null) {
      json['subs'].forEach((v) {
        subs.add(Subs.fromJson(v));
      });
    }
    return User(
        id: int.tryParse((json['userid'] ?? json['id'] ?? "0").toString()) ?? 0,
        ssoId: int.tryParse((json['uid']?? json['ssoId'] ?? 0).toString()),
        name: json['username']??json['name'],
        nickname: json['nickname'],
        address: json['address'],
        email: json['email'] ?? "",
        realName: json['realName'] ?? "",
        isRefOauth: json['isRefOauth'] ?? 0,
        registerTime: json['registerTime'] ?? "",
        sex: sexType((json['sex'] ?? "").toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = id.toString();
    data['uid'] = ssoId.toString();
    data['username'] = name;
    data['nickname'] = nickname;
    data['address'] = address;
    data['realName'] = realName;
    data['email'] = email;
    data['registerTime'] = registerTime;
    data['sex'] = sexToString(sex);
    return data;
  }
}


///性别
Sex sexType(String type) {
  switch (type) {
    case '0':
      return Sex.unknown;
    case '1':
      return Sex.male;
    case '2':
      return Sex.female;
  }
  return Sex.unknown;
}


///性别
String sexToString(Sex type) {
  switch (type) {
    case Sex.unknown:
      return '0';
    case Sex.male:
      return '1';
    case Sex.female:
      return '2';
  }
}


class Subs {
  int? id;
  int? type;
  String? name;
  String? iconUrl;
  int? status;

  Subs({this.id, this.type, this.name, this.iconUrl, this.status});

  Subs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    iconUrl = json['iconUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    data['status'] = status;
    return data;
  }
}
