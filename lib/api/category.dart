import 'package:new_mac_test/models/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Category>> getCategories() async {
  final res = await supabase.from('category').select("*");
  return Category.listFromJson(res);
}

Future<Category> createCategory(Category category) async {
  final response = await supabase.from('category').insert(category.toJson());
  if (response.error != null) {
    throw response.error!;
  }
  return category;
}

Future<Category> updateCategory(Category category) async {
  final response = await supabase
      .from('category')
      .update(category.toJson())
      .eq('id', category.id);
  if (response.error != null) {
    throw response.error!;
  }
  return category;
}

Future<void> deleteCategory(int id) async {
  final response = await supabase.from('category').delete().eq('id', id);
  if (response.error != null) {
    throw response.error!;
  }
}

Future<void> updateStoreCategories(String storeId, List<int> categories) async {
  final data = List.from(categories
      .map((categoryId) => {'store_id': storeId, 'category_id': categoryId}));
  try {
    await supabase.from('store_category').delete().eq('store_id', storeId);
    await supabase.from('store_category').insert(data);
  } catch (e) {
    print(e);
    rethrow;
  }
}
