import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Data layer
import 'package:doable_todo_list_app/data/task_dao.dart';

// UI model used by the widget (mapped from DB rows)
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
  String? time; // "11:30 AM"
  String? date; // "26/11/24"
  bool hasNotification;
  String? repeatRule; // "Daily" / "Weekly" / etc.
  bool completed;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Optional: seed once (comment out after first run)
    // await TaskDao.seedDemo();
    await _load();
  }

  Future<void> _load() async {
    final rows = await TaskDao.getAll();
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

  List<Task> get _sortedTasks {
    // DAO already orders incomplete first; this is a defensive fallback.
    final a = _tasks.where((t) => !t.completed).toList();
    final b = _tasks.where((t) => t.completed).toList();
    return [...a, ...b];
    // Reference ordering approach matches DB guidance. [1][9]
  }

  Future<void> _toggle(Task t) async {
    await TaskDao.toggleCompleted(t.id, !t.completed);
    await _load();
    // Toggling and reloading after pop is a common pattern. [1]
  }

  Future<void> _delete(Task t) async {
    await TaskDao.delete(t.id);
    await _load();
    // Deleting via DAO then refreshing list. [1][9]
  }

  void _openSettings() {
    Navigator.of(context).pushNamed('/settings');
    // Standard named-routing usage. [11][12]
  }

  double verticalPadding(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.07;
  double horizontalPadding(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Two-row header
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
                  // Row 1: Logo left, settings right
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
                  // Row 2: Today + Filter chip
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 24, // headline-ish
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      ConstrainedBox(
                        constraints:
                        const BoxConstraints(minWidth: 96, minHeight: 48),
                        child: _FilterChipButton(
                          label: 'Filter',
                          onTap: () {
                            // TODO: open filter sheet
                          },
                          height: 36, // visual height
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Task list
          SliverList.separated(
            itemBuilder: (context, index) {
              final task = _sortedTasks[index];
              return Dismissible(
                key: ValueKey(task.id),
                direction: task.completed
                    ? DismissDirection.endToStart
                    : DismissDirection.none,
                background: const SizedBox.shrink(),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red.shade50,
                  child: Icon(Icons.delete, color: Colors.red.shade400),
                ),
                confirmDismiss: (_) async => task.completed,
                onDismissed: (_) => _delete(task),
                child: _TaskTile(task: task, onToggle: () => _toggle(task)),
              );
            },
            // Spacious separators: gap + subtle divider + gap
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
            itemCount: _sortedTasks.length,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to add task and refresh on success
          final saved = await Navigator.pushNamed(context, 'add_task');
          if (saved == true) {
            await _load();
          }
          // Named routes with returning a result is the idiomatic approach. [11][12]
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
    // Keeps at least 48x48 tap target; visual container is 36 tall
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
                      fontSize: 14, // labelLarge-ish
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
                    colorFilter: const ColorFilter.mode(
                      Colors.black87,
                      BlendMode.srcIn,
                    ),
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
      fontSize: 16, // bodyLarge/titleMedium
      height: 1.5,
      fontWeight: FontWeight.w800,
      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
      color: isDone ? Colors.blueGrey : Colors.black,
    );

    return Padding(
      // slightly larger vertical padding for breathing room
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
      fontSize: 12, // label/bodySmall
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
                fontSize: 14, // bodyMedium
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
        child: completed ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
      ),
    );
  }
}
