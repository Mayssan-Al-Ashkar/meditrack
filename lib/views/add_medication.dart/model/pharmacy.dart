class Pharmacy {
  String? name;
  String? dist;
  String? address;
  String? phone;
  String? loc;
  String? lat;
  String? long;

  Pharmacy({this.name, this.dist, this.address, this.phone, this.loc, this.lat, this.long});

  Pharmacy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dist = json['dist'];
    address = json['address'];
    phone = json['phone'];
    loc = json['loc'];
    splitLocation(loc);
  }

  void splitLocation(String? location){
    if (location == null) return;
    List<String> longLat = location.split(",");
    if(longLat.isNotEmpty){
      lat = longLat[0];
      long = longLat[1];
    }
  }
}