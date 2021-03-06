import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:nudemo/utils/routes.dart';
import 'package:nudemo/home/presenter/fade_box_presenter.dart';

/// `Section II` - Main menu container
class SectionII extends StatelessWidget {
  @required
  final double topLogoHeight;
  @required
  final double mainContainerHeight;
  @required
  final double bottomMenuHeight;
  @required
  final String qrCodeData;

  SectionII({
    this.topLogoHeight,
    this.mainContainerHeight,
    this.bottomMenuHeight,
    this.qrCodeData,
  });

  @override
  Widget build(BuildContext context) {
    final Widget dividerList = Divider(
      height: 2,
      color: Theme.of(context).primaryColorLight,
    );

    // Text builder for QR-Code container (Section II)
    Widget _buildRichText({String txtNormal, String txtBold}) {
      return RichText(
        text: TextSpan(
          text: txtNormal,
          style: TextStyle(
            fontSize: 13.0,
            color: Theme.of(context).textTheme.subhead.color,
          ),
          children: <TextSpan>[
            TextSpan(
              text: txtBold,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Theme.of(context).textTheme.subhead.color,
              ),
            ),
          ],
        ),
      );
    }

    // QR-Code rendering container (Section II)
    final Widget _qrCodeRendering = QrImage(
      data: qrCodeData,
      version: QrVersions.auto,
      size: 105.0,
      padding: EdgeInsets.all(9.0),
      foregroundColor: Theme.of(context).backgroundColor,
      backgroundColor: Theme.of(context).textTheme.subhead.color,
      errorCorrectionLevel: QrErrorCorrectLevel.M,

      /// Not good with this image in center 🤷‍♀️
      // embeddedImage: AssetImage(
      //   'assets/images/logo_white.png',
      // ),
      // embeddedImageStyle: QrEmbeddedImageStyle(
      //   size: Size(40, 40),
      //   color: Theme.of(context).backgroundColor,
      // ),
      // embeddedImageEmitsError: true,
      // errorStateBuilder: (cxt, err) {
      //   // print('QrImage error: $err');
      //   return Container(
      //     child: Center(
      //       child: Text(
      //         "Uh oh! Something went wrong with QR Code...",
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //           color: Theme.of(context).backgroundColor,
      //         ),
      //       ),
      //     ),
      //   );
      // },
    );

    // Top container (Section II)
    final Widget _topContainer = Container(
      // color: Colors.black38, // debug UI 🙃
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Center(child: _qrCodeRendering),
          ),
          _buildRichText(
            txtNormal: 'Banco ',
            txtBold: '260 - Nu Pagamentos S.A.',
          ),
          _buildRichText(
            txtNormal: 'Agência ',
            txtBold: '0001',
          ),
          _buildRichText(
            txtNormal: 'Conta ',
            txtBold: '4587XXX-2',
          ),
        ],
      ),
    );

    // Build button list (Section II)
    Widget _buildButtonList({
      IconData iconLeft,
      IconData iconRight = Icons.keyboard_arrow_right,
      String title,
      String subtitle = '',
      String route,
    }) {
      List<Widget> columnList = [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: Theme.of(context).textTheme.subhead.fontSize,
            fontWeight: Theme.of(context).textTheme.subhead.fontWeight,
            fontStyle: Theme.of(context).textTheme.subhead.fontStyle,
          ),
        ),
      ];

      if (subtitle.isNotEmpty) {
        columnList.add(
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontSize: Theme.of(context).textTheme.subtitle.fontSize,
              fontWeight: Theme.of(context).textTheme.subtitle.fontWeight,
              fontStyle: Theme.of(context).textTheme.subtitle.fontStyle,
            ),
          ),
        );
      }

      return MaterialButton(
        // color: Colors.black12, // debug UI 🙃
        key: Key(route),
        onPressed: () => Routes(context).navigatorPush(context, route),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                iconLeft,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnList,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                iconRight,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      );
    }

    return Positioned(
      top: topLogoHeight,
      left: 0.0,
      right: 0.0,
      height: mainContainerHeight,
      key: Key('section-ii'),
      child: Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 0,
        ),
        // color: Colors.indigo, // debug UI 🙃
        child: Consumer<FadeBoxPresenter>(
          builder: (context, fadeBox, child) => FadeTransition(
            opacity: fadeBox.getCurvedAnimation(),
            child: ListView(
              children: <Widget>[
                _topContainer,
                dividerList,
                _buildButtonList(
                  iconLeft: Icons.help_outline,
                  title: 'Me ajuda',
                  route: '/helpme/',
                ),
                dividerList,
                _buildButtonList(
                  iconLeft: Icons.account_circle,
                  title: 'Perfil',
                  subtitle: 'Nome de preferência, telefone, e-mail',
                  route: '/profile/',
                ),
                dividerList,
                _buildButtonList(
                  iconLeft: Icons.local_atm,
                  title: 'Configurar NuConta',
                  route: '/nuconta-configs/',
                ),
                dividerList,
                _buildButtonList(
                  iconLeft: Icons.credit_card,
                  title: 'Configurar cartão',
                  route: '/card-configs/',
                ),
                dividerList,
                _buildButtonList(
                  iconLeft: Icons.fingerprint,
                  title: 'Configurações do app',
                  route: '/app-configs/',
                ),
                dividerList,
                Divider(
                  height: 15,
                  color: Colors.transparent,
                ),
                RaisedButton(
                  key: Key('/exit/'),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Sair da conta'.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subhead.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                ),
                Divider(
                  height: bottomMenuHeight,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
