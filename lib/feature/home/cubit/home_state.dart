part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.items, this.isLoading, this.categories});

  final List<ProductModel>? items;
  final List<String>? categories;
  final bool? isLoading;

  @override
  List<Object?> get props => [items, categories, isLoading];

  HomeState copyWith(
      {List<ProductModel>? items, List<String>? categories, bool? isLoading}) {
    return HomeState(
      items: items ?? this.items,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
