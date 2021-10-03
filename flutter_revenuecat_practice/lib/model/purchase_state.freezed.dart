// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PurchaseStateTearOff {
  const _$PurchaseStateTearOff();

  _PurchaseState call({String? hoge}) {
    return _PurchaseState(
      hoge: hoge,
    );
  }
}

/// @nodoc
const $PurchaseState = _$PurchaseStateTearOff();

/// @nodoc
mixin _$PurchaseState {
  String? get hoge => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PurchaseStateCopyWith<PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
          PurchaseState value, $Res Function(PurchaseState) then) =
      _$PurchaseStateCopyWithImpl<$Res>;
  $Res call({String? hoge});
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  final PurchaseState _value;
  // ignore: unused_field
  final $Res Function(PurchaseState) _then;

  @override
  $Res call({
    Object? hoge = freezed,
  }) {
    return _then(_value.copyWith(
      hoge: hoge == freezed
          ? _value.hoge
          : hoge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$PurchaseStateCopyWith<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  factory _$PurchaseStateCopyWith(
          _PurchaseState value, $Res Function(_PurchaseState) then) =
      __$PurchaseStateCopyWithImpl<$Res>;
  @override
  $Res call({String? hoge});
}

/// @nodoc
class __$PurchaseStateCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res>
    implements _$PurchaseStateCopyWith<$Res> {
  __$PurchaseStateCopyWithImpl(
      _PurchaseState _value, $Res Function(_PurchaseState) _then)
      : super(_value, (v) => _then(v as _PurchaseState));

  @override
  _PurchaseState get _value => super._value as _PurchaseState;

  @override
  $Res call({
    Object? hoge = freezed,
  }) {
    return _then(_PurchaseState(
      hoge: hoge == freezed
          ? _value.hoge
          : hoge // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PurchaseState implements _PurchaseState {
  const _$_PurchaseState({this.hoge});

  @override
  final String? hoge;

  @override
  String toString() {
    return 'PurchaseState(hoge: $hoge)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PurchaseState &&
            (identical(other.hoge, hoge) ||
                const DeepCollectionEquality().equals(other.hoge, hoge)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(hoge);

  @JsonKey(ignore: true)
  @override
  _$PurchaseStateCopyWith<_PurchaseState> get copyWith =>
      __$PurchaseStateCopyWithImpl<_PurchaseState>(this, _$identity);
}

abstract class _PurchaseState implements PurchaseState {
  const factory _PurchaseState({String? hoge}) = _$_PurchaseState;

  @override
  String? get hoge => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PurchaseStateCopyWith<_PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}
