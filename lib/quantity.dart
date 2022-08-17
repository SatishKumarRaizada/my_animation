import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime/quantity_widget/quantity_cubit.dart';

class QuantityPage extends StatefulWidget {
  const QuantityPage({Key? key}) : super(key: key);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (int.parse(quanltityCtrl.text.trim()) > 1) {
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
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                    onChanged: (String str) {
                      if (str.trim().isNotEmpty && int.parse(str.trim()) > 1) {
                        final count = int.parse(str);
                        context.read<CounterCubit>().counter(count);
                      } else {
                        quanltityCtrl.text = '1';
                        context.read<CounterCubit>().counter(1);
                      }
                    },
                  );
                },
              ),
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (int.parse(quanltityCtrl.text.trim()) < 99) {
                  context.read<CounterCubit>().increment();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
