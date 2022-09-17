import 'package:flutter/material.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/widget/todo_item.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.toDos();
  late final TextEditingController _textEditingController =
      TextEditingController();
  late final TextEditingController _searchTextEditingController =
      TextEditingController();
  late List<ToDo> filteredToDo = [];

  _handleChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  _handleDelete(ToDo toDo) {
    setState(() {
      todoList.removeWhere((element) => element.id == toDo.id);
    });
  }

  _handleAddItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(), title: toDo));
      _textEditingController.clear();
    });
  }

  _handleFilter(String searchString) {
    List<ToDo> result = [];
    if (searchString.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) =>
              element.title!.toLowerCase().contains(searchString.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredToDo = result;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredToDo = todoList;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildListContainer(),
          _buildInputToDoAlign(),
        ],
      ),
    );
  }

  Align _buildInputToDoAlign() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: myWhite,
                boxShadow: const [
                  BoxShadow(
                    color: myGrey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: "Add new task",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20.0,
              right: 20.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                _handleAddItem(_textEditingController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: myBlue,
                minimumSize: const Size(60.0, 60.0),
                elevation: 10.0,
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildListContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 15.0,
      ),
      child: Column(
        children: [
          _buildSearchBoxContainer(),
          Expanded(
            child: ListView(
              children: [
                _buildListTitleContainer(),
                for (ToDo todo in filteredToDo.reversed)
                  TodoItem(
                    todo: todo,
                    changeHandler: _handleChange,
                    deleteHandler: _handleDelete,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildListTitleContainer() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
        bottom: 20.0,
      ),
      child: const Text(
        'All Tasks',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container _buildSearchBoxContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (val) => _handleFilter(val),
        decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              size: 20.0,
              color: myBlack,
            ),
            border: InputBorder.none,
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20.0,
              maxWidth: 25.0,
            )),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: myBGColor,
      elevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: myBlack,
            size: 30.0,
          ),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/profile.png"),
            ),
          ),
        ],
      ),
    );
  }
}
