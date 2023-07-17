import 'package:dbcrypt/dbcrypt.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;
  String? name;
  @Unique()
  String? email;
  String? password;

  final favourites = ToMany<Recipe>();


  User({
    this.id = 0,
    required this.name,
    required this.email,
    required this.password,
  });

  User.newUser(User user)
      : password =
            DBCrypt().hashpw(user.password ?? "password", DBCrypt().gensalt()),
        name = user.name,
        email = user.email;

  bool login(pass) {
    return DBCrypt().checkpw("$pass", password ?? "");
  }
}
