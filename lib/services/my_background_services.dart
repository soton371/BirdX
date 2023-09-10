import 'dart:ui';
import 'dart:async';
import 'package:birdx/models/pending_msg_mod.dart';
import 'package:birdx/utilities/pending_msg_crud.dart';
import 'package:birdx/utilities/time_to_seconds.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:telephony/telephony.dart';

class MyBackgroundServices {
  final service = FlutterBackgroundService();

  Future<void> startBackgroundTask() async {
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'PARROT SERVICE',
        initialNotificationContent: 'Waiting to send message',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(),
    );
    service.startService();
  }

  void stopBackgroundTask() async {
    service.invoke("stopService");
  }
}

//out of the class
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  getPendingMsgs().then((value) {
    if (value.isEmpty) {
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
      return;
    }
    List<PendingMsgModel> pendingMsgs = [];
    for (var data in value) {
      DateTime fetchDT = DateTime.parse(data.dateTime);
      if (data.statusIs == "0" && fetchDT.isAfter(DateTime.now())) {
        pendingMsgs.add(data);
      } else if (data.statusIs == "0" && !fetchDT.isAfter(DateTime.now())) {
        updatePendingMsg(
            pendingMsgModel: data,
            newName: data.name,
            newNumber: data.number,
            newMessage: data.message,
            newDuration: data.durationInSec,
            newTime: data.time,
            newStatusIs: "3",
            newDateTime: data.dateTime);
      }
    }
    final Telephony _telephony = Telephony.instance;
    if (pendingMsgs.isNotEmpty) {
      for (var element in pendingMsgs) {
        DateTime fetchDT = DateTime.parse(element.dateTime);
        String differenceTime = fetchDT.difference(DateTime.now()).toString();
        int durationInSec = timeToSeconds(differenceTime);
        Future.delayed(
          Duration(seconds: durationInSec),
          () {
            _telephony.sendSms(to: element.number, message: element.message);
            // MyNotificationServices().showLocalNotification(title: "Sent", body: element.message);
            updatePendingMsg(
                pendingMsgModel: element,
                newName: element.name,
                newNumber: element.number,
                newMessage: element.message,
                newDuration: element.durationInSec,
                newTime: element.time,
                newStatusIs: "1",
                newDateTime: element.dateTime);
          },
        );
      }
    } else {
      service.on('stopService').listen((event) {
        service.stopSelf();
      });
    }
  });
}
