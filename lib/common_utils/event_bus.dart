import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

///首页数据刷新
class ClueListRefreshEvent {
  ClueListRefreshEvent();
}

///客户详情刷新
class ClueDetailRefreshEvent {
  ClueDetailRefreshEvent();
}

///线索跟进记录刷新
class ClueFollowRefreshEvent {
  ClueFollowRefreshEvent();
}
