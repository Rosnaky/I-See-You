import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ISeeYou/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QuickActionCard extends StatefulWidget {
  const QuickActionCard({
    super.key,
    required this.constraints,
    required this.message,
    required this.actionTitle,
    required this.actionIcon,
  });

  final BoxConstraints constraints;
  final String message;
  final String actionTitle;
  final Icon actionIcon;

  @override
  State<QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<QuickActionCard> {
  BoxConstraints get constraints => widget.constraints;
  String get message => widget.message;
  String get actionTitle => widget.actionTitle;
  Icon get actionIcon => widget.actionIcon;
  late bool _isClicked;
  late bool _isSending;
  Timer? _timer;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
    _isClicked = false;
    _isSending = false;
  }

  @override
  void dispose() {
    _isClicked = false;
    _isSending = false;
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isSending = true;
    });
    var counter = 1;
    launchUrlString(
        "sms:${userProvider.user?.emergencyContacts[0]}?body=$message");
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      launchUrlString(
          "sms:${userProvider.user?.emergencyContacts[counter]}?body=$message");
      counter++;
      if (counter == userProvider.user?.emergencyContacts.length) {
        timer.cancel();
      }
    });
    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Stack(
        children: [
          Card(
            child: SizedBox(
              width: constraints.maxWidth > 600
                  ? constraints.maxWidth * 0.3
                  : constraints.maxWidth * 0.45,
              height: constraints.maxWidth > 600
                  ? constraints.maxWidth * 0.3
                  : constraints.maxWidth * 0.45,
              child: _isClicked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (!_isSending) _startTimer();
                                setState(() {
                                  _isClicked = false;
                                });
                              },
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.sms,
                                  ),
                                  Text("SMS"),
                                ],
                              )),
                        ),
                        Expanded(
                          child: Column(
                            children: userProvider.user?.emergencyContacts
                                    .map((e) => Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                launchUrlString("tel:$e");
                                                setState(() {
                                                  _isClicked = false;
                                                });
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.phone_iphone,
                                                    size: constraints.maxWidth >
                                                            600
                                                        ? min(
                                                            constraints
                                                                    .maxWidth *
                                                                0.1,
                                                            16,
                                                          )
                                                        : 16,
                                                  ),
                                                  Text(
                                                    "Call #${userProvider.user!.emergencyContacts.indexOf(e) + 1} Emergency Contact",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontSize: constraints
                                                                      .maxWidth >
                                                                  600
                                                              ? 14
                                                              : 10,
                                                        ),
                                                  ),
                                                ],
                                              )),
                                        ))
                                    .toList() ??
                                [const Text("No emergency contacts found")],
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isClicked = true;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          actionIcon,
                          Text(actionTitle),
                        ],
                      ),
                    ),
            ),
          ),
          Positioned(
            left: 0,
            top: 16,
            child: _isClicked
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () => setState(() {
                          _isClicked = false;
                        }),
                    child: Column(
                      children: [
                        Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Close",
                            style: constraints.maxWidth > 600
                                ? Theme.of(context).textTheme.bodySmall
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 10),
                          ),
                        )
                      ],
                    ))
                : const SizedBox(),
          )
        ],
      );
    });
  }
}
