import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = 'YOUR_APP_ID'; // Replace this with your Agora App ID

class VideoCallScreen extends StatefulWidget {
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late RtcEngine _engine;
  bool _joined = false;
  bool _muted = false;
  bool _switchedCamera = false;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();

    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    await _engine.enableVideo();

    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        setState(() {
          _joined = true;
        });
      },
      userJoined: (int uid, int elapsed) {
        setState(() {
          _remoteUid = uid;
        });
      },
      userOffline: (int uid, UserOfflineReason reason) {
        setState(() {
          _remoteUid = 0;
        });
      },
    ));

    await _engine.joinChannel(null, 'test', null, 0);
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  void toggleMute() {
    _engine.muteLocalAudioStream(!_muted);
    setState(() {
      _muted = !_muted;
    });
  }

  void toggleCamera() {
    _engine.switchCamera();
    setState(() {
      _switchedCamera = !_switchedCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_joined)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: RtcLocalView.SurfaceView(
                          uid: 0,
                          channelId: 'test',
                          renderMode: VideoRenderMode.Hidden,
                        ),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: _remoteUid != 0
                            ? RtcRemoteView.SurfaceView(
                                uid: _remoteUid,
                                channelId: 'test',
                                renderMode: VideoRenderMode.Hidden,
                              )
                            : Text('Waiting for remote user...'),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: toggleMute,
                  child: Text(_muted ? 'Unmute' : 'Mute'),
                ),
                ElevatedButton(
                  onPressed: toggleCamera,
                  child: Text(
                      _switchedCamera ? 'Switch to Front' : 'Switch to Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _engine.leaveChannel();
                    Navigator.pop(context);
                  },
                  child: Text('End Call'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
