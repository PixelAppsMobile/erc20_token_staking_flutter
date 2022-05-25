import 'package:flutter/material.dart';
import 'package:flutter_staking/screens/shared/rounded_key_action_button.dart';
import 'package:flutter_staking/screens/staking/staking_page.dart';

class ExploreStakingSection extends StatelessWidget {
  const ExploreStakingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedKeyActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StakingPage(),
        ),
      ),
      child: const Text(
        'Explore Token Staking',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      color: Colors.grey[400],
    );
  }
}
