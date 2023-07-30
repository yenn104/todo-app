import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/BL/blocs/todo/todo_blocs.dart';
import 'package:todoapp/DL/entities/todo.dart';
import 'package:todoapp/utils/the_colors.dart';

import '../../widgets/the_text_field.dart';

class CreateTodos extends StatelessWidget {
  const CreateTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController theTaskController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm công việc"),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thêm thành công")),
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Tiêu đề",
              style: TextStyle(
                fontSize: 16,
                color: TheColors.white,
              ),
            ),
            const SizedBox(height: 10),
            /*
             * theTextField is a widget that I created in the widgets folder
             * to make the code more readable and reusable
             */
            theTextField(
              context: context,
              controller: theTaskController,
              hintText: "Nhập ghi chú",
            ),

            const SizedBox(height: 10),
            CupertinoButton(
              color: TheColors.secondary,
              child: const Text(
                "Thêm",
                style: TextStyle(
                  fontFamily: 'montserrat_regular',
                ),
              ),
              onPressed: () {
                Todo todo = Todo(
                  id: 1,
                  userId: 1,
                  todo: theTaskController.text,
                );
                context.read<TodosBloc>().add(AddTodos(todo: todo));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}