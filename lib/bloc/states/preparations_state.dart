
import '../../api/api_response.dart';

abstract class PreparationsState {}

class PreparationsInitial extends PreparationsState {}

class PreparationsLoad extends PreparationsState {
  final ApiResponse apiResponse;
  PreparationsLoad(this.apiResponse);
}
