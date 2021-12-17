import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';

abstract class AddPadBankState {}

class StartState implements AddPadBankState {
  const StartState();
}

class LoadingState implements AddPadBankState {
  const LoadingState();
}

class ErrorState implements AddPadBankState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements AddPadBankState {
  final PadBank padBank;
  const SuccessState(this.padBank);
}