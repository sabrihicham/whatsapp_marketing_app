import 'whatsapp_remote_datasource.dart';
import '../../model/qr_model.dart';
import '../../model/whatsapp_chat_model.dart';
import '../../params/send_message_params.dart';
import '../../../../core/datasource/base_remote_datasource.dart';
import '../../../../util/constants/links.dart';

class WhatsappRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements WhatsappRemoteDataSource {
  final String getQREndPoint = '${AppLinks.baseUrl}/whatsapp/getQR';
  final String getChatsEndPoint = '${AppLinks.baseUrl}/whatsapp/getChats';
  final String getStatusEndPoint = '${AppLinks.baseUrl}/whatsapp/getStatus';
  final String sendMessageEndPoint = '${AppLinks.baseUrl}/whatsapp/sendMessage';
  final String unLinkEndPoint = '${AppLinks.baseUrl}/whatsapp/unLinkAccount';

  WhatsappRemoteDataSourceImpl({required super.dio});

  @override
  Future<QrModel> getQR(String id) {
    final res = get(
      url: '$getQREndPoint/$id',
      decoder: (json) {
        return QrModel.fromJson(json);
      },
      requiredToken: false,
    );
    
    return res;
  }

  @override
  Future<List<WhatsappChatModel>> getChats(String id) {
    final res = get(
      url: '$getChatsEndPoint/$id',
      decoder: (json) {
        return (json['chats'] as List).map<WhatsappChatModel>((e) => WhatsappChatModel.fromJson(e)).toList();
      },
      requiredToken: false,
    );
    return res;
  }

  @override
  Future sendMessage(String id, SendMessageParams params) {
    final res = post(
      url: '$sendMessageEndPoint/$id',
      body: params.toJson(),
      decoder: (json) {
        return true;
      },
      requiredToken: false,
    );
    return res;
  }
  
  Future getStatus(String id) async {
    final res = get(
      url: '$getStatusEndPoint/$id',
      decoder: (json) {
        return json;
      },
      requiredToken: false,
    );

    return res;
  }

  @override
  Future unlinkAccount(String id) {
    final res = get(
      url: '$unLinkEndPoint/$id',
      decoder: (json) {
        return true;
      },
      requiredToken: false,
    );
    return res;
  }
}
