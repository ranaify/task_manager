import 'package:flutter/material.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/background_page.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../../data/services/network_caller.dart';
import '../../widgets/tm_app_bar.dart';

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addProcess = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: TMAppBar(),
        body: BackgroundPage(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Add New Task",
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Task Title",
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Task Description",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _addProcess == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(onPressed: () {
                      _createNewTask();
                    }, child: Text("Save")),
                  )
                ],
              ),
            ),
          ),
        )));
  }

  Future<void> _createNewTask() async {
    _addProcess = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: requestBody);
    _addProcess = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
      showSnackBarMessage(context, "New Task Created");
      // Navigator.pop(context);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextField(){
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
