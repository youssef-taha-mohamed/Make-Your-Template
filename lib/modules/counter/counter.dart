
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit_cubit.dart';

class CounterScreen extends StatelessWidget {

  CounterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    //var s = BlocProvider.of(context);

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterState >(
        listener: (context, state){

        },
        builder: (context, state){
           return Scaffold(
             appBar: AppBar(
               title: const Text("Counter"),
             ),
             body: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       TextButton(
                         onPressed: () {
                            CounterCubit.get(context).minus();
                         },
                         child: const Text("MINUS"),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 25.0),
                         child: Text(
                           "${CounterCubit.get(context).counter}",
                           style: const TextStyle(
                             fontWeight: FontWeight.w900,
                             fontSize: 70.0,
                           ),
                         ),
                       ),
                       TextButton(
                         onPressed: () {
                           CounterCubit.get(context).plus();
                         },
                         child: const Text("PLUS"),
                       ),
                     ],
                   ),
                   const SizedBox(
                     height: 60.0,
                   ),
                   TextButton(
                     onPressed: () {
                       // setState(()
                       // {
                       //   counter =0;
                       // });
                     },
                     child: const Text(
                       "CLEAR",
                       style: TextStyle(
                         color: Colors.red,

                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
        },
      ),
    );
  }
}

