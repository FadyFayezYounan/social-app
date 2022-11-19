import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgIcon {
  ArrowLeftCircle,
  CloseSquare,
  TickSquare,
  Category,
  InfoSquare,
  Show,
  Hide,
  Facebook,
  Google,
  Home,
  Search,
  HeartFilled,
  Plus,
  Heart2,
  MoreSquare,
  Bookmark,
  Image,
  Camera,
  Profile,
  Comment,
  Notification,
  Delete,
  EditSquare,
  Send,
  Message,
  PaperPlus,
  Chat,
}

class MyIcon extends StatelessWidget {
  final SvgIcon svgIcon;
  final Color color;
  final double size;

  const MyIcon({
    Key? key,
    required this.svgIcon,
    this.color: Colors.black54,
    this.size: 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final String iconName;
    switch (svgIcon) {
      case SvgIcon.ArrowLeftCircle:
        iconName = 'Arrow - Left Circle';
        break;
      case SvgIcon.CloseSquare:
        iconName = 'Close Square';
        break;
      case SvgIcon.TickSquare:
        iconName = 'Tick Square';
        break;
      case SvgIcon.Category:
        iconName = 'Category';
        break;
      case SvgIcon.InfoSquare:
        iconName = 'Info Square';
        break;
      case SvgIcon.Show:
        iconName = 'Show';
        break;
      case SvgIcon.Hide:
        iconName = 'Hide';
        break;
      case SvgIcon.Facebook:
        iconName = 'Facebook';
        break;
      case SvgIcon.Google:
        iconName = 'Google';
        break;
      case SvgIcon.Home:
        iconName = 'Home';
        break;
      case SvgIcon.Search:
        iconName = 'Search2';
        break;
      case SvgIcon.Plus:
        iconName = 'Plus';
        break;
      case SvgIcon.Heart2:
        iconName = 'Heart2';
        break;
      case SvgIcon.MoreSquare:
        iconName = 'More Square';
        break;
      case SvgIcon.Bookmark:
        iconName = 'Bookmark';
        break;
      case SvgIcon.Image:
        iconName = 'Image';
        break;
      case SvgIcon.Camera:
        iconName = 'Camera';
        break;
      case SvgIcon.Profile:
        iconName = 'Profile';
        break;
      case SvgIcon.HeartFilled:
        iconName = 'Heart_filled';
        break;
      case SvgIcon.Comment:
        iconName = 'Comment';
        break;
      case SvgIcon.Notification:
        iconName = 'Notification';
        break;
      case SvgIcon.Delete:
        iconName = 'Delete';
        break;
      case SvgIcon.EditSquare:
        iconName = 'Edit Square';
        break;
      case SvgIcon.Send:
        iconName = 'Send';
        break;
      case SvgIcon.Message:
        iconName = 'Message';
        break;
      case SvgIcon.PaperPlus:
        iconName = 'Paper Plus';
        break;
      case SvgIcon.Chat:
        iconName = 'Chat';
        break;
    }
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      color: color,
      width: size,
      height: size,
    );
  }
}
