import 'package:flutter/material.dart';
import '../../../beans/preparation_bean.dart';
import '../../variables.dart';

class PreparationRow extends StatelessWidget {
  const PreparationRow(this.preparationBean, {Key? key}) : super(key: key);

  final PreparationBean preparationBean;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Screens.preparationDetail,
            arguments: preparationBean.id);
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffE2FFEA).withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffEDF5EF))),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 1,
              height: 40,
              color: const Color(0xff39C8CB),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trade label: ${preparationBean.tradeLabel}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xff2C406E), fontSize: 13),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Man name: ${preparationBean.manufacturerName}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xff2C406E), fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.navigate_next, color: Color(0xffA4A4A6)),
          ],
        ),
      ),
    );
  }
}
