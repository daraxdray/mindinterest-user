// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/services/network/requests/market_place_requests.dart';

class ConsultantListingsVM extends ChangeNotifier {
  ConsultantListingsVM(this._ref);
  final Ref _ref;
  bool recommendedLoading = false;
  bool featuredLoading = false;

  final _api = MarketPlaceRequests();
  List<Consultant>? recommendedConsultants;
  List<Consultant>? featuredConsultants;

  void setRecommendedLoading(bool value) {
    recommendedLoading = value;
    // notifyListeners();
  }

  void setFeaturedLoading(bool value) {
    featuredLoading = value;
    // notifyListeners();
  }

  Future<List<Consultant>?> getRecommendedConsultants() async {
    setRecommendedLoading(true);
    final result = await _api.getReccomendedConsultants();
    setRecommendedLoading(false);

    return result.fold((l) => null, (r) {
      recommendedConsultants = r;
      setRecommendedLoading(false);
      return r;
    });
  }

  Future<List<Consultant>?> getFeaturedConsultants() async {
    setFeaturedLoading(true);
    final result = await _api.getFeaturedConsultants();
    setFeaturedLoading(false);

    return result.fold((l) => null, (r) {
      setFeaturedLoading(false);
      featuredConsultants = r;
      return r;
    });
  }

  void notify() {
    notifyListeners();
  }
}
