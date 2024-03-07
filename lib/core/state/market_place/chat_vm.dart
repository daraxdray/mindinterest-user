import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';
import 'package:mindintrest_user/core/state/base_vm.dart';

class ChatVM extends BaseVM {
  ChatVM(this._reader);
  final Ref _reader;
  final MarketPlaceRequests _marketPlaceRequests = MarketPlaceRequests();
  Map<int, Consultant> cachedConsultants = {};

  Future<Consultant> getConsultant(int cid) async {
    if (cachedConsultants[cid] != null) {
      return cachedConsultants[cid]!;
    } else {
      final res = await _marketPlaceRequests.fetchConsultant(cid);
      return res.fold((l) =>  throw l, (r) {
        cachedConsultants[r.id!] = r;
        return r;
      });
    }
  }
}
