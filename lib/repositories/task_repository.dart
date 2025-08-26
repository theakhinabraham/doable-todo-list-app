import '../data/task_dao.dart';
import '../models/task_entity.dart';

class TaskRepository {
  Future<List<TaskEntity>> fetchAll() => TaskDao.getAll();
  Future<int> add(TaskEntity t) => TaskDao.insert(t);
  Future<int> update(TaskEntity t) => TaskDao.update(t);
  Future<int> delete(int id) => TaskDao.delete(id);
  Future<int> toggle(int id, bool value) => TaskDao.toggleCompleted(id, value);
  Future<void> seedDemo() => TaskDao.seedDemo();
}
