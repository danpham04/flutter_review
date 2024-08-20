class UserModel {
  final String image;
  final String name;
  final String mail;
  final String address;
  final String dateOfBirth;
  final String nationality;
  final String id;

  UserModel(
      {required this.image,
       required this.name,
      required this.mail,
      required this.address,
      required this.dateOfBirth,
      required this.nationality,
      this.id =''
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
