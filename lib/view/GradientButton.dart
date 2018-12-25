import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;
  final double radius;
  final Widget child;

  //点击回调
  final GestureTapCallback onTap;

  const GradientButton(
      {Key key,
      this.colors,
      this.width,
      this.height,
      this.onTap,
      this.radius,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)), //控件圆角
          gradient: LinearGradient(colors: _colors)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(radius)), //点击时水波纹的圆角
          splashColor: colors.last,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: DefaultTextStyle(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
