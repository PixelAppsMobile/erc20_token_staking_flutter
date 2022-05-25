import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staking/providers/base_view_model.dart';
import 'package:flutter_staking/providers/wallet_provider.dart';

final stakingPageViewModel =
    ChangeNotifierProvider((ref) => StakingPageViewModel(ref.read));

mixin StakingPageView {
  showAlertDialog(String message, String url);
  showError(String message);
}

class StakingPageViewModel extends BaseViewModel<StakingPageView> {
  final Reader _reader;
  late BigInt _stakeBalance;
  late BigInt _stakeAllowance;

  StakingPageViewModel(this._reader);

  BigInt get stakeBalance => _stakeBalance;

  BigInt get stakeAllowance => _stakeAllowance;

  set stakeBalance(BigInt amt) {
    _stakeBalance = amt;
    notifyListeners();
  }

  Future<void> stake() async {
    loading = true;

    try {
      String txBlockHash = await _reader(walletProvider).stakeToken();
      loading = false;

      print(txBlockHash);
      String url = "https://rinkeby.etherscan.io/tx/$txBlockHash";
      String message =
          "Tx block hash: $txBlockHash\nIt might take a while for transaction to complete. You can track the progress on Etherscan.";

      view!.showAlertDialog(message, url);
    } catch (e) {
      loading = false;
      view!.showError(e.toString());
      print(e);
    }
  }

  Future<void> unstake() async {
    loading = true;
    try {
      String txBlockHash = await _reader(walletProvider).unstakeToken();
      loading = false;

      print(txBlockHash);
      String url = "https://rinkeby.etherscan.io/tx/$txBlockHash";
      String message =
          "Tx block hash: $txBlockHash\nIt might take a while for transaction to complete. You can track the progress on Etherscan.";

      view!.showAlertDialog(message, url);
    } catch (e) {
      loading = false;
      view!.showError(e.toString());
      print(e);
    }
  }

  Future<void> initialise() async {
    loading = true;
    await getStakeBalance();
    await getAllowance();
    loading = false;
  }

  Future<void> getStakeBalance() async {
    try {
      _stakeBalance = await _reader(walletProvider).getStakeBalance();
    } catch (e) {
      _stakeBalance = BigInt.from(0.0);
      print("ERROR: $e");
    }
  }

  Future<void> getAllowance() async {
    try {
      _stakeAllowance =
          await _reader(walletProvider).getAllowanceForStakingContract();
    } catch (e) {
      _stakeAllowance = BigInt.from(0.0);
      print("ERROR: $e");
    }
  }

  Future<void> approve() async {
    loading = true;
    try {
      String txBlockHash =
          await _reader(walletProvider).approveStakingContract();
      loading = false;

      print(txBlockHash);
      String url = "https://rinkeby.etherscan.io/tx/$txBlockHash";
      String message =
          "Tx block hash: $txBlockHash\nIt might take a while for transaction to complete. You can track the progress on Etherscan.";

      view!.showAlertDialog(message, url);
    } catch (e) {
      loading = false;
      view!.showError(e.toString());
      print(e);
    }
  }
}
