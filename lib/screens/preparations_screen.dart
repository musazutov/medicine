import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../beans/preparation_bean.dart';
import '../bloc/cubits/preparations_cubit.dart';
import '../bloc/states/preparations_state.dart';
import '../utils/helper_widgets/list_rows/preparation_row.dart';
import '../utils/variables.dart';

class PreparationsScreen extends StatelessWidget {
  PreparationsScreen({Key? key}) : super(key: key);
  late PreparationsCubit _cubit;
  final TextEditingController _ctrlFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _cubit = PreparationsCubit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Preparations'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  controller: _ctrlFilter,
                  prefixInsets: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 0.6),
                      borderRadius: BorderRadius.circular(8.0)),
                  onSubmitted: (String text) {
                    _cubit.searchPreparations(text);
                  },
                  onChanged: (String filter) {
                    if (filter.isEmpty) _cubit.getPreparations();
                  },
                ),
                const SizedBox(height: 20),
                Expanded(child: buildPreparations(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPreparations(BuildContext context) {
    return BlocBuilder<PreparationsCubit, PreparationsState>(
        buildWhen: (state1, state2) {
      return state2 is PreparationsLoad;
    }, builder: (context, state) {
      if (state is PreparationsLoad) {
        switch (state.apiResponse.apiResult) {
          case ApiResult.success:
            return buildSuccessWidget(context, state.apiResponse.data);
          case ApiResult.error:
            return Center(
              child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    if (_ctrlFilter.text.isNotEmpty) {
                      _cubit.searchPreparations(_ctrlFilter.text);
                    } else {
                      _cubit.getPreparations();
                    }
                  }),
            );

          default:
            return const Center(child: CircularProgressIndicator());
        }
      } else {
        _cubit.getPreparations();
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget buildSuccessWidget(
      BuildContext context, List<PreparationBean> preparations) {
    return preparations.isEmpty
        ? const Center(
            child: Text(
              'Preperation not found',
              style: TextStyle(color: Color(0xff10275A), fontSize: 14.0),
            ),
          )
        : ListView.separated(
            itemCount: preparations.length,
            itemBuilder: (context, index) {
              return PreparationRow(preparations[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          );
  }
}
