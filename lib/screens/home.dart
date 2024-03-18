import 'package:ebookproject/constants/colors.dart';
import 'package:ebookproject/model/todo.dart';
import 'package:ebookproject/widgets/todo_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final  todosList = ToDo.todoList();
   List<ToDo> _foundToDo = [] ;
   final _todoController = TextEditingController();
   final _searchController = TextEditingController();

   @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                  searchBox(),
                  Expanded(
                    child: ListView(

                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text('All ToDos', style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500
                          ),),
                        ),
                        for(ToDo todo in _foundToDo.reversed)
                          ToDoItem(todo: todo, onToDoChanged: _handleToDoChange, onDeleteItem:  _handleToDoDelete ),

                      ],
                    ),
                  )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                controller: _todoController,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Add todolist',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  prefixIcon: Icon(Icons.edit),
                  border: InputBorder.none,
                  suffixIcon: Transform.rotate(
                    angle: -45 * 0.0174533 ,
                    child: Container(
                      child: IconButton(
                        onPressed: (){
                          _todoController.text != '' ? _addToDoItem(_todoController.text) : null;
                          _todoController.clear() ;
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoDelete(ToDo todo){
      setState(() {
         todosList.removeWhere((element) => element == todo);
      });
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _addToDoItem(String toDo){
      setState(() {
        todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
      });
  }

  void _searchToDoItem(String searchString){
     setState(() {
       // serchString ==  ? _foundToDo = todosList : _foundToDo = todosList.where((element) => element.todoText.contains(serchString)).toList();
       _foundToDo = searchString.isEmpty
           ? todosList
           : todosList.where((e) => e.todoText!.toLowerCase().contains(searchString.toLowerCase())).toList();
     });

  }



  Widget searchBox(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 )
      ),
      child: TextField(
        // textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => _searchToDoItem(value) ,
        controller: _searchController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20,),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(
                color: tdGrey
            )
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 30,
            color: tdBlack,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              child: Image.network(
                "https://i.pinimg.com/474x/21/a1/44/21a14439d74d43500e0dd4a58507ff3c.jpg",
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      ),
    );
  }
}
