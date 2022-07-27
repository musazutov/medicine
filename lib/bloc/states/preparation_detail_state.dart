
import '../../api/api_response.dart';

abstract class PreparationDetailState {}

class PreparationDetailInitial extends PreparationDetailState {}

class PreparationDetailLoad extends PreparationDetailState {
  final ApiResponse apiResponse;
  PreparationDetailLoad(this.apiResponse);
}
