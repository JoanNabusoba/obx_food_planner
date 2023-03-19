import 'package:dbcrypt/dbcrypt.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
//@Sync()
class User {
  int id = 0;
  String? name;
  @Unique()
  String? email;
  String? password;

  User({
    this.id = 0,
    required this.name,
    required this.email,
    required this.password,
  });

  User.newUser(User user)
      : password =
            DBCrypt().hashpw(user.password ?? "password", DBCrypt().gensalt());

  bool login(pass) {
    return DBCrypt().checkpw("$pass", password ?? "");
  }
}
