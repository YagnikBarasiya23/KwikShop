import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../assets_gen.dart';
import '../../../../core/shared/app_button.dart';
import '../../../../core/shared/app_dailog.dart';
import '../../../../core/shared/snackbar.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';

class FeedBackScreen extends StatelessWidget {
  static int _flag = 0;
  const FeedBackScreen({super.key});
  static const String routeName = '/feedback';

  void showFeedbackDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          AppDialog(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(
            context,
            WelcomeScreen.routeName,
          );
        },
        image: Assets.icons.emptyCart.image(width: 50, height: 50),
        title: 'Thank You',
        desc: 'Your feedback has been successfully submitted',
        animation: animation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate Experience',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  'Are you Satisfied from our services?',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                RatingBar.builder(
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: Color(0xFF19B758),
                    );
                  },
                  itemPadding: const EdgeInsets.all(5),
                  initialRating: 0,
                  glow: false,
                  allowHalfRating: true,
                  onRatingUpdate: (value) {
                    _flag = 1;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Tell us on  how can we improve',
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: AppButton(
                    title: 'Submit',
                    onPressed: () {
                      _flag == 0
                          ? appSnackBar(
                              'Rate us to continue',
                            )
                          : showFeedbackDialog(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
