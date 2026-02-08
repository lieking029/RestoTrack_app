import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

class MenuLoadItems extends MenuEvent {
  const MenuLoadItems();
}

class MenuLoadByCategory extends MenuEvent {
  const MenuLoadByCategory(this.categoryId);

  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}

class MenuLoadCategories extends MenuEvent {
  const MenuLoadCategories();
}

class MenuSearch extends MenuEvent {
  const MenuSearch(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class MenuClearSearch extends MenuEvent {
  const MenuClearSearch();
}

class MenuSelectCategory extends MenuEvent {
  const MenuSelectCategory(this.categoryId);

  final int? categoryId;

  @override
  List<Object?> get props => [categoryId];
}