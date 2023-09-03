import 'package:flutter/material.dart';
import '../error/failure_response.dart';
import 'package:equatable/equatable.dart';

enum ViewState { initial, loading, error, hasData, noData }

extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;

  bool get isInitial => this == ViewState.initial;

  bool get isError => this == ViewState.error;

  bool get isHasData => this == ViewState.hasData;

  bool get isNoData => this == ViewState.noData;
}

class ViewData<T> extends Equatable {
  final ViewState status;
  final T? data;
  final String message;
  final FailureResponse? failure;

  const ViewData._({
    required this.status,
    this.data,
    this.message = "",
    this.failure,
  });

  factory ViewData.loaded({T? data}) {
    return ViewData._(status: ViewState.hasData, data: data);
  }

  factory ViewData.error({
    required String message,
    required FailureResponse? failure,
  }) {
    return ViewData._(
      status: ViewState.error,
      message: message,
      failure: failure,
    );
  }

  factory ViewData.loading({String? message}) {
    return ViewData._(status: ViewState.loading, message: message ?? "");
  }

  factory ViewData.initial() {
    return const ViewData._(status: ViewState.initial);
  }

  factory ViewData.noData({required String message}) {
    return ViewData._(status: ViewState.noData, message: message);
  }

  @override
  List<Object?> get props => [
        status,
        data,
        message,
        failure,
      ];
}

typedef NotifierBuilder<T> = Widget Function(T data);

extension ObservingState<T> on ViewData<T> {
  Widget observe(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    if (status.isLoading) {
      return onLoading ?? const Center(child: CircularProgressIndicator());
    } else if (status.isError) {
      return onError != null
          ? onError(failure!.errorMessage)
          : Center(child: Text(failure!.errorMessage));
    } else if (status.isHasData) {
      if (status.isNoData) {
        return onEmpty ?? const SizedBox();
      } else {
        return widget(data);
      }
    } else {
      return const SizedBox();
    }
  }
}
