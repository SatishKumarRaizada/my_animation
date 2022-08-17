import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quantity_cubit.dart';

class QuantityWidget extends StatefulWidget {
  final String? title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final TextEditingController? quantityCtrl;
  final int? quanitityMaxLimit;
  final int? quanitityMinLimit;

  const QuantityWidget({
    Key? key,
    required this.leftIcon,
    required this.rightIcon,
    required this.title,
    required this.quantityCtrl,
    required this.quanitityMinLimit,
    required this.quanitityMaxLimit,
  }) : super(key: key);

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  final quantityBloc = CounterCubit();
  final quantityCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantityCtrl.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title!,
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  final count = quantityCtrl.text.trim();
                  final minLimit = int.parse(count);
                  if (minLimit <= widget.quanitityMinLimit!) {
                    quantityCtrl.text = '1';
                    quantityBloc.increment();
                  }
                },
                child: Icon(widget.leftIcon),
              ),
              Builder(builder: (context) {
                return SizedBox(
                  width: width * 0.4,
                  child: TextFormField(
                    controller: quantityCtrl,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                    ),
                    onChanged: (String str) {},
                  ),
                );
              }),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  final count = quantityCtrl.text.trim();
                  final minLimit = int.parse(count);
                  if (minLimit <= widget.quanitityMinLimit!) {
                    quantityBloc.increment();
                  }
                },
                child: Icon(widget.rightIcon),
              )
            ],
          ),
        ],
      ),
    );
  }
}
