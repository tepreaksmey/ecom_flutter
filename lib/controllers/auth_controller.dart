import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final RxBool _isFirstTime = true.obs;
  final RxBool _isloggedIn = false.obs;

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

  void login() {
    _isloggedIn.value = true;
    _storage.write('isLoggedIn', true);
  }

  void logout() {
    _isloggedIn.value = false;
    _storage.write('isLoggedIn', false);
  }
}
