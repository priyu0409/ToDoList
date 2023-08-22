class Task {
  String? title;
  String? description;
  String? priority;
  String? duedate;

  Task({this.title, this.description, this.priority, this.duedate});

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    priority = json['priority'];
    duedate = json['duedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['duedate'] = this.duedate;
    return data;
  }
}
