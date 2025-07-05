import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/userModel.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxList<UserModel> _users = <UserModel>[].obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;

    final usersData = _storage.read<List>('users') ?? [];
    print('Loaded usersData from storage: $usersData');

    _users.assignAll(
      usersData.map((u) => UserModel.fromJson(Map<String, dynamic>.from(u))),
    );

    final currentEmail = _storage.read<String>('currentUserEmail');
    print('Loaded currentUserEmail from storage: $currentEmail');

    if (currentEmail != null) {
      currentUser.value = _users.firstWhereOrNull(
        (u) => u.email == currentEmail,
      );
      print('Current user loaded: ${currentUser.value?.email}');
    } else {
      currentUser.value = null;
    }
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  void register(String name, String email, String password) {
    final user = UserModel(name: name, email: email, password: password);

    // Check if user already exists (optional)
    final existingUser = _users.firstWhereOrNull((u) => u.email == email);
    if (existingUser != null) {
      print('User with email $email already exists!');
      return;
    }

    _users.add(user);
    print('Registering user: ${user.toJson()}');

    _storage.write('users', _users.map((u) => u.toJson()).toList());
    print('Saved users: ${_users.map((u) => u.toJson()).toList()}');
  }

  bool login(String email, String password) {
    final user = _users.firstWhereOrNull(
      (u) => u.email == email && u.password == password,
    );
    if (user != null) {
      currentUser.value = user;
      _isLoggedIn.value = true;
      _storage.write('isLoggedIn', true);
      _storage.write('currentUserEmail', user.email);
      print('Login success for user: ${user.email}');
      return true;
    }
    print('Login failed for email: $email');
    return false;
  }

  void logout() {
    _isLoggedIn.value = false;
    currentUser.value = null;
    _storage.write('isLoggedIn', false);
    _storage.remove('currentUserEmail');
    print('User logged out');
  }
}
