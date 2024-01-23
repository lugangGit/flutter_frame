import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.shadowColor,
    this.elevation,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle = true,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.showMore = false,
    this.onMoreTap,
    this.backgroundImage,
    this.backgroundUnderBottom = false,
    this.gradient,
    this.height = 44,
    this.iconColor,
    this.iconSize
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize = Size.fromHeight(height + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Brightness? brightness;
  final IconThemeData? iconTheme;
  final TextTheme? textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final Gradient? gradient;

  ///背景图
  final Widget? backgroundImage;

  ///背景是否在app+bottom之下
  final bool backgroundUnderBottom;

  ///是否展示更多按钮
  final bool showMore;
  final VoidCallback? onMoreTap;
  final double height;
  final AppColor? iconColor;
  final double? iconSize;
  @override
  final Size preferredSize;

  bool _getEffectiveCenterTitle(ThemeData themeData) {
    return centerTitle;
  }

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool get useGradient => widget.gradient != null;

  bool get useBackground => useGradient || widget.backgroundImage != null || widget.backgroundColor != null;

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }

  static Brightness estimateBrightnessForColor(Color color) {
    final double relativeLuminance = color.computeLuminance();

    const double kThreshold = 0.15;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      return Brightness.light;
    }
    return Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final Brightness brightness = widget.brightness ??
        ((useGradient || widget.backgroundImage != null)
            ? Brightness.dark
            : widget.backgroundColor!=null ? estimateBrightnessForColor(widget.backgroundColor!):Theme.of(context).brightness);
    final bool hasDrawer = scaffold.hasDrawer;
    final bool hasEndDrawer = scaffold.hasEndDrawer;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData appBarIconTheme = widget.iconTheme ?? appBarTheme.iconTheme ?? themeData.primaryIconTheme;
    TextStyle? centerStyle = useBackground
        ? TextStyle(color: AppColor.sub.of(context), fontSize: 17)
        : widget.textTheme?.headlineSmall ?? appBarTheme.titleTextStyle ?? themeData.primaryTextTheme.headlineSmall;
    TextStyle? sideStyle =
        widget.textTheme?.titleSmall ?? appBarTheme.titleTextStyle ?? themeData.primaryTextTheme.bodyLarge;

    Widget? leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop)
          leading = useCloseButton
              ? FZAppBarButton(
            icon: Icons.close,
            iconSize: widget.iconSize,
            color: widget.iconColor?.of(context)??(useBackground?Colors.white:Colors.grey),
            onTap: ()=>Navigator.of(context).pop(),
          )  : FZAppBarButton(
            icon: Icons.chevron_left,
            iconSize: widget.iconSize ?? 30,
            color: widget.iconColor?.of(context)??(useBackground?Colors.white:Colors.grey),
            onTap: ()=>Navigator.of(context).pop(),
          );
        // leading = useCloseButton
          //     ? (useBackground ? const WhiteCloseButton() : const CloseButton())
          //     : (useBackground ? const WhiteBackButton() : const XyBackButton()); //BackButton
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 56),
        child: leading,
      );
    }
    Widget? title = widget.title;
    if (title != null) {
      bool namesRoute = false;
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          namesRoute = true;
          break;
        case TargetPlatform.iOS:
          break;
        case TargetPlatform.linux:
          break;
        case TargetPlatform.macOS:
          break;
        case TargetPlatform.windows:
          break;
      }
      title = DefaultTextStyle(
        style: centerStyle ?? TextStyle(),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Semantics(
          namesRoute: namesRoute,
          child: title,
          header: true,
        ),
      );
    }

    Widget? actions;
    if (widget.actions != null && true == widget.actions?.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions!,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }
    if (actions == null && widget.showMore == true) {
      actions = FZAppBarButton(
        icon:  Icons.more_horiz,
        iconSize: widget.iconSize ?? 24,
        onTap: widget.onMoreTap,
        color: widget.iconColor?.of(context) ?? (useBackground ? Colors.white : Colors.grey),
      );
    }
    final Widget toolbar = Container(
      child:Directionality(
        textDirection: TextDirection.ltr,
        child:  NavigationToolbar(
          leading: leading,
          middle: title,
          trailing: actions,
          centerMiddle: widget._getEffectiveCenterTitle(themeData),
          middleSpacing: widget.titleSpacing,
        ),
      ),
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
        delegate: const _ToolbarContainerLayout(),
        child: IconTheme.merge(
          data: appBarIconTheme,
          child: DefaultTextStyle(
            style: sideStyle ?? TextStyle(),
            child: toolbar,
          ),
        ),
      ),
    );
    if (widget.primary) {
      appBar = SafeArea(
        top: true,
        child: appBar,
      );
    }

    appBar = Align(
      alignment: Alignment.bottomCenter,
      child: appBar,
    );

    if (widget.flexibleSpace != null) {
      appBar = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[widget.flexibleSpace!, appBar],
      );
    }

    if (!widget.backgroundUnderBottom) {
      appBar = Stack(
        children: <Widget>[
          useGradient
              ? Container(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? AppColor.primary.of(context),
                    gradient: widget.gradient,
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: widget.backgroundImage ?? SizedBox(),
          ),
          appBar,
        ],
      );
    }
    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: appBar,
          ),
          widget.bottomOpacity == 1.0
              ? widget.bottom!
              : Opacity(
                  opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn).transform(widget.bottomOpacity),
                  child: widget.bottom,
                ),
        ],
      );
    }

    if (widget.backgroundUnderBottom) {
      appBar = Stack(
        children: <Widget>[
          useGradient
              ? Container(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? AppColor.primary.of(context),
                    gradient: widget.gradient,
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: widget.backgroundImage ?? SizedBox(),
          ),
          appBar,
        ],
      );
    }
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    var isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      appBar = Opacity(child: appBar, opacity: 0.75);
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: useGradient ? Colors.transparent : widget.backgroundColor ?? appBarTheme.backgroundColor ?? themeData.primaryColor,
        elevation: widget.elevation ?? appBarTheme.elevation ?? 0.5,
        shadowColor: widget.shadowColor,
        child: appBar,
      ),
    );
  }
}

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: ScreenUtil().statusBarHeight + kToolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, ScreenUtil().statusBarHeight + kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}

class FZAppBarButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;
  final IconData icon;
  final double? iconSize;

  const FZAppBarButton({Key? key, this.onTap, this.color = Colors.grey,required this.icon,this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (null != onTap) onTap?.call();
        },
        icon: Icon(icon, color: color,size: iconSize ?? 16));
  }
}

// class WhiteBackButton extends StatelessWidget {
//   final VoidCallback? onTap;
//
//   const WhiteBackButton({Key? key, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return XyBackButton(
//       key: key,
//       color: Colors.white,
//       onTap: onTap,
//     );
//   }
// }
//
// class WhiteCloseButton extends StatelessWidget {
//   final VoidCallback? onTap;
//
//   const WhiteCloseButton({Key? key, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return XyCloseButton(
//       key: key,
//       color: Colors.white,
//       onTap: onTap,
//     );
//   }
// }
//
// class WhiteMoreButton extends StatelessWidget {
//   final VoidCallback? onTap;
//
//   const WhiteMoreButton({Key? key, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return XyMoreButton(
//       key: key,
//       color: Colors.white,
//       onTap: onTap,
//     );
//   }
// }
//
// ///返回按钮
class XyBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const XyBackButton({Key? key, this.onTap, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap?.call();
          } else {
            Navigator.maybePop(context);
          }
        },
        icon: Icon(
          Icons.chevron_left,
          size: 16,
          color: color,
        ));
  }
}

// ///关闭按钮
class XyCloseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const XyCloseButton({Key? key, this.onTap, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (onTap != null) {
            onTap?.call();
          } else {
            Navigator.maybePop(context);
          }
        },
        icon: Icon(Icons.close, size: 16, color: color));
  }
}

// ///更多按钮
class XyMoreButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const XyMoreButton({Key? key, this.onTap, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (null != onTap) onTap?.call();
        },
        icon: Icon(
          Icons.more_horiz,
          color: color,
        ));
  }
}
