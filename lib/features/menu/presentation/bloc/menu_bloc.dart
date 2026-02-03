import 'package:bloc/bloc.dart';
import 'package:restotrack_app/features/menu/data/repository/menu_repository.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_event.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc({required MenuRepository menuRepository})
      : _menuRepository = menuRepository,
        super(const MenuState()) {
    on<MenuLoadItems>(_onLoadItems);
    on<MenuLoadByCategory>(_onLoadByCategory);
    on<MenuLoadCategories>(_onLoadCategories);
    on<MenuSearch>(_onSearch);
    on<MenuClearSearch>(_onClearSearch);
    on<MenuSelectCategory>(_onSelectCategory);
  }

  final MenuRepository _menuRepository;

  Future<void> _onLoadItems(
      MenuLoadItems event,
      Emitter<MenuState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final items = await _menuRepository.getMenuItems();
      emit(state.copyWith(
        isLoading: false,
        menuItems: items,
        filteredItems: items,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load menu items',
      ));
    }
  }

  Future<void> _onLoadByCategory(
      MenuLoadByCategory event,
      Emitter<MenuState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final items = await _menuRepository.getMenuItemsByCategory(event.categoryId);
      emit(state.copyWith(
        isLoading: false,
        filteredItems: items,
        selectedCategoryId: event.categoryId,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load menu items',
      ));
    }
  }

  Future<void> _onLoadCategories(
      MenuLoadCategories event,
      Emitter<MenuState> emit,
      ) async {
    try {
      final categories = await _menuRepository.getCategories();
      emit(state.copyWith(categories: categories));
    } catch (e) {
      // Silently fail for categories - not critical
    }
  }

  Future<void> _onSearch(
      MenuSearch event,
      Emitter<MenuState> emit,
      ) async {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      add(const MenuClearSearch());
      return;
    }

    emit(state.copyWith(isSearching: true, searchQuery: query));

    try {
      // Filter locally for instant results
      final filtered = state.menuItems.where((item) {
        return item.name.toLowerCase().contains(query) ||
            (item.description?.toLowerCase().contains(query) ?? false);
      }).toList();

      emit(state.copyWith(
        isSearching: false,
        filteredItems: filtered,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSearching: false,
        errorMessage: 'Search failed',
      ));
    }
  }

  void _onClearSearch(
      MenuClearSearch event,
      Emitter<MenuState> emit,
      ) {
    emit(state.copyWith(
      searchQuery: null,
      filteredItems: state.menuItems,
      selectedCategoryId: null,
    ));
  }

  void _onSelectCategory(
      MenuSelectCategory event,
      Emitter<MenuState> emit,
      ) {
    if (event.categoryId == null) {
      // Show all items
      emit(state.copyWith(
        selectedCategoryId: null,
        filteredItems: state.menuItems,
      ));
    } else {
      // Filter by category locally
      final filtered = state.menuItems
          .where((item) => item.categoryId == event.categoryId)
          .toList();
      emit(state.copyWith(
        selectedCategoryId: event.categoryId,
        filteredItems: filtered,
      ));
    }
  }
}