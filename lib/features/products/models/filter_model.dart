import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final double? fromCarat;
  final double? toCarat;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;

  const FilterModel({
    this.fromCarat,
    this.toCarat,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
  });

  FilterModel copyWith({
    double? fromCarat,
    double? toCarat,
    String? lab,
    String? shape,
    String? color,
    String? clarity,
  }) =>
      FilterModel(
        fromCarat: fromCarat ?? this.fromCarat,
        toCarat: toCarat ?? this.toCarat,
        lab: lab ?? this.lab,
        shape: shape ?? this.shape,
        color: color ?? this.color,
        clarity: clarity ?? this.clarity,
      );

  @override
  List<Object?> get props => [
        fromCarat,
        toCarat,
        lab,
        shape,
        color,
        clarity,
      ];
}
