import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime/quantity_widget/quantity_cubit.dart';

class QuantityPage extends StatefulWidget {
  final String? title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final int? quanitityMaxLimit;
  final int? quanitityMinLimit;

  const QuantityPage({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.quanitityMinLimit,
    this.quanitityMaxLimit,
    this.title,
  }) : super(key: key);
  @override
  State<QuantityPage> createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage> {
  final quanltityCtrl = TextEditingController();
  final counterCubit = CounterCubit();

  @override
  void initState() {
    super.initState();
    quanltityCtrl.addListener(() {
      final text = quanltityCtrl.text.toLowerCase();
      quanltityCtrl.value = quanltityCtrl.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    context.read<CounterCubit>().counter(widget.quanitityMinLimit!);
    quanltityCtrl.text = '${widget.quanitityMinLimit}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.title!),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  child: Icon(widget.leftIcon),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (int.parse(quanltityCtrl.text.trim()) > widget.quanitityMinLimit!) {
                      context.read<CounterCubit>().decrement();
                    }
                  },
                ),
                SizedBox(
                  width: 200,
                  child: BlocBuilder<CounterCubit, int>(
                    builder: (_, count) {
                      quanltityCtrl.text = count.toString();
                      return TextField(
                        controller: quanltityCtrl,
                        maxLength: widget.quanitityMaxLimit.toString().length,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          counterText: '',
                        ),
                        onChanged: (String str) {
                          final minValue = widget.quanitityMinLimit;
                          if (str.trim().isNotEmpty && int.parse(str.trim()) > minValue!) {
                            final count = int.parse(str);
                            context.read<CounterCubit>().counter(count);
                          } else {
                            quanltityCtrl.text = '$minValue';
                            context.read<CounterCubit>().counter(minValue!);
                          }
                        },
                      );
                    },
                  ),
                ),
                OutlinedButton(
                  child: Icon(widget.rightIcon),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (int.parse(quanltityCtrl.text.trim()) < 99) {
                      context.read<CounterCubit>().increment();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
