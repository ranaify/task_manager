import  'package:flutter/material.dart';
import 'package:task_manager/ui/pages/bottom_nav_page/add_new_task_page.dart';
import 'package:task_manager/ui/widgets/background_page.dart';
import '../../../data/models/task_count_by_status_model.dart';
import '../../../data/models/task_list_by_status_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_item_widget.dart';
import '../../widgets/task_status_summary_counter.dart';
import '../../widgets/tm_app_bar.dart';

class NewTaskListPage extends StatefulWidget {
  const NewTaskListPage({super.key});

  @override
  State<NewTaskListPage> createState() => _NewTaskListPageState();
}

class _NewTaskListPageState extends State<NewTaskListPage> {
  bool _getTaskCountProcess = false;
  bool _getNewTaskProcess = false;
  TaskCounterByStatusModel? taskCounterByStatusModel;
  TaskListByStatusModel? newTaskListModel;
  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: BackgroundPage(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Visibility(
                    visible: _getNewTaskProcess == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: _buildTaskListView()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskPage.name);
        },
        child: Icon(Icons.add,),)
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
              shrinkWrap: true,
              itemCount: newTaskListModel?.taskList?.length ?? 0,
              primary: false,
              itemBuilder: (context, index) {
                return TaskItemWidget(taskModel: newTaskListModel!.taskList![index],);
              },
            );
  }

  Widget _buildTaskSummaryByStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Visibility(
        visible: _getTaskCountProcess == false,
        replacement: CenterCircularProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: taskCounterByStatusModel?.taskByStatusList?.length ?? 0,
              itemBuilder: (context, index) {
                final TaskCountModel model = taskCounterByStatusModel!.taskByStatusList![index];
              return TaskStatusSummaryCounter(
                title: model.sId ?? "",
                count: model.sum.toString(),
              );
            },),
          ),
        ),
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async {
    _getTaskCountProcess = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);
   if(response.isSuccess){
     taskCounterByStatusModel = TaskCounterByStatusModel.fromJson(response.responseData!);
   }else{
     showSnackBarMessage(context, response.errorMessage);
   }
    _getTaskCountProcess = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskProcess = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl("New"));
    if(response.isSuccess){
      newTaskListModel = TaskListByStatusModel.fromJson(response.responseData!);
    }else{
      showSnackBarMessage(context, response.errorMessage);
    }
    _getNewTaskProcess = false;
    setState(() {});
  }
}


