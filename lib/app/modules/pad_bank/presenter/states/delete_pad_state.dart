import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';

abstract class DeletePadState {}

class StartState implements DeletePadState {
  const StartState();
}

class LoadingState implements DeletePadState {
  const LoadingState();
}

class ErrorState implements DeletePadState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements DeletePadState {
  const SuccessState();
}
