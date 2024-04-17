import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart'
    as refresh;
import 'package:refresh_paging_listview/refresh_paging_listview.dart';

/// global default empty builder
typedef EmptyBuilder = Widget Function(EmptyConfig?);

/// Controls how SmartRefresher widgets behave in a subtree.the usage just like [ScrollConfiguration]
///
/// The refresh configuration determines smartRefresher some behaviours,global setting default indicator
///
/// see also:
/// * [refresh.RefreshConfiguration]
/// * [SmartRefresher], a widget help attach the refresh and load more function
class RefreshConfiguration extends refresh.RefreshConfiguration {
  final EmptyConfig? emptyConfig;
  final int initPage;
  final EmptyBuilder? emptyBuilder;

  RefreshConfiguration({
    super.key,
    required Widget child,
    super.headerBuilder,
    super.footerBuilder,
    super.dragSpeedRatio = 1.0,
    super.shouldFooterFollowWhenNotFull,
    super.enableScrollWhenTwoLevel = true,
    super.enableLoadingWhenNoData = false,
    super.enableBallisticRefresh = false,
    super.springDescription = const SpringDescription(
      mass: 2.2,
      stiffness: 150,
      damping: 16,
    ),
    super.enableScrollWhenRefreshCompleted = false,
    super.enableLoadingWhenFailed = true,
    super.twiceTriggerDistance = 150.0,
    super.closeTwoLevelDistance = 80.0,
    super.skipCanRefresh = false,
    super.maxOverScrollExtent,
    super.enableBallisticLoad = true,
    super.maxUnderScrollExtent,
    super.headerTriggerDistance = 80.0,
    super.footerTriggerDistance = 15.0,
    super.hideFooterWhenNotFull = false,
    super.enableRefreshVibrate = false,
    super.enableLoadMoreVibrate = false,
    super.topHitBoundary,
    super.bottomHitBoundary,
    this.emptyConfig,
    this.initPage = 1,
    this.emptyBuilder,
  }) : super(
          child: refresh.RefreshConfiguration(
            key: key,
            headerBuilder: headerBuilder,
            footerBuilder: footerBuilder,
            dragSpeedRatio: dragSpeedRatio,
            shouldFooterFollowWhenNotFull: shouldFooterFollowWhenNotFull,
            enableScrollWhenTwoLevel: enableScrollWhenTwoLevel,
            enableLoadingWhenNoData: enableLoadingWhenNoData,
            enableBallisticRefresh: enableBallisticRefresh,
            springDescription: springDescription,
            enableScrollWhenRefreshCompleted: enableScrollWhenRefreshCompleted,
            enableLoadingWhenFailed: enableLoadingWhenFailed,
            twiceTriggerDistance: twiceTriggerDistance,
            closeTwoLevelDistance: closeTwoLevelDistance,
            skipCanRefresh: skipCanRefresh,
            maxOverScrollExtent: maxOverScrollExtent,
            enableBallisticLoad: enableBallisticLoad,
            maxUnderScrollExtent: maxUnderScrollExtent,
            headerTriggerDistance: headerTriggerDistance,
            footerTriggerDistance: footerTriggerDistance,
            hideFooterWhenNotFull: hideFooterWhenNotFull,
            enableRefreshVibrate: enableRefreshVibrate,
            enableLoadMoreVibrate: enableLoadMoreVibrate,
            topHitBoundary: topHitBoundary,
            bottomHitBoundary: bottomHitBoundary,
            child: child,
          ),
        );

  RefreshConfiguration copyOf({
    required Widget child,
    IndicatorBuilder? headerBuilder,
    IndicatorBuilder? footerBuilder,
    double? dragSpeedRatio,
    ShouldFollowContent? shouldFooterFollowWhenNotFull,
    bool? enableScrollWhenTwoLevel,
    bool? enableBallisticRefresh,
    bool? enableBallisticLoad,
    bool? enableLoadingWhenNoData,
    SpringDescription? springDescription,
    bool? enableScrollWhenRefreshCompleted,
    bool? enableLoadingWhenFailed,
    double? twiceTriggerDistance,
    double? closeTwoLevelDistance,
    bool? skipCanRefresh,
    double? maxOverScrollExtent,
    double? maxUnderScrollExtent,
    double? topHitBoundary,
    double? bottomHitBoundary,
    double? headerTriggerDistance,
    double? footerTriggerDistance,
    bool? enableRefreshVibrate,
    bool? enableLoadMoreVibrate,
    bool? hideFooterWhenNotFull,
    EmptyConfig? emptyConfig,
    int? initPage,
    EmptyBuilder? emptyBuilder,
  }) {
    return RefreshConfiguration(
      headerBuilder: headerBuilder ?? this.headerBuilder,
      footerBuilder: footerBuilder ?? this.footerBuilder,
      dragSpeedRatio: dragSpeedRatio ?? this.dragSpeedRatio,
      shouldFooterFollowWhenNotFull:
          shouldFooterFollowWhenNotFull ?? this.shouldFooterFollowWhenNotFull,
      enableScrollWhenTwoLevel:
          enableScrollWhenTwoLevel ?? this.enableScrollWhenTwoLevel,
      enableLoadingWhenNoData:
          enableLoadingWhenNoData ?? this.enableLoadingWhenNoData,
      enableBallisticRefresh:
          enableBallisticRefresh ?? this.enableBallisticRefresh,
      springDescription: springDescription ?? this.springDescription,
      enableScrollWhenRefreshCompleted: enableScrollWhenRefreshCompleted ??
          this.enableScrollWhenRefreshCompleted,
      enableLoadingWhenFailed:
          enableLoadingWhenFailed ?? this.enableLoadingWhenFailed,
      twiceTriggerDistance: twiceTriggerDistance ?? this.twiceTriggerDistance,
      closeTwoLevelDistance:
          closeTwoLevelDistance ?? this.closeTwoLevelDistance,
      skipCanRefresh: skipCanRefresh ?? this.skipCanRefresh,
      maxOverScrollExtent: maxOverScrollExtent ?? this.maxOverScrollExtent,
      enableBallisticLoad: enableBallisticLoad ?? this.enableBallisticLoad,
      maxUnderScrollExtent: maxUnderScrollExtent ?? this.maxUnderScrollExtent,
      headerTriggerDistance:
          headerTriggerDistance ?? this.headerTriggerDistance,
      footerTriggerDistance:
          footerTriggerDistance ?? this.footerTriggerDistance,
      hideFooterWhenNotFull:
          hideFooterWhenNotFull ?? this.hideFooterWhenNotFull,
      enableRefreshVibrate: enableRefreshVibrate ?? this.enableRefreshVibrate,
      enableLoadMoreVibrate:
          enableLoadMoreVibrate ?? this.enableLoadMoreVibrate,
      topHitBoundary: topHitBoundary ?? this.topHitBoundary,
      bottomHitBoundary: bottomHitBoundary ?? this.bottomHitBoundary,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(RefreshConfiguration oldWidget) {
    return emptyConfig != oldWidget.emptyConfig ||
        emptyBuilder != oldWidget.emptyBuilder ||
        initPage != oldWidget.initPage ||
        super.updateShouldNotify(oldWidget);
  }

  static RefreshConfiguration? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RefreshConfiguration>();
  }
}
