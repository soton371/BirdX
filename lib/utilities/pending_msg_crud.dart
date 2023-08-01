import 'package:birdx/database/database_helper.dart';
import 'package:birdx/models/pending_msg_mod.dart';

Future<List<PendingMsgModel>> getPendingMsgs() async {
  List<PendingMsgModel> contactList = await DatabaseHelper.instance.getPendingMsg();
  return contactList;
}

Future<int> addPendingMsg(
    {required String name,
    required String number,
    required String message,
    required String duration,
    required String time,
    required String statusIs
    }) async {
  
  PendingMsgModel newPendingMsg = PendingMsgModel(
    name: name,
    number: number,
    message: message,
    durationInSec: duration,
    time: time,
    statusIs: statusIs
  );
  int result = await DatabaseHelper.instance.insertPendingMsg(newPendingMsg);
  return result;
}

Future<int> updatePendingMsg(
    {required PendingMsgModel pendingMsgModel,
    required String newName,
    required String newNumber,
    required String newMessage,
    required String newDuration,
    required String newTime,
    required String newStatusIs,
    }) async {
  PendingMsgModel updatedPendingMsg = PendingMsgModel(
    id: pendingMsgModel.id,
    name: newName.isNotEmpty ? newName : pendingMsgModel.name,
    number: newNumber.isNotEmpty ? newNumber : pendingMsgModel.number,
    message: newMessage.isNotEmpty ? newMessage : pendingMsgModel.message,
    durationInSec: newDuration.isNotEmpty ? newDuration : pendingMsgModel.durationInSec,
    time: newTime.isNotEmpty ? newTime : pendingMsgModel.time,
    statusIs: newStatusIs.isNotEmpty ? newStatusIs : pendingMsgModel.statusIs,
  );
  int result = await DatabaseHelper.instance.updatePendingMsg(updatedPendingMsg);

  return result;
}

Future<int> deletePendingMsg(PendingMsgModel pendingMsgModel) async {
  int result = await DatabaseHelper.instance.deletePending(pendingMsgModel.id!);
  return result;
}
