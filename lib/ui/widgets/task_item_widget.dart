import 'package:flutter/material.dart';

import '../../data/models/task_model2.dart';
class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        // leading: CircleAvatar(),
        title: Text(taskModel.title ?? ""),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskModel.description ?? ""),
            Text(taskModel.createdDate ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue
                  ),
                  child: Text("New", style: TextStyle(color: Colors.white),),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {  },icon: Icon(Icons.edit), ),
                    SizedBox(width: 8,),
                    IconButton(onPressed: () {  },icon: Icon(Icons.delete), ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}