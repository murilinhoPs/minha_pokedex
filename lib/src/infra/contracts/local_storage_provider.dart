abstract class LocalStorageProvider {
  //db.query('keyName')
  Future getItem({
    required String tableName,
    required List<String> values,
    required int itemId,
  }) async {}

  Future getAllItems(String tableName) async {}

  //db.insert('keyName', value)
  Future insertItem(String tableName, Map<String, dynamic> values) async {}

  //db.update('keyName', value, where: 'id == ?', whereArgs: [item.id])
  Future updateItem({
    required String tableName,
    required Map<String, dynamic> values,
    required int itemId,
  }) async {}

  //db.delete('keyName', value, where: 'id == ?', whereArgs: [item.id])
  Future deleteItem(String tableName, int itemId) async {}

  Future deleteTable(String tableName) async {}
}
