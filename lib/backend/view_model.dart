import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/model/mealplan.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/backend/model/user.dart';
import 'package:foodplanner_app/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ViewModel {
  late final Store store;

  late final Box<MealPlan> mealPlanBox;
  late final Box<User> userBox;
  late final Box<Recipe> recipeBox;

  ViewModel._create(this.store) {
    mealPlanBox = Box<MealPlan>(store);
    userBox = Box<User>(store);
    recipeBox = Box<Recipe>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ViewModel> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final store =
        await openStore(directory: "${appDocDirectory.path}/objectbox");
    return ViewModel._create(store);
  }

  Future<int> openTimeSheet(int user, int job) async {
    var start_date = DateTime.now();
    var start_time = DateFormat.Hm().format(start_date);
    TimeSheet timeSheet = TimeSheet(start_date, start_time);
    timeSheet.user.targetId = user;
    timeSheet.job.targetId = job;
    var id = tBox.put(timeSheet);

    var ts = tBox.get(id);
    if (ts != null) {
      var ts2Map = ts.toSyncJson();
      ts2Map["user_id"] = ts.user.target?.dbId;
      ts2Map["job_id"] = ts.job.target?.dbId;

      var box = await Hive.openBox("syncQueue");

      var unsynced = box.get("unsynced", defaultValue: []);
      unsynced.add({"request_type": "timesheet", "data": ts2Map});
      // var sync = SyncQueue("timesheet", json.encode(ts2Map), false);
      // sBox.put(sync);
      box.put("unsynced", unsynced);

      AppRe.hashCode.saveTimeSheet(ts2Map);
    }
    return id;
  }

  Stream<List<Employee>> getEmployees() {
    final builder = eBox.query(ob.Employee_.role.equals("EMPLOYEE"));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
