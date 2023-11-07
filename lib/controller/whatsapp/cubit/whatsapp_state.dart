part of 'whatsapp_cubit.dart';

enum WhatsappStatus {
  initial,
  loading,
  error,
  success,
  notLinked,
  linked,
  sending,
  sendingSuccess,
  sendingFailure,
  uploadingFile,
  uploadingFileSuccess,
  unLinkingSuccess,
  pickingLocation,
  pickingLocationSuccess
}

@immutable
class WhatsappState {
  final WhatsappStatus status;
  final String tag;
  final List<WhatsappChatModel> chats;
  final String qr;
  final Map<String, bool> selectedChats;

  final bool selectAll;
  final bool selectOnlyChats;
  final bool selectOnlyGroups;

  final TextEditingController messageController;
  final TextEditingController linkController;
  final String? url;
  final Location? location;

  const WhatsappState._({
    required this.status,
    required this.tag,
    required this.chats,
    required this.qr,
    required this.selectedChats,
    required this.selectAll,
    required this.selectOnlyChats,
    required this.selectOnlyGroups,
    required this.messageController,
    required this.linkController,
    required this.url,
    required this.location,
  });

  WhatsappState.init(this.tag)
      : status = WhatsappStatus.initial,
        chats = [],
        selectedChats = {},
        qr = '',
        selectAll = false,
        selectOnlyChats = false,
        selectOnlyGroups = false,
        messageController = TextEditingController(),
        linkController = TextEditingController(),
        url = null,
        location = null;

  List<WhatsappChatModel> get onlyChats =>
      chats.where((e) => !e.isGroup!).toList();

  List<WhatsappChatModel> get onlyGroups =>
      chats.where((e) => e.isGroup!).toList();

  int get selectedChatsCount => selectedChats.values.where((e) => e).length;

  bool isSelected(String id) {
    return selectedChats[id] ?? false;
  }

  WhatsappState copyWith({
    WhatsappStatus? status,
    List<WhatsappChatModel>? chats,
    Map<String, bool>? selectedChats,
    String? qr,
    bool? selectAll,
    bool? selectOnlyChats,
    bool? selectOnlyGroups,
    String? url,
    Location? location,
  }) {
    return WhatsappState._(
      tag: tag,
      status: status ?? this.status,
      chats: chats ?? this.chats,
      selectedChats: selectedChats ?? this.selectedChats,
      qr: qr ?? this.qr,
      selectAll: selectAll ?? this.selectAll,
      selectOnlyChats: selectOnlyChats ?? this.selectOnlyChats,
      selectOnlyGroups: selectOnlyGroups ?? this.selectOnlyGroups,
      url: url ?? this.url,
      location: location ?? this.location,
      messageController: messageController,
      linkController: linkController,
    );
  }

  WhatsappState removeLocation() {
    return WhatsappState._(
      location: null,
      tag: tag,
      status: status,
      chats: chats,
      selectedChats: selectedChats,
      qr: qr,
      selectAll: selectAll,
      selectOnlyChats: selectOnlyChats,
      selectOnlyGroups: selectOnlyGroups,
      url: url,
      messageController: messageController,
      linkController: linkController,
    );
  }

  WhatsappState removeFile() {
    return WhatsappState._(
      url: null,
      location: location,
      tag: tag,
      status: status,
      chats: chats,
      selectedChats: selectedChats,
      qr: qr,
      selectAll: selectAll,
      selectOnlyChats: selectOnlyChats,
      selectOnlyGroups: selectOnlyGroups,
      messageController: messageController,
      linkController: linkController,
    );
  }
}
