import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widget/account_card.dart';
import 'widget/base_page.dart';
import 'widget/button/default_button.dart';
import 'widget/button/prev_button.dart';
import 'widget/const/page_name.dart';
import 'widget/entry_field.dart';
import 'widget/entry_label.dart';
import 'widget/msg_box.dart';
import 'widget/page_title.dart';
import 'widget/text_formatter.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _dummy = [
    {
      'account_type': 'Savings',
      'formatted_balance': 'Rp 123 456 789',
      'account_number': '1234567890123456',
      'card_number': '1234 5678 9012 3456',
      'formatted_date': '12/34',
    },
    {
      'account_type': 'Current',
      'formatted_balance': 'Rp 2 468 163 264',
      'account_number': '2468163264128256',
      'card_number': '2468 1632 6412 8256',
      'formatted_date': '06/36',
    },
    {
      'account_type': 'Checking',
      'formatted_balance': 'Rp 36 936 936',
      'account_number': '3693693693693693',
      'card_number': '3693 6936 9369 3693',
      'formatted_date': '03/33',
    },
  ];

  final _otherBanksDummy = [
    {'000': 'Zero Bank'},
    {'001': 'One Bank'},
    {'010': 'Ten Bank'},
    {'012': 'Twelve Bank'},
    {'100': 'Cent Bank'},
    {'123': 'ABC Bank'},
    {'456': 'Four Bank'},
    {'789': 'Seven Bank'},
  ];

  final _beneficiariesDummy = {
    'ON_US': [
      {
        'account_number': '9876543210987654',
        'account_name': 'Jonah Williams',
      },
      {
        'account_number': '3456789012345678',
        'account_name': 'Gary Qian',
      },
      {
        'account_number': '3210987654321098',
        'account_name': 'Collin Jackson',
      },
    ],
    'VA': [
      {
        'account_number': '23456789012345678901',
        'account_name': 'SHOPEEPAY',
      },
      {
        'account_number': '21098765432109876543',
        'account_name': 'GO-PAY CUSTOMER',
      },
    ],
    '000': [
      {
        'account_number': '88890123444',
        'account_name': 'Christopher Fujino',
      },
      {
        'account_number': '55567890111',
        'account_name': 'Darren Austin',
      },
    ],
    '123': [
      {
        'account_number': '123456789',
        'account_name': 'Stuart Morgan',
      },
    ],
    '789': [
      {
        'account_number': '4567890',
        'account_name': 'Hans Muller',
      },
      {
        'account_number': '1234567',
        'account_name': 'Jason Simmons',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    PageName.get(AppPage.transfer)!.isAlive = true;
    _otherBanksDummy.sort(
      (a, b) => a.values.first.compareTo(b.values.first),
    );
  }

  @override
  void dispose() {
    PageName.get(AppPage.transfer)!.isAlive = false;
    super.dispose();
  }

  final CarouselController _controller = CarouselController();
  int _sourceOfFundsIndex = 0;
  Widget _sourceOfFunds() {
    final ctxMediaQuery = MediaQuery.of(context);
    final ctxMediaQuerySize = ctxMediaQuery.size;
    final sW = ctxMediaQuerySize.width;
    final sH = ctxMediaQuerySize.height;
    final nr = .05 * min(sW, sH); // num font size

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EntryLabel('Select source of funds'),
        CarouselSlider(
          items: _dummy
              .map(
                (e) => AccountCard(
                  e['account_type']!,
                  e['card_number']!,
                  e['formatted_balance']!,
                  nrSize: nr,
                ),
              )
              .toList(),
          options: CarouselOptions(
            autoPlay: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            aspectRatio: 2,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _sourceOfFundsIndex = index;
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _dummy
              .asMap()
              .entries
              .map(
                (e) => GestureDetector(
                  onTap: () => _controller.animateToPage(e.key),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _sourceOfFundsIndex == e.key
                          ? Colors.black87
                          : Colors.black12,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const EntryLabel('Source account number'),
            Text(_dummy.asMap()[_sourceOfFundsIndex]!['account_number']!),
          ],
        ),
      ],
    );
  }

  String? _selectedTargetBank;
  // reset beneficiary on target bank changed
  void _selectTargetBank(String? bank) {
    _selectedTargetBank = bank;
    _selectedBeneficiary = null;
  }

  Widget _targetBank() {
    final double width = MediaQuery.of(context).size.width;
    final double indent = width / 4;

    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(maxWidth: width - 40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (_) => StatefulBuilder(
          builder: (_, setState) => Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Divider(
                  color: Colors.black,
                  indent: indent,
                  endIndent: indent,
                  thickness: 2,
                ),
                const EntryLabel('Select Target'),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text('Metro Bank'),
                          value: 'ON_US',
                          groupValue: _selectedTargetBank,
                          onChanged: (value) => setState(
                            () {
                              _selectTargetBank(value);
                            },
                          ),
                        ),
                        RadioListTile(
                          title: const Text('Metro Bank Virtual Account'),
                          value: 'VA',
                          groupValue: _selectedTargetBank,
                          onChanged: (value) => setState(
                            () {
                              _selectTargetBank(value);
                            },
                          ),
                        ),
                        const Divider(),
                        const EntryLabel('Other Bank'),
                        Column(
                          children: _otherBanksDummy.map(
                            (e) {
                              return RadioListTile(
                                title: Text(e.values.first),
                                value: e.keys.first,
                                groupValue: _selectedTargetBank,
                                onChanged: (value) => setState(
                                  () {
                                    _selectTargetBank(value);
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                DefaultButton(
                  'OK',
                  tapAction: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ).whenComplete(
        () => setState(
          () {}, // force refresh state
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EntryLabel('Target bank'),
          Row(
            children: [
              Text(
                _selectedTargetBank == null
                    ? 'Select Target Bank'
                    : _selectedTargetBank == 'ON_US'
                        ? 'Metro Bank'
                        : _selectedTargetBank == 'VA'
                            ? 'Metro Bank Virtual Account'
                            : _otherBanksDummy
                                .firstWhere(
                                  (element) =>
                                      element.keys.first == _selectedTargetBank,
                                )
                                .values
                                .first,
                style: TextStyle(
                  fontStyle: _selectedTargetBank == null
                      ? FontStyle.italic
                      : FontStyle.normal,
                  color:
                      _selectedTargetBank == null ? Colors.red : Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  dynamic _selectedBeneficiary;
  dynamic _currentBeneficiary;
  Widget _targetAccountName() {
    _currentBeneficiary = _selectedBeneficiary; // restore state

    return InkWell(
      onTap: () => _selectedTargetBank == null
          ? MsgBox.showAlertDialogOK(
              context,
              DialogIcon.warn,
              prefix: 'Please select',
              'Target Bank',
              postfix: 'first',
            )
          : showGeneralDialog(
              context: context,
              pageBuilder: (_, animation, secondaryAnimation) => Dialog(
                insetPadding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: StatefulBuilder(
                  builder: (context, setState) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PrevButton(
                                      label: 'Cancel',
                                      tapAction: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                              EntryField(
                                'Beneficiary account number',
                                keyType: TextInputType.number,
                                textFormatters: [
                                  TextFormatter.numbersOnly,
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: DefaultButton(
                                  'Inquire',
                                  tapAction: () => {},
                                ),
                              ),
                              const Divider(),
                              const EntryLabel('Past beneficiaries'),
                              _beneficiariesDummy[_selectedTargetBank] == null
                                  ? Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.withOpacity(.33),
                                        child: Center(
                                          child: Text(
                                            'No past beneficiaries yet',
                                            style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(.67),
                                              // fontSize: .05 *
                                              //     MediaQuery.of(context)
                                              //         .size
                                              //         .width,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: _beneficiariesDummy[
                                                _selectedTargetBank]!
                                            .map(
                                              (e) => RadioListTile(
                                                title: Text(e['account_name']!),
                                                subtitle:
                                                    Text(e['account_number']!),
                                                value: e,
                                                secondary: InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                groupValue: _currentBeneficiary,
                                                onChanged: (value) => setState(
                                                  () {
                                                    _currentBeneficiary = value;
                                                  },
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: DefaultButton(
                            'Select',
                            disabled: _currentBeneficiary == null,
                            tapAction: () {
                              setState(
                                () {
                                  _selectedBeneficiary = _currentBeneficiary;
                                },
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).whenComplete(
              () => setState(
                () {
                  _currentBeneficiary = null; // clear state
                },
              ),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EntryLabel('Target account name'),
          Row(
            children: [
              Text(
                _selectedBeneficiary == null
                    ? 'Select Beneficiary'
                    : _selectedBeneficiary['account_name'],
                style: TextStyle(
                  fontStyle: _selectedBeneficiary == null
                      ? FontStyle.italic
                      : FontStyle.normal,
                  color: _selectedTargetBank == null
                      ? Colors.grey
                      : _selectedBeneficiary == null
                          ? Colors.red
                          : Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  final _amountField = TextEditingController();
  double? _amount;
  Widget _transferAmount() {
    return InkWell(
      onTap: () =>
          MsgBox.showSimpleNumberInputDialog(context, 'Amount', _amountField)
              .whenComplete(
        () => setState(
          () {
            _amount = _amountField.text.isNotEmpty
                ? double.parse(_amountField.text)
                : null;
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EntryLabel('Amount'),
          Row(
            children: [
              Text(
                _amount == null
                    ? 'Input Amount'
                    : 'Rp ${NumberFormat('#,###', 'en_US').format(_amount).replaceAll(',', ' ')}',
                style: TextStyle(
                  fontStyle:
                      _amount == null ? FontStyle.italic : FontStyle.normal,
                  color: _amount == null ? Colors.red : Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  final _messageField = TextEditingController();
  String? _message;
  Widget _transferMessage() {
    return InkWell(
      onTap: () =>
          MsgBox.showSimpleTextInputDialog(context, 'Message', _messageField)
              .whenComplete(
        () => setState(
          () {
            _message =
                _messageField.text.isNotEmpty ? _messageField.text : null;
          },
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const EntryLabel('Message'),
          Row(
            children: [
              Text(
                _message ?? 'Input Message (optional)',
                style: TextStyle(
                  fontStyle:
                      _message == null ? FontStyle.italic : FontStyle.normal,
                ),
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  Widget _adminFee() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const EntryLabel('Admin fee'),
        Text('Rp 0'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      const PageTitle('funds', 'transfer'),
      [
        _sourceOfFunds(),
        const Divider(),
        _targetBank(),
        const Divider(),
        _targetAccountName(),
        const Divider(),
        _transferAmount(),
        const Divider(),
        _transferMessage(),
        const Divider(),
        _adminFee(),
        const SizedBox(height: 20),
        DefaultButton(
          'Send',
          tapAction: () {
            if (_amount == null) {
              return MsgBox.showAlertDialogOK(
                context,
                DialogIcon.error,
                'Invalid Amount',
              );
            }

            if (_selectedBeneficiary == null) {
              return MsgBox.showAlertDialogOK(
                context,
                DialogIcon.error,
                'Invalid Beneficiary',
              );
            }

            // TODO: Submit transaction!
            MsgBox.showAlertDialogOK(
                context, DialogIcon.info, 'Transaction sent');
          },
        ),
      ],
    );
  }
}
