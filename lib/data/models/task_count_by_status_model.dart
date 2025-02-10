class TaskCounterByStatusModel {
  String? status;
  List<TaskCountModel>? taskByStatusList;

  TaskCounterByStatusModel({this.status, this.taskByStatusList});

  TaskCounterByStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskByStatusList = <TaskCountModel>[];
      json['data'].forEach((v) {
        taskByStatusList!.add(TaskCountModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.taskByStatusList != null) {
      data['data'] = this.taskByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskCountModel {
  String? sId;
  String? sum;

  TaskCountModel({this.sId,this.sum});

  TaskCountModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}