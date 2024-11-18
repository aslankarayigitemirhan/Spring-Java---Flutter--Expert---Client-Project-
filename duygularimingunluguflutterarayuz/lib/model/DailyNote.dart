import 'Client.dart';

class DailyNote {
  Client _client;
  String _timedate;
  String _dailynoteID;
  String _text;
  String _aiComment;

  DailyNote(this._client, this._timedate, this._dailynoteID, this._text,
      this._aiComment);

  // Getter ve Setter
  Client get client => _client;
  set client(Client client) => _client = client;

  String get dailynoteID => _dailynoteID;
  set dailynoteID(String dailynoteID) => _dailynoteID = dailynoteID;

  String get text => _text;
  set text(String text) => _text = text;

  String get aiComment => _aiComment;
  set aiComment(String aiComment) => _aiComment = aiComment;

  String get timedate => _timedate;
  set timedate(String timedate) => _timedate = timedate;

  // JSON'dan obje oluşturma (Factory Constructor)
  factory DailyNote.fromJson(Map<String, dynamic> json, Client client) {
    // Eğer 'client' verisi JSON'da yoksa null döndürür.
    return DailyNote(
      client, // Varsayılan bir Client objesi oluşturulabilir.
      json['date'] ?? '',
      json['dailynoteID'] ?? '',
      json['text'] ?? '',
      json['analyzer'] ??
          '', // 'aiComment' yerine 'analyzer' ile eşleştiriliyor.
    );
  }

  // Obje JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'client': _client.toJson(),
      'date': _timedate,
      'dailynoteID': _dailynoteID,
      'text': _text,
      'analyzer': _aiComment, // JSON'da 'analyzer' karşılığı
    };
  }
}
