// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'backend/model/mealplan.dart';
import 'backend/model/recipe.dart';
import 'backend/model/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8373663285333154395),
      name: 'MealPlan',
      lastPropertyId: const IdUid(3, 3656238120652911625),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 35942802607063352),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8217801122045514387),
            name: 'dayofWeek',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3656238120652911625),
            name: 'time',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 7692543004435716158),
            name: 'recipe',
            targetId: const IdUid(2, 3493739509373638750))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 3493739509373638750),
      name: 'Recipe',
      lastPropertyId: const IdUid(8, 8692124332662719764),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6780176770357234170),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1235187102763072384),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8755417298461722317),
            name: 'calories',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6254484309793900852),
            name: 'preptime',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4699305772375925754),
            name: 'details',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2090688494189337091),
            name: 'ingredients',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2139901353205224680),
            name: 'steps',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 8692124332662719764),
            name: 'image',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'mealplan', srcEntity: 'MealPlan', srcField: 'recipe')
      ]),
  ModelEntity(
      id: const IdUid(3, 6157516703477323715),
      name: 'User',
      lastPropertyId: const IdUid(4, 171985379804890623),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3572541236056510131),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6187583242683147551),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6172581636943497785),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 4750324122864610907)),
        ModelProperty(
            id: const IdUid(4, 171985379804890623),
            name: 'password',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 6157516703477323715),
      lastIndexId: const IdUid(1, 4750324122864610907),
      lastRelationId: const IdUid(1, 7692543004435716158),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    MealPlan: EntityDefinition<MealPlan>(
        model: _entities[0],
        toOneRelations: (MealPlan object) => [],
        toManyRelations: (MealPlan object) =>
            {RelInfo<MealPlan>.toMany(1, object.id): object.recipe},
        getId: (MealPlan object) => object.id,
        setId: (MealPlan object, int id) {
          object.id = id;
        },
        objectToFB: (MealPlan object, fb.Builder fbb) {
          final dayofWeekOffset = object.dayofWeek == null
              ? null
              : fbb.writeString(object.dayofWeek!);
          final timeOffset =
              object.time == null ? null : fbb.writeString(object.time!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, dayofWeekOffset);
          fbb.addOffset(2, timeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MealPlan(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              dayofWeek: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              time: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8));
          InternalToManyAccess.setRelInfo(object.recipe, store,
              RelInfo<MealPlan>.toMany(1, object.id), store.box<MealPlan>());
          return object;
        }),
    Recipe: EntityDefinition<Recipe>(
        model: _entities[1],
        toOneRelations: (Recipe object) => [],
        toManyRelations: (Recipe object) =>
            {RelInfo<MealPlan>.toManyBacklink(1, object.id): object.mealplan},
        getId: (Recipe object) => object.id,
        setId: (Recipe object, int id) {
          object.id = id;
        },
        objectToFB: (Recipe object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final caloriesOffset = object.calories == null
              ? null
              : fbb.writeString(object.calories!);
          final preptimeOffset = object.preptime == null
              ? null
              : fbb.writeString(object.preptime!);
          final detailsOffset =
              object.details == null ? null : fbb.writeString(object.details!);
          final ingredientsOffset = object.ingredients == null
              ? null
              : fbb.writeList(object.ingredients!
                  .map(fbb.writeString)
                  .toList(growable: false));
          final stepsOffset = object.steps == null
              ? null
              : fbb.writeList(
                  object.steps!.map(fbb.writeString).toList(growable: false));
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, caloriesOffset);
          fbb.addOffset(3, preptimeOffset);
          fbb.addOffset(4, detailsOffset);
          fbb.addOffset(5, ingredientsOffset);
          fbb.addOffset(6, stepsOffset);
          fbb.addOffset(7, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Recipe(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 18),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              calories: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              preptime: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              details: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              ingredients: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 14),
              steps: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGetNullable(buffer, rootOffset, 16));
          InternalToManyAccess.setRelInfo(
              object.mealplan,
              store,
              RelInfo<MealPlan>.toManyBacklink(1, object.id),
              store.box<Recipe>());
          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[2],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, passwordOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              password: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [MealPlan] entity fields to define ObjectBox queries.
class MealPlan_ {
  /// see [MealPlan.id]
  static final id = QueryIntegerProperty<MealPlan>(_entities[0].properties[0]);

  /// see [MealPlan.dayofWeek]
  static final dayofWeek =
      QueryStringProperty<MealPlan>(_entities[0].properties[1]);

  /// see [MealPlan.time]
  static final time = QueryStringProperty<MealPlan>(_entities[0].properties[2]);

  /// see [MealPlan.recipe]
  static final recipe =
      QueryRelationToMany<MealPlan, Recipe>(_entities[0].relations[0]);
}

/// [Recipe] entity fields to define ObjectBox queries.
class Recipe_ {
  /// see [Recipe.id]
  static final id = QueryIntegerProperty<Recipe>(_entities[1].properties[0]);

  /// see [Recipe.title]
  static final title = QueryStringProperty<Recipe>(_entities[1].properties[1]);

  /// see [Recipe.calories]
  static final calories =
      QueryStringProperty<Recipe>(_entities[1].properties[2]);

  /// see [Recipe.preptime]
  static final preptime =
      QueryStringProperty<Recipe>(_entities[1].properties[3]);

  /// see [Recipe.details]
  static final details =
      QueryStringProperty<Recipe>(_entities[1].properties[4]);

  /// see [Recipe.ingredients]
  static final ingredients =
      QueryStringVectorProperty<Recipe>(_entities[1].properties[5]);

  /// see [Recipe.steps]
  static final steps =
      QueryStringVectorProperty<Recipe>(_entities[1].properties[6]);

  /// see [Recipe.image]
  static final image = QueryStringProperty<Recipe>(_entities[1].properties[7]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[2].properties[0]);

  /// see [User.name]
  static final name = QueryStringProperty<User>(_entities[2].properties[1]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[2].properties[2]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[2].properties[3]);
}
