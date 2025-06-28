import 'package:ecom_flutter/models/userModel.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxBool _isFirstTime = true.obs;
  final RxBool _isloggedIn = false.obs;

  final RxList<UserModel> _users = <UserModel>[].obs;

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isloggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isfirstTime') ?? true;
    _isloggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  // void login() {
  //   _isloggedIn.value = true;
  //   _storage.write('isLoggedIn', true);
  // }

  bool login(String email, String password) {
    final user = _users.firstWhereOrNull(
      (u) => u.email == email && u.password == password,
    );
    if (user != null) {
      currentUser.value = user;
      _isloggedIn.value = true;
      // ✅ Save to local storage
      final storage = GetStorage();
      storage.write('isLoggedIn', true);
      storage.write('currentUserEmail', user.email);
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    _isloggedIn.value = false;
    _storage.write('isLoggedIn', false);
  }

  void register(String name, String email, String password) {
    final user = UserModel(name: name, email: email, password: password);
    _users.add(user);
  }
}
