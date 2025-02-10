import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_page.dart';
import '../../widgets/task_item_widget.dart';
import '../../widgets/tm_app_bar.dart';

class ProgressTaskListPage extends StatefulWidget {
  const ProgressTaskListPage({super.key});

  @override
  State<ProgressTaskListPage> createState() => _NewTaskListPageState();
}

class _NewTaskListPageState extends State<ProgressTaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundPage(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: _buildTaskListView(),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        // return TaskItemWidget();
      },
    );
  }
}


