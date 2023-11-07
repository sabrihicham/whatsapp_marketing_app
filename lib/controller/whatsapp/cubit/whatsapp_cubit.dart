import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_marketing/controller/whatsapp/datasource/remote/whatsapp_remote_datasource_impl.dart';
import 'package:whatsapp_marketing/controller/whatsapp/model/qr_model.dart';
import 'package:whatsapp_marketing/controller/whatsapp/model/whatsapp_chat_model.dart';
import 'package:whatsapp_marketing/controller/whatsapp/params/send_message_params.dart';
import 'package:whatsapp_marketing/util/firebase_methods/firebase_auth_methods.dart';
import 'package:whatsapp_marketing/util/helper/get_location.dart';

part 'whatsapp_state.dart';

class WhatsappCubit extends Cubit<WhatsappState> {
  WhatsappCubit(String tag) : super(WhatsappState.init(tag));

  final WhatsappRemoteDataSourceImpl _dataSource =
      WhatsappRemoteDataSourceImpl(dio: Dio());

  late SharedPreferences prefs;


  Future isLinked({int depth = 1}) async {
    if (depth > 3) {
      emit(state.copyWith(status: WhatsappStatus.error));
      return;
    }    

    emit(state.copyWith(status: WhatsappStatus.loading));
    try {
      prefs = await SharedPreferences.getInstance();

      String? qr = prefs.getString('whatsapp_qr_${state.tag}');

      //check if user already link his whatsapp account
      if (null == qr) {
        getQR(depth: depth + 1);
        return;
      }

      dynamic status;
      int retry = 0;
      
      do {
        try {
          status = await _dataSource.getStatus(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);
        } catch (e) {
          retry++;
        }
      } while (status == null && retry < 3);
      

      if (status != 'CONNECTED') {
        await prefs.remove('whatsapp_qr_${state.tag}');
        await _dataSource.unlinkAccount(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);
        isLinked(); 
        return;
      }

      var chats = await _getChats();

      emit(state.copyWith(status: WhatsappStatus.linked, qr: qr, chats: chats));
    } catch (e, s) {
      if (e.toString().contains('403')) {
        unlinkAccount(localOnly: true);
        return;
      }
      log(s.toString());
      emit(state.copyWith(status: WhatsappStatus.error));
    }
  }

  Future<QrModel> _getQRFromRemote() async {
    QrModel qrModel = await _dataSource
        .getQR(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);

    return qrModel;
  }

  Future<void> getQR({int depth = 1}) async {
    emit(state.copyWith(status: WhatsappStatus.loading));
    try {
      QrModel? qrModel;
      int retry = 0;
      
      do {
        try {
          qrModel = await _getQRFromRemote();
        } catch (e) {
          retry++;
        }
      } while (qrModel == null && retry < 3);

      if (qrModel?.isOld! == true) {
        prefs.setString('whatsapp_qr_${state.tag}', state.qr);
        isLinked(depth: depth + 1);
        return;
      }

      emit(state.copyWith(
        status: WhatsappStatus.notLinked,
        qr: qrModel?.value,
      ));
    } catch (e, s) {
      log(s.toString());
      emit(state.copyWith(status: WhatsappStatus.error));
    }
  }

  Future<void> unlinkAccount({bool localOnly = false, bool leave = true}) async {
    emit(state.copyWith(status: WhatsappStatus.loading));

    try {
      await prefs.remove('whatsapp_qr_${state.tag}');
      await _dataSource.unlinkAccount(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);
      if (leave) {
        emit(state.copyWith(status: WhatsappStatus.unLinkingSuccess));
      }
    } catch (e) {}
  }

  Future<List<WhatsappChatModel>> _getChats() async {
    return await _dataSource.getChats(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);
  }

  Future getChats() async {
    emit(state.copyWith(status: WhatsappStatus.loading));
    try {
      List<WhatsappChatModel> chats = await _dataSource
          .getChats(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);

      //if success, then save  the qr to storage
      prefs.setString('whatsapp_qr_${state.tag}', state.qr);

      emit(state.copyWith(
        status: WhatsappStatus.linked,
        chats: chats,
      ));
    } catch (e, s) {
      log(s.toString());
      emit(state.copyWith(status: WhatsappStatus.notLinked));
    }
  }

  Future submitQR() async {
    emit(state.copyWith(status: WhatsappStatus.loading));
    try {
      prefs = await SharedPreferences.getInstance();

      List<WhatsappChatModel> chats = await _dataSource
          .getChats(FirebaseAuthMethods.getCurrentUser!.uid + state.tag);

      //if success, then save  the qr to storage
      prefs.setString('whatsapp_qr_${state.tag}', state.qr);

      emit(state.copyWith(
        status: WhatsappStatus.linked,
        chats: chats,
      ));
    } catch (e, s) {
      log(s.toString());
      emit(state.copyWith(status: WhatsappStatus.notLinked));
    }
  }

  Future<void> sendMessage() async {
    emit(state.copyWith(status: WhatsappStatus.sending));

    try {
      String message = state.messageController.value.text;
      String link = state.linkController.value.text;

      if (link.isNotEmpty) {
        message = '$message\n$link';
      }

      List<String> to = state.chats
          .where((e) => state.selectedChats[e.id] ?? false)
          .map((e) => e.id!)
          .toList();

      SendMessageParams params = SendMessageParams(
        message: message,
        to: to,
        mediaUrl: state.url,
        location: state.location,
      );

      log(params.toJson().toString());

      await _dataSource.sendMessage(FirebaseAuthMethods.getCurrentUser!.uid + state.tag, params);
      
      emit(state.copyWith(status: WhatsappStatus.sendingSuccess));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: WhatsappStatus.sendingFailure));
    }
  }

  void setSelected(String id, bool value) {
    state.selectedChats[id] = value;
    emit(state.copyWith(
      selectedChats: state.selectedChats,
      selectAll: false,
      selectOnlyChats: false,
      selectOnlyGroups: false,
    ));
  }

  void selectAll(bool? value) {
    state.selectedChats.clear();

    for (var element in state.chats) {
      state.selectedChats[element.id!] = value!;
    }
    emit(state.copyWith(
      selectedChats: state.selectedChats,
      selectAll: value,
      selectOnlyChats: value,
      selectOnlyGroups: value,
    ));
  }

  void selectOnlyChats(bool? value) {
    state.selectedChats.clear();

    for (var element in state.onlyChats) {
      state.selectedChats[element.id!] = value!;
    }
    emit(state.copyWith(
      selectedChats: state.selectedChats,
      selectAll: false,
      selectOnlyChats: value,
      selectOnlyGroups: false,
    ));
  }

  void selectOnlyGroups(bool? value) {
    state.selectedChats.clear();

    for (var element in state.onlyGroups) {
      state.selectedChats[element.id!] = value!;
    }
    emit(state.copyWith(
      selectedChats: state.selectedChats,
      selectAll: false,
      selectOnlyChats: false,
      selectOnlyGroups: value,
    ));
  }

  Future<void> pickLocation() async {
    emit(state.copyWith(status: WhatsappStatus.pickingLocation));
    Position position = await determinePosition();

    emit(state.copyWith(
      status: WhatsappStatus.pickingLocationSuccess,
      location: Location(lat: position.latitude, long: position.longitude),
    ));
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        emit(state.copyWith(status: WhatsappStatus.uploadingFile));
        File file = File(result.files.single.path!);

        Reference storageReference =
            FirebaseStorage.instance.ref('/messageFiles');

        Reference ref = storageReference.child(DateTime.now().toString());

        await ref
            .putFile(file)
            .whenComplete(() => ref.getDownloadURL().then((value) {
                  emit(state.copyWith(
                      status: WhatsappStatus.uploadingFileSuccess, url: value));
                }));
      } else {
        // User canceled the picker
      }
    } catch (e) {
      //
    }
  }

  void deleteLocation() {
    var newstate = state.removeLocation();
    emit(newstate);
  }

  void deleteFile() {
    var newstate = state.removeFile();
    emit(newstate);
  }

  void deleteLocationAndFile() {
    var newstate = state.removeFile().removeLocation();
    emit(newstate);
  }

  void resetMessage() {
    var newState = state.copyWith(
      status: WhatsappStatus.linked,
      selectAll: false,
      selectOnlyChats: false,
      selectOnlyGroups: false,
      selectedChats: {},
    );
    newState.messageController.clear();
    newState.linkController.clear();
    newState.removeFile().removeLocation();

    emit(newState);
  }
}
