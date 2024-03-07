import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';

class UserVM extends StateNotifier<TmiUser> {
  UserVM() : super(TmiUser());

  void setUser(TmiUser user) {
    state = user;
  }
}
