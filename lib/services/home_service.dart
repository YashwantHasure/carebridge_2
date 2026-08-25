import '../models/care_task.dart';

class HomeService {
  static const String currentPatientId = 'patient_001';

  static List<CareTask> _todayTasks = [
    const CareTask(
      id: 'task_001',
      patientId: currentPatientId,
      title: 'Morning medication',
      description: 'Take medication after breakfast',
      time: '8:00 AM',
      completed: true,
      category: 'Medication',
    ),
    const CareTask(
      id: 'task_002',
      patientId: currentPatientId,
      title: 'Drink water',
      description: 'Drink a glass of water',
      time: '10:00 AM',
      completed: true,
      category: 'Wellness',
    ),
    const CareTask(
      id: 'task_003',
      patientId: currentPatientId,
      title: 'Take a short walk',
      description: 'Walk for at least 15 minutes',
      time: '1:00 PM',
      completed: true,
      category: 'Activity',
    ),
    const CareTask(
      id: 'task_004',
      patientId: currentPatientId,
      title: 'Check blood pressure',
      description: 'Record your blood pressure',
      time: '5:00 PM',
      completed: true,
      category: 'Health',
    ),
    const CareTask(
      id: 'task_005',
      patientId: currentPatientId,
      title: 'Evening medication',
      description: 'Take your evening medication',
      time: '8:00 PM',
      completed: false,
      category: 'Medication',
    ),
  ];

  static List<CareTask> getTodayTasks() {
    return List.unmodifiable(_todayTasks);
  }

  static int getCompletedTasks() {
    return _todayTasks.where((task) => task.completed).length;
  }

  static int getTotalTasks() {
    return _todayTasks.length;
  }

  static double getProgress() {
    if (_todayTasks.isEmpty) {
      return 0.0;
    }

    return getCompletedTasks() / getTotalTasks();
  }

  static CareTask? getNextTask() {
    for (final task in _todayTasks) {
      if (!task.completed) {
        return task;
      }
    }

    return null;
  }

  static void toggleTask(String taskId) {
    _todayTasks = _todayTasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          completed: !task.completed,
        );
      }

      return task;
    }).toList();
  }

  static void completeTask(String taskId) {
    _todayTasks = _todayTasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          completed: true,
        );
      }

      return task;
    }).toList();
  }
}