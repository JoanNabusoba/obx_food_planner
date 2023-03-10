import 'package:objectbox/objectbox.dart';

@Entity()
//@Sync()
class User {
  int id = 0;
  String? name;
  String? email;
  String? password;

  User({
    this.id = 0,
    required this.name,
    required this.email,
    required this.password,
  });
}
