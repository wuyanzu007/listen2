import 'dart:async';
import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:listen2/api/abstract_platform.dart';
import 'package:listen2/common/enums.dart';
import 'package:listen2/models/music_model.dart';

class PlayMusicsProvider with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _currentPositionController =
      StreamController<String>.broadcast();

  //用户添加的歌曲列表,按照加入的顺序排列
  List<MusicModel> _musicList = [];

  //播放器真实播放顺序列表
  Queue<MusicModel> _playQueue = new Queue();

  PlayModelEnum _playModel; //播放模式

  //播放器当前状态
  AudioPlayerState _currentState;

  //歌曲时长
  Duration currentMusicDuration;

  //文件流
  Stream<String> get currentPositionStream => _currentPositionController.stream;

  //播放器当前状态
  AudioPlayerState get currentState => _currentState;

  //当前歌曲
  MusicModel get currentMusic => _playQueue.first;

  MusicModel get preMusic => _playQueue.last;

  MusicModel get nextMusic =>
      _playQueue.length > 1 ? _playQueue.elementAt(1) : _playQueue.first;

  List<MusicModel> get musicList => _musicList;

  Queue<MusicModel> get playQueue => _playQueue;

  void init() {
    _playModel = PlayModelEnum.ORDER;
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _currentState = state;
      if (state == AudioPlayerState.COMPLETED) {
        nextPlay();
      }
      notifyListeners();
    });
    _audioPlayer.onDurationChanged.listen((duration) {
      currentMusicDuration = duration;
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration position) {
      sinkProgress(position.inMilliseconds > currentMusicDuration.inMilliseconds
          ? currentMusicDuration.inMilliseconds
          : position.inMilliseconds);
    });
  }

  //添加音乐到列表
  void addMusic(MusicModel musicModel) {
    stop();
    _musicList.remove(musicModel);
    _musicList.insert(0, musicModel);
    _playQueue.remove(musicModel);
    _playQueue.addFirst(musicModel);
    play();
  }

  //添加多个音乐
  void addMusics(List<MusicModel> musicList) {
    stop();
    this._musicList = musicList;
    _playQueue.clear();
    switch (_playModel) {
      case PlayModelEnum.ORDER:
        //顺序播放
        _playQueue.addAll(musicList);
        break;
      case PlayModelEnum.RANDOM:
        //随机播放
        musicList.shuffle();
        _playQueue.addAll(musicList);
        break;
      case PlayModelEnum.SINGLE_CYCLE:
        //单曲循环
        _playQueue.addFirst(musicList.first);
        break;
    }
    play();
  }

  // 播放
  void play() {
    // 播放列表为空
    if (_playQueue.isEmpty) {
      Fluttertoast.showToast(
          msg: "播放列表为空，先去添加音乐吧~", gravity: ToastGravity.BOTTOM);
    }
    // 列表中歌曲未获取播放地址
    if (_playQueue.first.playUrl == null) {
      getData(_playQueue.first).then((MusicModel musicModel) async {
        _playQueue.first.picUrl = musicModel.picUrl;
        _playQueue.first.playUrl = musicModel.playUrl;
        _playQueue.first.platform = musicModel.platform;
        if (_playQueue.first.playUrl == null ||
            _playQueue.first.playUrl == "") {
          _musicList.remove(_playQueue.first);
          return nextPlay();
        } else {
          _audioPlayer.play(_playQueue.first.playUrl);
        }
      });
    } else {
      _audioPlayer.play(_playQueue.first.playUrl);
    }
  }

  Future<MusicModel> getData(MusicModel musicModel) async {
    var platformApi = AbstractPlatform.getPlatform(musicModel.platform);
    MusicModel musicDetail =
        await platformApi.getMusicDetail(param: musicModel);
    return musicDetail;
  }

  // 播放指定位置的音乐
  void playIndex(int index) {
    stop();
    _playQueue.remove(_musicList[index]);
    _playQueue.addFirst(_musicList[index]);
    play();
  }

  // 移除音乐
  void removeMusic(int index) {
    musicList.removeAt(index);
    _playQueue.remove(_musicList[index]);
  }

  //移除全部
  void removeAll() {
    stop();
    musicList.clear();
    _playQueue.clear();
  }

  // 下一首
  void nextPlay() {
    stop();
    var first = _playQueue.removeFirst();
    _playQueue.addLast(first);
    play();
  }

  //上一首
  void prePlay() {
    stop();
    var last = _playQueue.removeLast();
    _playQueue.addFirst(last);
    play();
  }

  //暂停,播放
  void togglePlay() {
    if (currentState == AudioPlayerState.PLAYING) {
      pausePlay();
    } else if (currentState == AudioPlayerState.PAUSED) {
      resumePlay();
    } else {
      play();
    }
  }

  void stop() {
    _audioPlayer.stop();
  }

  // 暂停
  void pausePlay() {
    _audioPlayer.pause();
  }

  // 恢复播放
  void resumePlay() {
    _audioPlayer.resume();
  }

  @override
  void dispose() {
    super.dispose();
    _musicList.clear();
    _playQueue.clear();
    _currentPositionController.close();
    _audioPlayer.dispose();
  }

  //跳转进度
  void sinkProgress(int m) {
    _currentPositionController.sink
        .add("$m-${currentMusicDuration.inMilliseconds}");
  }

  //跳转到指定时间
  void seekPlay(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    _audioPlayer.resume();
  }
}
