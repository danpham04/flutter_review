class UserModel {
  String? image;
  String? name;
  String? mail;
  String? address;
  String? dateOfBirth;
  String? nationality;
  String id;

  UserModel(
      {this.image,
      this.name,
      this.mail,
      this.address,
      this.dateOfBirth,
      this.nationality,
      required this.id
      });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      image: map['imgavt'],
      name: map['name'],
      mail: map['mail'],
      address: map['address'],
      dateOfBirth: map['dateOfBirth'],
      nationality: map['nationality'],
      id: map['id']
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'imgavt': image,
      'name': name,
      'mail': mail,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'nationality': nationality,
      'id':id
    };
  }

}
