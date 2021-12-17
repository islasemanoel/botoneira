import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';

abstract class DeletePadBankState {}

class StartState implements DeletePadBankState {
  const StartState();
}

class LoadingState implements DeletePadBankState {
  const LoadingState();
}

class ErrorState implements DeletePadBankState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements DeletePadBankState {
  const SuccessState();
}
