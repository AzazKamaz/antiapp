import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TextInverter extends StatefulWidget {
  const TextInverter({Key? key}) : super(key: key);

  @override
  State<TextInverter> createState() => _TextInverterState();
}

class _TextInverterState extends State<TextInverter> {
  final _controller = TextEditingController();
  final _translatedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text_inverter'.tr()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(children: [
                  const Spacer(flex: 2),
                  Text(
                    'any'.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(flex: 1),
                  const Icon(Icons.compare_arrows),
                  const Spacer(flex: 1),
                  Text(
                    'antiany'.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(flex: 2),
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: 10,
                    style: Theme.of(context).textTheme.bodyText1,
                    textInputAction: TextInputAction.send,
                    onEditingComplete: () {
                      translate();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      suffix: IconButton(
                          iconSize: 16,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(maxHeight: 16),
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            _translatedController.clear();
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _translatedController,
                    maxLines: 10,
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    translate();
                  },
                  child: Text('translate'.tr()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void translate() async {
    FocusScope.of(context).unfocus();
    showLoadingDialog(context);
    final Dio _dio = Dio();
    try {
      final response = await _dio.post(
          'https://antiapp.tmp.azazkamaz.me/v1/antitext',
          data: {'text': _controller.text});

      Navigator.of(context).pop();

      _translatedController.text = response.data['text'];
      setState(() {});
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  showLoadingDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      builder: (BuildContext context) {
        return AlertDialog(
            elevation: 0,
            // contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Center(
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      )
                    ],
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ));
      });
}
