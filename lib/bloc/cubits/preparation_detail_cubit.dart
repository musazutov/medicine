import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtask/api/api_response.dart';
import 'package:testtask/bloc/states/preparations_state.dart';
import 'package:testtask/utils/variables.dart';

import '../../api/api.dart';
import '../../utils/global_functions.dart';
import '../states/preparation_detail_state.dart';

class PreparationDetailCubit extends Cubit<PreparationDetailState> {
  PreparationDetailCubit(this.context) : super(PreparationDetailInitial());
  final BuildContext context;

  Future getPreparationDetail(int preparationId) async {
    emit(PreparationDetailLoad(ApiResponse(apiResult: ApiResult.loading)));
    ApiResponse response =
        await API.instance.getPreparationDetail(preparationId);

    if (response.apiResult == ApiResult.error) {
      await GlobalFunctions.instance
          .showMessage(context, message: response.message);
    }

    emit(PreparationDetailLoad(response));
  }
}
