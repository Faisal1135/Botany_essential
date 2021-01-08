import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'botmodel.g.dart';

@HiveType(typeId: 1)
class Botmodel {
  @HiveField(0)
  String id;
  // Hive fields go here

  @HiveField(1)
  String term;

  @HiveField(2)
  String meaning;

  @HiveField(3)
  List innerLink;

  @HiveField(4)
  bool isFavorite;

  @HiveField(5)
  bool isHistory;

  @HiveField(6)
  DateTime date;

  Botmodel(
      {this.term,
      this.meaning,
      this.innerLink,
      this.id,
      this.isHistory = false,
      this.isFavorite = false});

  Botmodel.fromJson(Map<String, dynamic> json)
      : id = Uuid().v4(),
        term = json["term"] as String,
        meaning = json["meaning"] as String,
        innerLink = json["inner_link"],
        date = DateTime.now(),
        isHistory = false,
        isFavorite = false;

  Map toMap() {
    return {
      "id": id,
      "term": term,
      "meaning": meaning,
      "innerLink": innerLink,
      "fav": isFavorite
    };
  }
}
