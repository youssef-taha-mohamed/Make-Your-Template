part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

class AppChangeBottomNavBarState extends AppState{}

class AppCreateDatabaseState extends AppState{}

class AppGetDatabaseState extends AppState{}

class AppInsertDatabaseState extends AppState{}

class AppUpdateDatabaseState extends AppState{}

class AppDeleteDatabaseState extends AppState{}

class AppChangeBottomSheetState extends AppState{}

class AppGetDatabaseLoadingState extends AppState{}


