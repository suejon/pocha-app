final supabase = Supabase.instance.client;

bool getStores(int atomicNumber) {
  return final data = await supabase
  .from('store')
  .select();
}

