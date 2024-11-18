import 'package:duygularimingunluguflutterarayuz/model/DailyNote.dart';
import 'Expert.dart';

class Client {
  String _username;
  String _firstName;
  String _lastName;
  late Expert? _expert;
  String _password;
  late List<DailyNote> _notes;

  Client(this._firstName, this._lastName, this._username, this._password);

  // Getter & Setter
  Expert? get expert => _expert;
  set expert(Expert? expert) => _expert = expert;

  String get password => _password;
  set password(String password) => _password = password;

  String get username => _username;
  set username(String username) => _username = username;

  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;

  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;

  List<DailyNote> get notes => _notes;
  set notes(List<DailyNote> notes) => _notes = notes;

  static void addDailyNote(List<DailyNote> dailyNoteList, DailyNote dailyNote) {
    dailyNoteList.add(dailyNote);
  }

  static void removeDailyNote(
      List<DailyNote> dailyNoteList, DailyNote dailyNote) {
    dailyNoteList.remove(dailyNote);
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(json['firstName'] ?? '', json['lastName'] ?? '',
        json['username'] ?? '', json['password'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'username': _username,
      'firstName': _firstName,
      'lastName': _lastName,
      'password': _password,
    };
  }
}
