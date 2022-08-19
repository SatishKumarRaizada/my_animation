import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime/quantity_widget/quantity_cubit.dart';

class QuantityPage extends StatefulWidget {
  final String? title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final int? quanitityMaxLimit;
  final int? quanitityMinLimit;
  final TextEditingController? quanltityCtrl;
  const QuantityPage({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.quanitityMinLimit,
    this.quanitityMaxLimit,
    this.title,
    this.quanltityCtrl,
  }) : super(key: key);
  @override
  State<QuantityPage> createState() => _QuantityPageState();
}

class _QuantityPageState extends State<QuantityPage> {
  @override
  void initState() {
    super.initState();
    widget.quanltityCtrl!.addListener(() {
      final text = widget.quanltityCtrl!.text.toLowerCase();
      widget.quanltityCtrl!.value = widget.quanltityCtrl!.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    context.read<CounterCubit>().counter(widget.quanitityMinLimit!);
    widget.quanltityCtrl!.text = '${widget.quanitityMinLimit}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  if (int.parse(widget.quanltityCtrl!.text.trim()) > widget.quanitityMinLimit!) {
                    context.read<CounterCubit>().decrement();
                  }
                },
              ),
              SizedBox(
                width: 200,
                child: BlocBuilder<CounterCubit, int>(
                  builder: (_, count) {
                    widget.quanltityCtrl!.text = count.toString();
                    return TextField(
                      controller: widget.quanltityCtrl!,
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
                          widget.quanltityCtrl!.text = '$minValue';
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
                  if (int.parse(widget.quanltityCtrl!.text.trim()) < 99) {
                    context.read<CounterCubit>().increment();
                  }
                },
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              final data = widget.quanltityCtrl!.text.trim();
              print(data);
            },
            child: const Text('Get Quantities'),
          ),
        ],
      ),
    );
  }

  int? getQuantity() {
    return context.read<CounterCubit>().counterState();
  }
}
