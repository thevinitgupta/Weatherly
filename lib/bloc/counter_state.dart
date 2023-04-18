

import 'dart:collection';

import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable{}

class CounterInitial extends CounterState {
  @override
  List<Object?> get props => [];
}
class CounterLoading extends CounterState {
  @override
  List<Object?> get props => [];
}

class DataState extends CounterState{
  int counter;
  DataState({
    required this.counter
  });

  @override
  String toString() {
    return super.toString();
  }

  @override
  int get hashCode {
    return 0;
  }

  @override
  List<Object?> get props => [];
}

// class Student extends Equatable{
//   final int rollNo;
//   // final String name;
//   // final String className;
//   Student(this.rollNo);
//
//
//   @override
//   String toString() {
//     return "$rollNo";
//   }
//
//   @override
//   List<Object?> get props => [rollNo];
//
// }
//
//
//
// extension StringX on String {
//   @override
//   compareTo(String other) {
//     return toLowerCase().compareTo(other.toLowerCase());
//   }
//
//   toTitleCase() {
//     return this[0].toUpperCase() + this.substring(1, this.length).toLowerCase();
//   }
// }

