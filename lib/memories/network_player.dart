import 'abstract_palyer.dart';
import 'package:video_player/video_player.dart';

class NetworkPlayerLifeCycle extends PlayerLifeCycle {
  NetworkPlayerLifeCycle(String dataSource, VideoWidgetBuilder childBuilder)
      : super(dataSource, childBuilder);
  @override
  _NetworkPlayerLifeCycleState createState() => _NetworkPlayerLifeCycleState();
}

class _NetworkPlayerLifeCycleState extends PalyerLifeCycleState {
  @override
  VideoPlayerController createVideoPlayerController() {
      return VideoPlayerController.network(widget.dataSource);
    }
}
