import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';

abstract class AddPadState {}

class StartState implements AddPadState {
  const StartState();
}

class LoadingState implements AddPadState {
  const LoadingState();
}

class ErrorState implements AddPadState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements AddPadState {
  final Pad pad;
  const SuccessState(this.pad);
}