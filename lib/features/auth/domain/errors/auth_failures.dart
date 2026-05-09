abstract class AuthFailure implements Exception {}

class EmailAlreadyRegisteredFailure extends AuthFailure {}
class InvalidCredentialsFailure extends AuthFailure {}
class EmailNotVerifiedFailure extends AuthFailure {}
class InvalidTokenFailure extends AuthFailure {}
class ExpiredTokenFailure extends AuthFailure {}
class ServerFailure extends AuthFailure {}