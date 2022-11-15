import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const/color_palette.dart';

class AccountCard extends StatelessWidget {
  final String accountType;
  final backColor;
  final String formattedNumber;
  final String formattedBalance;
  final String formattedDate;
  final double nrSize;

  const AccountCard(
      this.accountType, this.formattedNumber, this.formattedBalance,
      {this.formattedDate = '',
      this.nrSize = 12,
      this.backColor = 0,
      super.key});

  Color getColor() {
    switch (accountType.toUpperCase()) {
      case 'SAVINGS':
        return AppColor.acctType1;
      case 'CURRENT':
        return AppColor.acctType2;
      case 'CHECKING':
        return AppColor.acctType3;
      default:
        return const Color(0x00000000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backColor == 0 ? getColor() : const Color(0x00000000),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  // Account Type
                  accountType,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  // Account Balance
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    formattedBalance,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              // Account / Card Number
              padding: EdgeInsets.only(top: .5 * nrSize),
              child: Row(
                children: [
                  Text(
                    formattedNumber,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: nrSize,
                      color: const Color(0xffffffff),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: formattedNumber.replaceAll(' ', ''),
                        ),
                      ).then(
                        (_) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard'),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: .25 * nrSize),
                      child: const Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // Exp Date
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    formattedDate,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
