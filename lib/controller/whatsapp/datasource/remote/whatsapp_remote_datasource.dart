import 'package:whatsapp_marketing/controller/whatsapp/model/qr_model.dart';
import 'package:whatsapp_marketing/controller/whatsapp/model/whatsapp_chat_model.dart';
import 'package:whatsapp_marketing/controller/whatsapp/params/send_message_params.dart';

abstract class WhatsappRemoteDataSource {
  Future<QrModel> getQR(String id);
  Future<List<WhatsappChatModel>> getChats(String id);

  Future sendMessage(String id, SendMessageParams params);

  Future unlinkAccount(String id);
}
