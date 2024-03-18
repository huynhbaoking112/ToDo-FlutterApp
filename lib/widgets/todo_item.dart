import 'package:ebookproject/constants/colors.dart';
import 'package:ebookproject/model/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget{

  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  ToDoItem({ required this.todo, required this.onToDoChanged, required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(todo.isDone ? Icons.check_box: Icons.check_box_outline_blank , color: tdBlue,),
        title: Text(todo.todoText! , style: TextStyle(
          fontSize: 16, color: tdBlack,decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none
        ),),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo);
            },
          ),
        ),
      ),
    );
  }
  
}