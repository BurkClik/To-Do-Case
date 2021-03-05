import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/screens/todo/todo_model.dart';
import 'package:todo/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:todo/theme/constant.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  Future<TodoModel> todoModel;

  TextEditingController searchController = TextEditingController();

  int searchWordCount = 0;

  @override
  void initState() {
    super.initState();
    todoModel = getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TodoModel>(
      future: todoModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: searchBar(),
              ),
              Expanded(
                flex: 10,
                child: searchWordCount == 0
                    ? allTodosList(snapshot)
                    : searchTodosList(context),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 32,
        child: TextFormField(
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              searchWordCount = searchController.text.length;
            });
          },
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Görev Ara',
            filled: true,
            fillColor: Colors.black.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  ListView searchTodosList(BuildContext context) {
    return ListView.builder(
      itemCount: context.read<SearchProvider>().resultLenght(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(context.read<SearchProvider>().searchResult[index]),
        );
      },
    );
  }

  ListView allTodosList(AsyncSnapshot<TodoModel> snapshot) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data.count,
      itemBuilder: (context, index) {
        return todoListTile(snapshot, index);
      },
    );
  }

  Padding todoListTile(AsyncSnapshot<TodoModel> snapshot, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          background: Container(
            padding: EdgeInsets.only(left: 24.0),
            color: Color(0xFFA6C2A7),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tamamlandı!',
                style: kDismissibleTextStyle,
              ),
            ),
          ),
          key: Key(snapshot.data.todoList[index]["name"]),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            deleteTodo(snapshot.data.todoList[index]["id"]);
          },
          child: ListTile(
            shape: RoundedRectangleBorder(),
            tileColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                deleteTodo(snapshot.data.todoList[index]["id"]);
              },
              icon: Icon(Icons.delete),
            ),
            title: Text(
              '${snapshot.data.todoList[index]["name"]}',
              style: kTodoNameTextStyle,
            ),
            subtitle: Text(
                '${DateTime.parse(snapshot.data.todoList[index]["date"])}'),
          ),
        ),
      ),
    );
  }
}
