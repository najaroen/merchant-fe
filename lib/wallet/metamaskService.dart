import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

const String privateKey =
    '1ff1ffcde2fec6a550aee8250ef9bd43d09a98561a630ec8988101d28a15b616';
const String rpcUrl = 'https://evmrpc1-iot.adldigitalservice.com/';

class MetamaskService {
  final EthereumAddress _defaultAddress;

  MetamaskService(this._defaultAddress);

  Future<void> authorizeAccount() async {
    // Method to authorize account with Metamask wallet API
  }

  Future<BigInt> getBalance() async {
    // Method to fetch account balance from Metamask
    return BigInt.from(-10.99);
  }

  Future<EtherAmount> initMetamask() async {
    try {
      var httpClient = Client();

      final client = Web3Client(rpcUrl, httpClient);

      final credentials = EthPrivateKey.fromHex(privateKey);
      final address = credentials.address;
      return await client.getBalance(address);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> sendTransaction(
    EthereumAddress recipient,
    BigInt amount,
  ) async {
    // Method to send transaction via Metamask
  }
}
