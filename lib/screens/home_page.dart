import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; // for DateFormat [web:146][web:156]

import 'package:doable_todo_list_app/repositories/task_repository.dart';

/// UI-facing model used on this page (mapped from DB rows).
class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.time,
    this.date,
    this.hasNotification = false,
    this.repeatRule,
    this.completed = false,
  });

  final int id;
  String title;
  String? description;
  String? time; // e.g., "11:30 AM"
  String? date; // e.g., "26/11/24"
  bool hasNotification;
  String? repeatRule; // e.g., "Daily", "Weekly", "Monthly", "Weekly:[1,2,4]"
  bool completed;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ---- Data from SQLite rendered by the UI ----
  final List<Task> _tasks = [];

  // ---- Filter state ----
  DateTime? _fltDate;        // match by formatted dd/MM/yy vs task.date
  TimeOfDay? _fltTime;       // match by formatted h:mm a vs task.time
  bool? _fltCompleted;       // true=completed, false=incomplete, null=any
  String? _fltRepeat;        // "Daily"|"Weekly"|"Monthly"|null=any
  bool? _fltReminder;        // true=hasNotification, false=no, null=any

  String _fmtDate(DateTime d) => DateFormat('dd/MM/yy').format(d); // [web:146]
  String _fmtTime(TimeOfDay t) =>
      DateFormat('h:mm a').format(DateTime(0, 1, 1, t.hour, t.minute)); // [web:146]

  // Filtered + ordered (incomplete first, completed last)
  List<Task> get _filteredTasks {
    Iterable<Task> it = _tasks;

    if (_fltDate != null) {
      final d = _fmtDate(_fltDate!);
      it = it.where((t) => (t.date ?? '') == d);
    }
    if (_fltTime != null) {
      final tm = _fmtTime(_fltTime!);
      it = it.where((t) => (t.time ?? '') == tm);
    }
    if (_fltCompleted != null) {
      it = it.where((t) => t.completed == _fltCompleted);
    }
    if (_fltRepeat != null) {
      it = it.where((t) {
        final r = (t.repeatRule ?? '').trim();
        if (r.isEmpty) return false;
        if (_fltRepeat == 'Weekly') return r.startsWith('Weekly');
        return r == _fltRepeat;
      });
    }
    if (_fltReminder != null) {
      it = it.where((t) => t.hasNotification == _fltReminder);
    }

    final a = it.where((t) => !t.completed).toList();
    final b = it.where((t) => t.completed).toList();
    return [...a, ...b];
  }

  void _clearFilters() {
    setState(() {
      _fltDate = null;
      _fltTime = null;
      _fltCompleted = null;
      _fltRepeat = null;
      _fltReminder = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _init(); // initial DB load
  }

  Future<void> _init() async {
    // await TaskDao.seedDemo(); // optional first-run seeding
    await _load();
  }

  Future<void> _load() async {
    final rows = await TaskRepository().fetchAll();
    final mapped = rows
        .map((e) => Task(
      id: e.id!,
      title: e.title,
      description: e.description,
      time: e.time,
      date: e.date,
      hasNotification: e.hasNotification,
      repeatRule: e.repeatRule,
      completed: e.completed,
    ))
        .toList();

    if (!mounted) return;
    setState(() {
      _tasks
        ..clear()
        ..addAll(mapped);
    });
  }

  Future<void> _toggle(Task t) async {
    await TaskRepository().toggle(t.id, !t.completed);
    await _load();
  }

  Future<void> _delete(Task t) async {
    await TaskRepository().delete(t.id);
    await _load();
  }

  void _openSettings() {
    // Ensure the route name matches your MaterialApp routes
    Navigator.of(context).pushNamed('settings');
  }

  double verticalPadding(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.07;
  double horizontalPadding(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05;

  // ---- Filter bottom sheet ----
  Future<void> _openFilterSheet() async {
    await showModalBottomSheet<void>( // [web:146][web:148]
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder( // local state inside sheet [web:145][web:154][web:158]
          builder: (context, setSheetState) {
            Future<void> pickDate() async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: _fltDate ?? now,
                firstDate: DateTime(now.year - 1),
                lastDate: DateTime(now.year + 5),
                helpText: 'Select date',
              );
              if (picked != null) setSheetState(() => _fltDate = picked);
            }

            Future<void> pickTime() async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _fltTime ?? TimeOfDay.now(),
                helpText: 'Select time',
              );
              if (picked != null) setSheetState(() => _fltTime = picked);
            }

            Widget chip(String label, bool selected, VoidCallback onTap) {
              final bg = selected ? Colors.black : Colors.white;
              final fg = selected ? Colors.white : Colors.black;
              return Material(
                color: bg,
                shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
                child: InkWell(
                  onTap: onTap,
                  customBorder: const StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
                  ),
                ),
              );
            }

            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text('Date & Time',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                      const SizedBox(height: 12),

                      _PickerRow(
                        icon: Icons.calendar_today,
                        label: _fltDate != null ? _fmtDate(_fltDate!) : 'Set date',
                        onTap: pickDate,
                        onClear: _fltDate != null ? () => setSheetState(() => _fltDate = null) : null,
                      ),
                      const SizedBox(height: 12),
                      _PickerRow(
                        icon: Icons.access_time,
                        label: _fltTime != null ? _fmtTime(_fltTime!) : 'Set time',
                        onTap: pickTime,
                        onClear: _fltTime != null ? () => setSheetState(() => _fltTime = null) : null,
                      ),

                      const SizedBox(height: 20),
                      const Text('Completion Status',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          chip('Completed', _fltCompleted == true,
                                  () => setSheetState(() => _fltCompleted = true)),
                          chip('Incomplete', _fltCompleted == false,
                                  () => setSheetState(() => _fltCompleted = false)),
                          chip('Any', _fltCompleted == null,
                                  () => setSheetState(() => _fltCompleted = null)),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Text('Repeat',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          chip('Daily', _fltRepeat == 'Daily',
                                  () => setSheetState(() => _fltRepeat = 'Daily')),
                          chip('Weekly', _fltRepeat == 'Weekly',
                                  () => setSheetState(() => _fltRepeat = 'Weekly')),
                          chip('Monthly', _fltRepeat == 'Monthly',
                                  () => setSheetState(() => _fltRepeat = 'Monthly')),
                          chip('No repeat', _fltRepeat == null,
                                  () => setSheetState(() => _fltRepeat = null)),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Text('Reminders',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          chip('On', _fltReminder == true,
                                  () => setSheetState(() => _fltReminder = true)),
                          chip('Off', _fltReminder == false,
                                  () => setSheetState(() => _fltReminder = false)),
                          chip('Any', _fltReminder == null,
                                  () => setSheetState(() => _fltReminder = null)),
                        ],
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // close sheet
                            setState(() {}); // apply filters to list
                          },
                          child: const Text('Apply Filter'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setSheetState(() {
                              _fltDate = null;
                              _fltTime = null;
                              _fltCompleted = null;
                              _fltRepeat = null;
                              _fltReminder = null;
                            });
                          },
                          child: const Text('Clear selections'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding(context),
                verticalPadding(context),
                horizontalPadding(context),
                12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Logo + Settings
                  Row(
                    children: [
                      SvgPicture.asset('assets/trans_logo.svg', height: 28),
                      const Spacer(),
                      IconButton(
                        iconSize: 28,
                        splashRadius: 28,
                        tooltip: 'Settings',
                        onPressed: _openSettings,
                        icon: const Icon(Icons.menu, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Row 2: Today + Filter
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 96, minHeight: 48),
                        child: _FilterChipButton(
                          label: 'Filter',
                          onTap: _openFilterSheet, // open bottom sheet
                          height: 36,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Task list (uses filtered tasks)
          SliverList.separated(
            itemBuilder: (context, index) {
              final task = _filteredTasks[index];
              return Dismissible(
                key: ValueKey(task.id),
                direction:
                task.completed ? DismissDirection.endToStart : DismissDirection.none,
                background: const SizedBox.shrink(),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red.shade50,
                  child: Icon(Icons.delete, color: Colors.red.shade400),
                ),
                confirmDismiss: (_) async => task.completed,
                onDismissed: (_) => _delete(task),
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      'edit_task',
                      arguments: task,
                    );
                    if (result == true) await _load();
                  },
                  child: _TaskTile(task: task, onToggle: () => _toggle(task)),
                ),
              );
            },
            separatorBuilder: (_, __) => const Padding(
              padding: EdgeInsets.only(left: 72, right: 16),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Divider(height: 1),
                  SizedBox(height: 8),
                ],
              ),
            ),
            itemCount: _filteredTasks.length,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final saved = await Navigator.pushNamed(context, 'add_task');
          if (saved == true) await _load();
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        elevation: 3,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    required this.onTap,
    this.height = 36,
    this.minWidth = 96,
  });

  final String label;
  final VoidCallback onTap;
  final double minWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
      child: Material(
        color: Colors.white,
        shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/filter.svg',
                    height: 18,
                    width: 18,
                    colorFilter:
                    const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.task,
    required this.onToggle,
  });

  final Task task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final isDone = task.completed;

    final titleStyle = TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w800,
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
      color: isDone ? Colors.blueGrey : Colors.black,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CircleCheck(completed: isDone, onTap: onToggle),
          const SizedBox(width: 12),
          Expanded(
            child: isDone
                ? Text(
              task.title,
              style: titleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
                : _IncompleteContent(task: task, titleStyle: titleStyle),
          ),
        ],
      ),
    );
  }
}

class _IncompleteContent extends StatelessWidget {
  const _IncompleteContent({required this.task, required this.titleStyle});

  final Task task;
  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    final metaStyle = TextStyle(
      fontSize: 12,
      height: 1.33,
      color: Colors.blueGrey.shade600,
      fontWeight: FontWeight.w600,
    );

    final List<Widget> meta = [];
    if (task.time != null) {
      meta.add(_Meta(icon: Icons.access_time, text: task.time!, style: metaStyle));
    }
    if (task.date != null) {
      meta.add(_Meta(icon: Icons.event, text: task.date!, style: metaStyle));
    }
    if (task.hasNotification) {
      meta.add(_Meta(icon: Icons.notifications, text: '', style: metaStyle));
    }
    if ((task.repeatRule ?? '').isNotEmpty) {
      meta.add(_Meta(icon: Icons.repeat, text: task.repeatRule!, style: metaStyle));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: titleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if ((task.description ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2.0, right: 8),
            child: Text(
              task.description!,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.blueGrey.shade700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (meta.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(spacing: 12, runSpacing: 6, children: meta),
          ),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text, required this.style});
  final IconData icon;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: style.color),
        if (text.isNotEmpty) ...[
          const SizedBox(width: 6),
          Text(text, style: style),
        ],
      ],
    );
  }
}

class _CircleCheck extends StatelessWidget {
  const _CircleCheck({required this.completed, required this.onTap});
  final bool completed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      customBorder: const CircleBorder(),
      radius: 24,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: completed ? Colors.blue : Colors.blueGrey.shade200,
            width: 2,
          ),
          color: completed ? Colors.blue : Colors.transparent,
        ),
        child: completed
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}

// Compact list-style picker row used in the filter sheet.
class _PickerRow extends StatelessWidget {
  const _PickerRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.onClear,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final hasValue = label != 'Set date' && label != 'Set time';
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: hasValue ? Colors.black : Colors.black54,
                    fontWeight: hasValue ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              if (hasValue && onClear != null)
                IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.close, size: 20, color: Colors.black54),
                  onPressed: onClear,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
