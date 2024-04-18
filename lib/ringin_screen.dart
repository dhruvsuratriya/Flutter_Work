import 'package:flutter/material.dart';

enum CallState { idle, ringing, accepted, connected, ended }

class VideoCallScreen extends StatefulWidget {
  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  CallState callState = CallState.idle;

  void startCall() {
    setState(() {
      callState = CallState.ringing;
    });
  }

  void acceptCall() {
    setState(() {
      callState = CallState.accepted;
    });
  }

  void endCall() {
    setState(() {
      callState = CallState.ended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Call')),
      body: Center(
        child: callState == CallState.ringing
            ? RingingScreen(acceptCall, endCall)
            : callState == CallState.accepted
                ? ReceiverScreen(endCall)
                : CallInitiationScreen(startCall),
      ),
    );
  }
}

class CallInitiationScreen extends StatelessWidget {
  final Function() onCallPressed;

  CallInitiationScreen(this.onCallPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onCallPressed,
      child: Text('Call'),
    );
  }
}

class RingingScreen extends StatelessWidget {
  final Function() onAcceptPressed;
  final Function() onRejectPressed;

  RingingScreen(this.onAcceptPressed, this.onRejectPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Incoming Call'),
        ElevatedButton(
          onPressed: onAcceptPressed,
          child: Text('Accept'),
        ),
        ElevatedButton(
          onPressed: onRejectPressed,
          child: Text('Reject'),
        ),
      ],
    );
  }
}

class ReceiverScreen extends StatelessWidget {
  final Function() onEndCall;

  ReceiverScreen(this.onEndCall);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('In Call'),
        // Add video streaming widget here
        ElevatedButton(
          onPressed: onEndCall,
          child: Text('End Call'),
        ),
      ],
    );
  }
}
