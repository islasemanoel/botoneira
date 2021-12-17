class Failure implements Exception {}

class InvalidSearchText extends Failure {}

class NotFound extends Failure {}

class EmptyList extends Failure {}

class ErrorDataBase extends Failure {}

class DatasourceResultNull extends Failure {}

class FileSourceNotFound extends Failure {}