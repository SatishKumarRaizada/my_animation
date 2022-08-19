import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_anime/quantity.dart';

import 'quantity_cubit.dart';

class QuantityPageCounter extends StatefulWidget {
  const QuantityPageCounter({Key? key}) : super(key: key);

  @override
  State<QuantityPageCounter> createState() => _QuantityPageCounterState();
}

class _QuantityPageCounterState extends State<QuantityPageCounter> {
  final cubit = CounterCubit();
  final quanltityCtrl = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              BlocProvider(
                create: (context) => CounterCubit(),
                child: QuantityPage(
                  leftIcon: Icons.remove,
                  rightIcon: Icons.add,
                  title: 'Container Selection',
                  quanitityMinLimit: 10,
                  quanitityMaxLimit: 99,
                  quanltityCtrl: quanltityCtrl,
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  final data = quanltityCtrl.text;
                  print(quanltityCtrl.text);
                },
                child: const Text('Get Satish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
