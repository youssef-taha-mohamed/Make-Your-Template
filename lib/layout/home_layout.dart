import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_you/shared/components/components.dart';
import 'package:e_you/shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database

class HomeLayout extends StatelessWidget {
  //
  // @override
  // void initState() {
  //   super.initState();
  //   createDatabase();
  // }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    // insertToDatabase(
                    //   date: dateController.text,
                    //   time: timeController.text,
                    //   title: titleController.text,
                    // ).then((value) {
                    //   getDateFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                createTextField(
                                    controller: titleController,
                                    inputType: TextInputType.text,
                                    onTab: () {
                                      //print("New Tab");
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title Must Not Be Empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefixIcon: Icons.title),
                                const SizedBox(
                                  height: 15,
                                ),
                                createTextField(
                                    controller: timeController,
                                    inputType: TextInputType.datetime,
                                    //isClickable : false,
                                    onTab: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                      //print("Timing Tab");
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Time Must Not Be Empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefixIcon: Icons.lock_clock),
                                const SizedBox(
                                  height: 15,
                                ),
                                createTextField(
                                  controller: dateController,
                                  inputType: TextInputType.datetime,
                                  onTab: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-12-30'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date Must Not Be Empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Date',
                                  prefixIcon: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomShettState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomShettState(
                      isShow: true, icon: Icons.add); // setState(() {
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: "Check",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: "Archive",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//  Instance of 'Future<String>'
// Future<String> getName() async {
//   return 'You';
// }
}

//
// async {
// // try{
// //   var name = await getName();
// //   print(name);
// //   print("object");
// //   throw('Some Error!!!');
// // }catch(error){
// //   print('Error ${error.toString()}');
// // }
//
// getName().then((value) {
// print(value);
// print("object");
// //throw("أنا عملت خطا..");
// }).catchError((error) {
// print("error ${error.toString()}");
// });
// },
