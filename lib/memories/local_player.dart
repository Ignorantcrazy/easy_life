import 'abstract_palyer.dart';
import 'package:video_player/video_player.dart';

class LocalPlayerLifeCycle extends PlayerLifeCycle {
  LocalPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);
  @override
  _LocalPlayerLifeCycleState createState() => _LocalPlayerLifeCycleState();
}

class _LocalPlayerLifeCycleState extends PalyerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
      return VideoPlayerController.network(widget.dataSource);
    }
}
