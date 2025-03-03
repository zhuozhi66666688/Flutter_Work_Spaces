import 'package:bubble/bubble.dart';
import 'package:chat_message/util/wechat_date_format.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

typedef MessageWidgetBuilder = Widget Function(MessageModel message);
typedef OnBubbleClick = void Function(
    MessageModel message, BuildContext ancestor);

class DefaultMessageWidget extends StatelessWidget {
  final MessageModel message;

  /// the font-family of the [content].
  final String? fontFamily;

  /// the font-size of the [content].
  final double fontSize;

  /// the size of the [avatar].
  final double avatarSize;

  /// the text-color of the [content].
  final Color? textColor;

  /// Background color of the message
  final Color? backgroundColor;
  final MessageWidgetBuilder? messageWidget;
  final OnBubbleClick? onBubbleTap;
  final OnBubbleClick? onBubbleLongPress;

  const DefaultMessageWidget(
      {required GlobalKey key,
      required this.message,
      this.fontFamily,
      this.fontSize = 16.0,
      this.textColor,
      this.backgroundColor,
      this.avatarSize = 40,
      this.messageWidget,
      this.onBubbleTap,
      this.onBubbleLongPress})
      : super(key: key);

  double get contentMargin => avatarSize + 10;

  String get senderInitials {
    if (message.ownerName == null) return "";
    List<String> chars = message.ownerName!.split(" ");
    if (chars.length > 1) {
      return chars[0];
    } else {
      return message.ownerName![0];
    }
  }

  Widget get _buildCircleAvatar {
    var child = message.avatar is String
        ? ClipOval(
            child: Image.network(
              message.avatar!,
              height: avatarSize,
              width: avatarSize,
            ),
          )
        : CircleAvatar(
            radius: 20,
            child: Text(
              senderInitials,
              style: const TextStyle(fontSize: 16),
            ));
    return child;
  }

  @override
  Widget build(BuildContext context) {
    if (messageWidget != null) return messageWidget!(message);
    Widget content = message.ownerType == OwnerType.receiver
        ? _buildReceiver(context)
        : _buildSender(context);
    return Column(
      children: [
        if (message.showCreatedTime) _buildCreatedTime(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: content,
        ),
      ],
    );
  }

  Widget _buildReceiver(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCircleAvatar,
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(10, 0, contentMargin, 0),
              stick: true,
              nip: BubbleNip.leftTop,
              color: backgroundColor ?? const Color.fromRGBO(233, 232, 252, 10),
              alignment: Alignment.topLeft,
              child: _buildContentText(TextAlign.left, context)),
        ),
      ],
    );
  }

  Widget _buildSender(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(contentMargin, 0, 10, 0),
              stick: true,
              nip: BubbleNip.rightTop,
              color: backgroundColor ?? Colors.white,
              alignment: Alignment.topRight,
              child: _buildContentText(TextAlign.left, context)),
        ),
        _buildCircleAvatar
      ],
    );
  }

  Widget _buildContentText(TextAlign align, BuildContext context) {
    return InkWell(
      onTap: () => onBubbleTap != null ? onBubbleTap!(message, context) : null,
      onLongPress: () => onBubbleLongPress != null
          ? onBubbleLongPress!(message, context)
          : null,
      child: Text(
        message.content,
        textAlign: align,
        style: TextStyle(
            fontSize: fontSize,
            color: textColor ?? Colors.black,
            fontFamily: fontFamily),
      ),
    );
  }

  _buildCreatedTime() {
    String showT = WechatDateFormat.format(message.createdAt, dayOnly: false);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Text(showT),
    );
  }
}
