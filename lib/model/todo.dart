class ToDo {
  String? id;
  String? title;
  bool isDone;

  ToDo({required this.id, required this.title, this.isDone = false});

  static List<ToDo> toDos() {
    return [
      ToDo(id: "1", title: "One Item"),
      ToDo(id: "2", title: "Two Item"),
      ToDo(id: "3", title: "Three Item", isDone: false),
      ToDo(id: "4", title: "Four Item", isDone: true),
      ToDo(id: "5", title: "Five Item", isDone: true),
    ];
  }
}
