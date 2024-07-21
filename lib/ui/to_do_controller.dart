import 'package:flutter/foundation.dart';
import 'package:to_do_app/api_service/api_service.dart';
import 'package:to_do_app/model/to_do_model.dart';

class TodoProvider extends ChangeNotifier {
  List<ToDoModel> dataList = [];
  final ApiService apiService = ApiService();
  List<ToDoModel> get data => dataList;

  Future<void> fetData() async {
    dataList = await apiService.fetchList();
    notifyListeners();
  }

  Future<void> addItem(String title) async {
    try {
      await apiService.addTodo(title);
      final newTodo = ToDoModel(
        id: 0,
        title: title,
        isCompleted: false,
        userId: 10
      );
      dataList.insert(0, newTodo);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding todo: $e');
      }
    }
  }

  void deleteItem(int id) {
    dataList.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}




