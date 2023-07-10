import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pertemuan14Screen extends StatefulWidget {
  const Pertemuan14Screen({Key? key}) : super(key: key);

  @override
  _Pertemuan14ScreenState createState() => _Pertemuan14ScreenState();
}

class _Pertemuan14ScreenState extends State<Pertemuan14Screen> {
  DateTime _date = DateTime.now();
  DateTimeRange? _dateRange;
  TextEditingController? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 14'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Date Picker
            Row(
              children: [
                const Text('Tanggal'),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: InputDatePickerFormField(
                  initialDate: _date,
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2250),
                  onDateSubmitted: (date) {
                    setState(() {
                      _date = date;
                      print(date);
                    });
                  },
                )),
                IconButton(
                    onPressed: () async {
                      var res = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2500));

                      if (res != null) {
                        setState(() {
                          _date = res;
                        });
                      }
                    },
                    icon: const Icon(Icons.date_range))
              ],
            ),
            ListTile(
              title: const Text('Tanggal terpilih: '),
              subtitle: Text(_date.toString()),
            ),
            const Divider(),
            // Date Picker
            // Row(
            //   children: [
            //     const Text('Tanggal: '),
            //     const SizedBox(width: 10),
            //     Expanded(
            //       child: InputDatePickerFormField(
            //         initialDate: _dateRange?.start ?? DateTime.now(),
            //         firstDate: DateTime(1990),
            //         lastDate: DateTime(2250),
            //         onDateSubmitted: (date) {
            //           setState(() {
            //             _dateRange = DateTimeRange(start: date, end: date);
            //           });
            //         },
            //       ),
            //     ),
            //     IconButton(
            //       onPressed: () async {
            //         var res = await showDateRangePicker(
            //           context: context,
            //           initialDateRange: _dateRange ??
            //               DateTimeRange(
            //                   start: DateTime.now(), end: DateTime.now()),
            //           firstDate: DateTime(2000),
            //           lastDate: DateTime(2500),
            //         );

            //         if (res != null) {
            //           setState(() {
            //             _dateRange = res;
            //           });
            //         }
            //       },
            //       icon: const Icon(Icons.date_range),
            //     ),
            //   ],
            // ),
            // ListTile(
            //     title: const Text('Range Tanggal terpilih: '),
            //     subtitle: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         if (_dateRange != null) ...[
            //           const SizedBox(height: 10),
            //           const SizedBox(height: 5),
            //           Text('Mulai: ${_dateRange!.start}'),
            //           Text('Hingga: ${_dateRange!.end}'),
            //         ],
            //       ],
            //     )),

            // const Divider(),
            // ListTile(
            //     title: const Text('Range Tanggal terpilih: '),
            //     subtitle: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         if (_dateRange != null) ...[
            //           const SizedBox(height: 10),
            //           const SizedBox(height: 5),
            //           Text('Mulai: ${_dateRange!.start}'),
            //           Text('Hingga: ${_dateRange!.end}'),
            //         ],
            //       ],
            //     )),

            // Time Picker
            Row(
              children: [
                const Text('Jam: '),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _time,
                    decoration: const InputDecoration(labelText: 'Jam'),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var res = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (res != null) {
                      setState(() {
                        _time =
                            TextEditingController(text: res.format(context));
                      });
                    }
                  },
                  icon: const Icon(Icons.timer),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            const Divider(),
            // Date Picker
            Row(
              children: [
                const Text('Tanggal: '),
                const SizedBox(width: 10),
                Expanded(
                  child: InputDatePickerFormField(
                    initialDate: _dateRange?.start ?? DateTime.now(),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2250),
                    onDateSubmitted: (date) {
                      setState(() {
                        _dateRange = DateTimeRange(start: date, end: date);
                      });
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    var res = await showDateRangePicker(
                      context: context,
                      initialDateRange: _dateRange ??
                          DateTimeRange(
                              start: DateTime.now(), end: DateTime.now()),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2500),
                    );

                    if (res != null) {
                      setState(() {
                        _dateRange = res;
                      });
                    }
                  },
                  icon: const Icon(Icons.date_range),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            const Text('Range Tanggal terpilih: '),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (_dateRange != null) ...[
                //   const SizedBox(height: 10),
                //   const SizedBox(height: 5),
                //   Text('Mulai: ${_dateRange!.start}'),
                //   Text('Hingga: ${_dateRange!.end}'),
                // ],
                if (_dateRange != null)
                  ...getDaysInBetween(_dateRange!.start, _dateRange!.end)
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Text> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<Text> days = [];

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime currentDate =
          DateTime(startDate.year, startDate.month, startDate.day + i);

      String formattedDateTime = DateFormat('E, d-M-y').format(currentDate);

      days.add(Text(formattedDateTime));
    }

    return days;
  }
}
