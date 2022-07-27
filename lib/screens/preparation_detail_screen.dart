import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../beans/preparation_detail_bean.dart';
import '../bloc/cubits/preparation_detail_cubit.dart';
import '../bloc/states/preparation_detail_state.dart';
import '../utils/variables.dart';

class PreparationDetailScreen extends StatelessWidget {
  PreparationDetailScreen({Key? key, required this.preparationId})
      : super(key: key);

  late PreparationDetailCubit _cubit;
  late int preparationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _cubit = PreparationDetailCubit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Preparation Detail'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: buildPreparationDetail(context),
          ),
        ),
      ),
    );
  }

  Widget buildPreparationDetail(BuildContext context) {
    return BlocBuilder<PreparationDetailCubit, PreparationDetailState>(
        buildWhen: (state1, state2) {
      return state2 is PreparationDetailLoad;
    }, builder: (context, state) {
      if (state is PreparationDetailLoad) {
        switch (state.apiResponse.apiResult) {
          case ApiResult.success:
            return buildSuccessWidget(context, state.apiResponse.data);
          case ApiResult.error:
            return Center(
              child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    _cubit.getPreparationDetail(preparationId);
                  }),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      } else {
        _cubit.getPreparationDetail(preparationId);
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget buildSuccessWidget(
      BuildContext context, PreparationDetailBean preparation) {
    return SingleChildScrollView(
      child: Column(
        children: [
          getInfoRow(context,
              label: 'Trade label', value: preparation.tradeLabel),
          getInfoRow(context,
              label: 'Manufacturer name', value: preparation.manufacturerName),
          getInfoRow(context,
              label: 'Packaging description', value: preparation.packagingDesc),
          getInfoRow(context,
              label: 'Composition description',
              value: preparation.compositionDesc),
          getInfoRow(context,
              label: 'Composition inn', value: preparation.compositionInn),
          getInfoRow(context,
              label: 'Composition pharm_form',
              value: preparation.compositionPharmForm),
        ],
      ),
    );
  }

  Widget getInfoRow(BuildContext context,
      {required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
