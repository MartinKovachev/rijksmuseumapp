part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityState {}

class Connected extends ConnectivityState {}
class Disconnected extends ConnectivityState {}
