// abstract interface class IBaseUseCase<Type> {
//   const IBaseUseCase();
// }

abstract interface class IUseCase<Type, Params> {
  Future<Type> call(Params params);
}
// abstract interface class IUseCase<Type, Params> extends IBaseUseCase<Type> {
//   Future<Type> call(Params params);
// }

final class NoParams {}

abstract interface class IUseCaseNoParams<Type> {
  const IUseCaseNoParams();
  Future<Type> call();
}
// abstract interface class IUseCaseNoParams<Type> extends IBaseUseCase<Type> {
//   const IUseCaseNoParams();
//   Future<Type> call();
// }

