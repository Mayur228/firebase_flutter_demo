class UserData {
  final String id, name, url, email;

  UserData(
    this.name,
    this.id,
    this.url,
    this.email,
  );

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'email': email,
      };
}
