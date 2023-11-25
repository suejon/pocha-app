class ExternalAddress {
  int? placeId;
  int? osmId;
  String? lat;
  String? lon;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  ExternalAddress();

  ExternalAddress.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    addresstype = json['addresstype'];
    name = json['name'];
    displayName = json['display_name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['osm_id'] = osmId;
    data['lat'] = lat;
    data['lon'] = lon;
    data['addresstype'] = addresstype;
    data['name'] = name;
    data['display_name'] = displayName;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['boundingbox'] = boundingbox;
    return data;
  }
}

class Address {
  String? road;
  String? suburb;
  String? borough;
  String? city;
  String? iSO31662Lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Address();

  Address.fromJson(Map<String, dynamic> json) {
    road = json['road'];
    suburb = json['suburb'];
    borough = json['borough'];
    city = json['city'];
    iSO31662Lvl4 = json['ISO3166-2-lvl4'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['road'] = road;
    data['suburb'] = suburb;
    data['borough'] = borough;
    data['city'] = city;
    data['ISO3166-2-lvl4'] = iSO31662Lvl4;
    data['postcode'] = postcode;
    data['country'] = country;
    data['country_code'] = countryCode;
    return data;
  }
}
