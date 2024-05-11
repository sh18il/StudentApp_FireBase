class ModelApp {
  String? name;
  String? age;
  String? address;
  String? rollno;
  String? id;
  String? image;

  ModelApp(
      {this.id, this.image, this.name, this.age, this.address, this.rollno});

  ModelApp.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    age = json["age"];
    address = json["address"];
    rollno = json["rollno"];
    id = json["id"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "address": address,
      "rollno": rollno,
      "id": id,
      "image": image,
    };
  }
}
