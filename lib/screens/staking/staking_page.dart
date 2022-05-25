import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staking/screens/shared/rounded_key_action_button.dart';
import 'package:flutter_staking/screens/staking/staking_page_view_model.dart';
import 'package:flutter_staking/utils/extensions/bigint_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class StakingPage extends ConsumerStatefulWidget {
  const StakingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<StakingPage> createState() => _StakingPageState();
}

class _StakingPageState extends ConsumerState<StakingPage>
    with StakingPageView {
  late StakingPageViewModel _stakingPageViewModel;

  @override
  void initState() {
    super.initState();
    _stakingPageViewModel = ref.read(stakingPageViewModel)..attachView(this);
    _stakingPageViewModel.initialise();
  }

  @override
  void didChangeDependencies() {
    _stakingPageViewModel = ref.read(stakingPageViewModel);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _stakingPageViewModel.detachView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staking'),
      ),
      body: Consumer(builder: (context, ref, child) {
        bool loading = ref.watch(stakingPageViewModel).loading;

        if (loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async => _stakingPageViewModel.initialise(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Stake balance',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _stakingPageViewModel.stakeBalance
                                  .toDecimal()
                                  .toString() +
                              ' TRC',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Stake 5 TRC for 120 secs',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8),
                  RoundedKeyActionButton(
                    onPressed:
                        loading ? null : () => _stakingPageViewModel.stake(),
                    child: const Text('Stake'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Unstake 5 TRC',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8),
                  RoundedKeyActionButton(
                    onPressed:
                        loading ? null : () => _stakingPageViewModel.unstake(),
                    child: const Text('Unstake'),
                    color: Colors.grey[400],
                  ),
                  const Divider(
                    height: 100,
                    thickness: 2.0,
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Allowance',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _stakingPageViewModel.stakeAllowance
                                  .toDecimal()
                                  .toString() +
                              ' TRC',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Approve 5 TRC',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8),
                  RoundedKeyActionButton(
                    onPressed:
                        loading ? null : () => _stakingPageViewModel.approve(),
                    child: const Text('Approve'),
                    color: Colors.purple[400],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  showAlertDialog(String message, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Message',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await launch(url);
              Navigator.pop(context);
            },
            child: const Text(
              'Go to Etherscan',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
