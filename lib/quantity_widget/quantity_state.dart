import 'package:equatable/equatable.dart';

abstract class QuantityState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialQuantityState extends QuantityState {
  final int quantity;
  InitialQuantityState({required this.quantity});
  @override
  List<Object> get props => [quantity];
}

class DecreasedQuantityState extends QuantityState {
  final int quantity;
  DecreasedQuantityState({required this.quantity});
  @override
  List<Object> get props => [quantity];
}

class IncreasedQuantitystate extends QuantityState {
  final int quantity;
  IncreasedQuantitystate({required this.quantity});
  @override
  List<Object> get props => [quantity];
}
