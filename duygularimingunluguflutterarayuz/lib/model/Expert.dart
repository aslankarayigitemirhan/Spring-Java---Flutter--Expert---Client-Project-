import 'Client.dart';

class Expert {
  String _username;
  String _firstName;
  String _lastName;
  String _password;
  String _branch;
  late List<Client> _followedClientCurrently;
  late List<Client> _requestForClient;

  Expert(this._firstName, this._lastName, this._username, this._password,
      this._branch);
//1
  String get branch => _branch;
  set branch(String branch) => _branch = branch;
//2
  String get password => _password;
  set password(String password) => _password = password;
//3
  String get username => _username;
  set username(String username) => _username = username;
//4
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  //5
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  //6
  List<Client> get followedClientCurrently => _followedClientCurrently;
  set followedClientCurrently(List<Client> followedClientCurrently) =>
      _followedClientCurrently = followedClientCurrently;
//7
  List<Client> get requestForClient => _requestForClient;
  set requestForClient(List<Client> requestForClient) =>
      _requestForClient = requestForClient;
  //8
  static void addClient(List<Client> clientList, Client client) {
    clientList.add(client);
  }

  //9
  static void removeClient(List<Client> clientList, Client client) {
    clientList.remove(client);
  }

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(json['firstName'] ?? '', json['lastName'] ?? '',
        json['username'] ?? '', json['password'] ?? '', json['branch'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {
      'username': _username,
      'firstName': _firstName,
      'lastName': _lastName,
      'password': _password,
      'branch': _branch,
    };
  }
}
