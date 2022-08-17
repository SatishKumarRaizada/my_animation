import 'package:equatable/equatable.dart';

abstract class QuantityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetQuantity extends QuantityEvent {
  final int quantity;
  GetQuantity({required this.quantity});
  @override
  List<Object> get props => [quantity];
}

class IncreaseQuantity extends QuantityEvent {
  final int quantity;
  IncreaseQuantity({required this.quantity});
  @override
  List<Object> get props => [quantity];
}

class DecreaseQuantity extends QuantityEvent {
  final int quantity;
  DecreaseQuantity({required this.quantity});
  @override
  List<Object> get props => [quantity];
}
