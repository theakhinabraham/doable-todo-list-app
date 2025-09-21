import '../data/task_dao.dart';
import '../models/task_entity.dart';
import '../services/notification_service.dart';

class TaskRepository {
  Future<List<TaskEntity>> fetchAll() => TaskDao.getAll();

  Future<int> add(TaskEntity t) async {
    final id = await TaskDao.insert(t);
    t.id = id;

    if (t.hasNotification) {
      await NotificationService.scheduleTaskNotification(t);
    }
    return id;
  }

  Future<int> update(TaskEntity t) async {
    final result = await TaskDao.update(t);

    if (t.id != null) {
      await NotificationService.cancelTaskNotification(t.id);
      if (t.hasNotification && !t.completed) {
        await NotificationService.scheduleTaskNotification(t);
      }
    }
    return result;
  }

  Future<int> delete(int id) async {
    // Cancel notification before deleting task
    await NotificationService.cancelTaskNotification(id);
    return TaskDao.delete(id);
  }

  Future<int> toggle(int id, bool value) async {
    final result = await TaskDao.toggleCompleted(id, value);
    if (value) {
      // Cancel notification if task is completed
      await NotificationService.cancelTaskNotification(id);
    } else {
      // Reschedule notification if task is uncompleted
      final task = await TaskDao.getById(id);
      if (task != null && task.hasNotification) {
        await NotificationService.scheduleTaskNotification(task);
      }
    }
    return result;
  }

  Future<void> seedDemo() => TaskDao.seedDemo();

  Future<int> clearAll() async {
    // Cancel all notifications first
    await NotificationService.cancelAllNotifications();
    return TaskDao.clearAll();
  }
}
