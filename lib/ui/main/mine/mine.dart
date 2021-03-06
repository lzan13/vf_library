import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:vf_girls/view_model/theme_model.dart';

import 'package:vf_plugin/vf_plugin.dart';

import 'package:vf_girls/common/index.dart';
import 'package:vf_girls/router/router_manger.dart';
import 'package:vf_girls/ui/widget/bottom_clipper.dart';
import 'package:vf_girls/view_model/sign_model.dart';

///
/// 我的 Tab 页面
///
class MinePage extends StatefulWidget {
  @override
  MinePageState createState() => MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    VFLog.d('MinePage initState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh.custom(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            MineHeaderWidget(),
            // 切换夜间模式
            VFListItem(
              title: FlutterI18n.translate(context, 'theme_dark'),
              titleColor: Theme.of(context).textTheme.title.color,
              onPressed: () {
                Provider.of<ThemeModel>(context).switchTheme(
                    userDarkMode:
                        Theme.of(context).brightness == Brightness.light);
              },
              leftIcon: Theme.of(context).brightness == Brightness.light
                  ? VFIcons.ic_sunny
                  : VFIcons.ic_moonlight,
              rightWidget: Padding(
                padding: EdgeInsets.only(right: VFDimens.d_16),
                child: CupertinoSwitch(
                  activeColor: Theme.of(context).accentColor,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    Provider.of<ThemeModel>(context).switchTheme(
                        userDarkMode:
                            Theme.of(context).brightness == Brightness.light);
                  },
                ),
              ),
            ),
            // 设置
            VFListItem(
              title: FlutterI18n.translate(context, 'settings'),
//              describe: FlutterI18n.translate(context, 'settings'),
              onPressed: () {
                Router.toSettings(context);
              },
              leftIcon: VFIcons.ic_settings,
              rightIcon: VFIcons.ic_arrow_right,
            ),
            // 测试
            VFListItem(
              title: FlutterI18n.translate(context, ' test'),
              describe: FlutterI18n.translate(context, 'test_desc'),
              onPressed: () {
                Router.toTest(context);
              },
              leftIcon: VFIcons.ic_settings,
              rightIcon: VFIcons.ic_arrow_right,
            ),
          ]),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///
/// 我的界面顶部部分
///
class MineHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: VFDimens.d_320 + MediaQuery.of(context).padding.top,
        color: Theme.of(context).primaryColor.withAlpha(225),
        padding: EdgeInsets.only(top: VFDimens.d_16),
        child: Consumer<SignModel>(
          builder: (context, model, child) => InkWell(
            onTap: model.isSign
                ? null
                : () {
                    Router.toSignIn(context);
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Hero(
                    tag: 'sign_logo',
                    child: ClipOval(
                      child: Container(
                        width: VFDimens.d_96,
                        height: VFDimens.d_96,
                        child: model.isSign && model.user.avatar != null
                            ? CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: model.user.avatar.url,
                                placeholder: (context, url) => Image.asset(
                                  RESHelper.wrapImage('img_logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                RESHelper.wrapImage('img_logo.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                        model.isSign
                            ? model.user.nickname
                            : FlutterI18n.translate(context, "sign_go_in"),
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: Colors.white.withAlpha(200))),
                    SizedBox(
                      height: VFDimens.d_24,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
