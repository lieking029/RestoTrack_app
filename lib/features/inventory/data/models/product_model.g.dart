// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      initialStock: (json['initialStock'] as num).toInt(),
      unitOfMeasurement:
          $enumDecode(_$UnitOfMeasurementEnumMap, json['unitOfMeasurement']),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      status: $enumDecodeNullable(_$ProductStatusEnumMap, json['status']) ??
          ProductStatus.onStock,
      stockOut: (json['stockOut'] as num?)?.toInt(),
      remainingStock: (json['remainingStock'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'initialStock': instance.initialStock,
      'unitOfMeasurement':
          _$UnitOfMeasurementEnumMap[instance.unitOfMeasurement]!,
      'expirationDate': instance.expirationDate.toIso8601String(),
      'status': _$ProductStatusEnumMap[instance.status]!,
      'stockOut': instance.stockOut,
      'remainingStock': instance.remainingStock,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UnitOfMeasurementEnumMap = {
  UnitOfMeasurement.piece: 0,
  UnitOfMeasurement.kilogram: 1,
  UnitOfMeasurement.gram: 2,
  UnitOfMeasurement.liter: 3,
  UnitOfMeasurement.milliliter: 4,
  UnitOfMeasurement.pack: 5,
};

const _$ProductStatusEnumMap = {
  ProductStatus.onStock: 0,
  ProductStatus.lowOnStock: 1,
  ProductStatus.noStock: 2,
};
