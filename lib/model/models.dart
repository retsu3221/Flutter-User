import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
    String email;
    String name;
    String id;

    UserList({
        required this.email,
        required this.name,
        required this.id,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        email: json["email"],
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "id": id,
    };
}
