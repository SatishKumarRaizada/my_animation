import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(1);
  void counter(int count) => emit(state * 0 + count);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void counterState() => emit(state);
}
