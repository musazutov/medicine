import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtask/api/api_response.dart';
import 'package:testtask/bloc/states/preparations_state.dart';
import 'package:testtask/utils/variables.dart';

import '../../api/api.dart';
import '../../utils/global_functions.dart';

class PreparationsCubit extends Cubit<PreparationsState> {
  PreparationsCubit(this.context) : super(PreparationsInitial());
  final BuildContext context;

  Future getPreparations() async {
    emit(PreparationsLoad(ApiResponse(apiResult: ApiResult.loading)));
    ApiResponse response = await API.instance.getPreparations();

    if (response.apiResult == ApiResult.error) {
      await GlobalFunctions.instance
          .showMessage(context, message: response.message);
    }

    emit(PreparationsLoad(response));
  }

  void searchPreparations(String filter) async {
    if (filter.length < 4) return;
    debugPrint('searching preparations');
    emit(PreparationsLoad(ApiResponse(apiResult: ApiResult.loading)));
    ApiResponse response = await API.instance.searchPreparations(filter);

    if (response.apiResult == ApiResult.error) {
      await GlobalFunctions.instance
          .showMessage(context, message: response.message);
    }

    emit(PreparationsLoad(response));
  }
}
