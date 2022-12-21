import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kwikshop/body_widgets/header_widget.dart';
import 'package:kwikshop/body_widgets/navigation_bar.dart';
import 'package:kwikshop/components/our_button.dart';
import 'package:kwikshop/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:get/get.dart';

class FeedBackScreen extends StatelessWidget {
  int flag = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Feedback', style: kTextStyleHeaders),
            elevation: 0.5,
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ])),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                      height: 80,
                      child: HeaderWidget(
                        showIcon: false,
                        height: 80,
                      )),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rate Experience',
                                style: kTextStyleHeaders,
                              ),
                              const SizedBox(height: 5),
                              const Text('Are you Satisfied from our services?',
                                  style: kTextStyleSmall),
                              const SizedBox(height: 20),
                              RatingBar.builder(
                                itemBuilder: (context, index) {
                                  return const Icon(CupertinoIcons.star_fill,
                                      color: Color(0xFF19B758));
                                },
                                itemPadding: const EdgeInsets.all(5),
                                initialRating: 0,
                                allowHalfRating: true,
                                onRatingUpdate: (value) {
                                  flag = 1;
                                },
                              ),
                              const Divider(thickness: 1, height: 50),
                              TextFormField(
                                maxLines: 10,
                                decoration: const InputDecoration(
                                  hintText: 'Tell us on  how can we imporve',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0),
                                  ),

                                  // Inp
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: button(
                                  'Submit',
                                  300,
                                  () {
                                    flag == 0
                                        ? Get.snackbar(
                                            'Cannot continue',
                                            'Rate us to continue',
                                            duration:
                                                const Duration(seconds: 2),
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: const EdgeInsets.all(7),
                                          )
                                        : Alert(
                                            context: context,
                                            title: 'Thank You',
                                            desc:
                                                'Your feedback has been successfully submitted',
                                            type: AlertType.success,
                                            closeIcon: const Icon(
                                                CupertinoIcons.clear),
                                            style: const AlertStyle(
                                              animationType:
                                                  AnimationType.shrink,
                                              alertElevation: 2.5,
                                            ),
                                            closeFunction: () {
                                              Navigator.pop(context);
                                            },
                                            buttons: [
                                                DialogButton(
                                                  onPressed: () {
                                                    Get.offAll(() => NaviBar(),
                                                        transition: Transition
                                                            .cupertino);
                                                  },
                                                  color: Colors.amber.shade700,
                                                  child: const Text(
                                                    'Back',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ]).show();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
