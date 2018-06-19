class device extends Object {
  String a;
  String b;
  int c;
  int d;
  String e;
  String f;
  int g;

  device(this.a, this.b, this.c, this.d, this.e, this.f, this.g);

  device.fromJson(Map<String, dynamic> json):a = json["a"],b = json["b"],c = json["c"],d = json["d"],e = json["e"],f = json["f"],g = json["g"];

  Map<String,dynamic> toJson()=>{
    "a":a,
    "b":b,
    "c":c,
    "d":d,
    "e":e,
    "f":f,
    "g":g,
  };
}