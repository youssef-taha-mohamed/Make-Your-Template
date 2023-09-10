import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_you/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

Widget defuaaltButton({
  required VoidCallback function,
  required String text,
  double width = double.infinity,
  Color background = Colors.blue,
}) =>
    Container(
      color: background,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget createTextField({
  required TextEditingController controller,
  required TextInputType inputType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefixIcon,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
  GestureTapCallback? onTab,
  bool isClickable = true,
}) =>
    TextFormField(
      keyboardType: inputType,
      controller: controller,
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validator,
      onTap: onTab,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: suffixPressed,
              )
            : null,
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['id']);
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.black45,
                )),
          ],
        ),
      ),
  onDismissed:(direction){
    AppCubit.get(context).deleteData(id: model['id']);
  } ,
    );

Widget tasksBuilder({
  required List<Map> tasks
}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder:(context) => ListView.separated(
    itemBuilder: (context, index) =>
        buildTaskItem(
            tasks[index],context
        ),
    separatorBuilder: (context, index) =>
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:const [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          "No Tasks Yet, Please Add Some Tasks",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ],
    ),
  ),
);
