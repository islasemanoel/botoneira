import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';

abstract class PadBankState {}

class StartState implements PadBankState {
  const StartState();
}

class LoadingState implements PadBankState {
  const LoadingState();
}

class ErrorState implements PadBankState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements PadBankState {
  const SuccessState();
}
