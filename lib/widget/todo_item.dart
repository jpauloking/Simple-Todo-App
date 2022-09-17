import 'package:flutter/material.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.changeHandler,
      required this.deleteHandler})
      : super(key: key);
  final ToDo todo;
  final changeHandler;
  final deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      child: ListTile(
        onTap: () {
          changeHandler(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: myBlue,
        ),
        tileColor: myWhite,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 20.0,
        ),
        title: Text(
          todo.title!,
          style: TextStyle(
            fontSize: 16.0,
            color: myBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: myRed,
            borderRadius: BorderRadius.circular(5.0),
          ),
          width: 35.0,
          height: 35.0,
          child: IconButton(
            onPressed: () {
              deleteHandler(todo);
            },
            icon: const Icon(
              Icons.delete,
              color: myWhite,
              size: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
