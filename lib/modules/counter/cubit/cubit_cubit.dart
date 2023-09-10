import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cubit_state.dart';

class CounterCubit extends Cubit<CounterState>
{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get (context) => BlocProvider.of(context);

  int counter = 1;

  void minus(){
    counter--;
    emit(CounterMinusState());
  }
  void plus(){
    counter++;
    emit(CounterPlusState());
  }

}
