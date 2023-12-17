import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/utils/constants.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final WeatherController weatherController = Get.put(WeatherController());
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ColorScheme colors;

  ButtonStyle borderedButtonStyle = ButtonStyle(
      elevation: MaterialStateProperty.all(7),
      backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 220, 195, 224)),
      // overlayColor:
      //     MaterialStateProperty.all(const Color.fromARGB(255, 204, 154, 212)),
      // shadowColor: MaterialStateProperty.all(Color.fromARGB(255, 89, 51, 95)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromARGB(255, 158, 87, 170)),
          borderRadius: BorderRadius.circular(10))));

  @override
  Widget build(BuildContext context) {
    colors = Theme.of(context).colorScheme;
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) => mobileContainer(),
        desktop: (BuildContext context) => desktopContainer());
  }

  Widget mobileContainer() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Weather App',
                    style: TextStyle(
                        fontSize: h! / 25,
                        fontWeight: FontWeight.bold,
                        color: colors.primary),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text('Check the temperature and weather conditions',
                      style: TextStyle(
                          fontSize: h! / 45, color: Colors.grey.shade600),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          textInputAction: TextInputAction.done,
                          validator: (String? value) {
                            return (value == null || value.isEmpty)
                                ? "This field can not be empty"
                                : null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Enter city...'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ElevatedButton.icon(
                            style: borderedButtonStyle,
                            onPressed: () => {
                                  weatherController.getWeatherData(
                                      city: _controller.value.text)
                                },
                            icon: Icon(Icons.search, color: colors.primary),
                            label: Text(
                              'Search',
                              style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Obx(() {
              if (weatherController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (!weatherController.isLoading.value &&
                  weatherController.weather == null) {
                return Container();
              } else {
                return Column(
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy HH:mm:ss')
                          .format(DateTime.now()),
                      style:
                          TextStyle(fontSize: h! / 40, color: colors.primary),
                    ),
                    Center(child: weatherController.icon!),
                    Text('${weatherController.weather!.city}',
                        style: TextStyle(
                            fontSize: h! / 24,
                            fontWeight: FontWeight.w400,
                            color: colors.primary)),
                    Text('${weatherController.weather!.temp!}°C',
                        style: TextStyle(fontSize: h! / 20)),
                    Text(weatherController.weather!.description!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: h! / 40)),
                    const SizedBox(height: 20),
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                        2: IntrinsicColumnWidth()
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: colors.primary, width: 4))),
                                child: Text(
                                    'Wind speed: ${weatherController.weather!.windSpeed!}m/s'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: colors.primary, width: 4))),
                                child: Text(
                                    'Pressure: ${weatherController.weather!.pressure!}hPa'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: colors.primary, width: 4))),
                                child: Text(
                                    'Humidity: ${weatherController.weather!.humidity!}%'),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget desktopContainer() {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Weather App',
                        style: TextStyle(
                            fontSize: w! / 20,
                            fontWeight: FontWeight.bold,
                            color: colors.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                          'Check the temperature and weather conditions',
                          style: TextStyle(
                              fontSize: h! / 32, color: Colors.grey.shade600),
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _controller,
                              textInputAction: TextInputAction.done,
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? "This field can not be empty"
                                    : null;
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Enter city...'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                              style: borderedButtonStyle,
                              onPressed: () => {
                                    if (_formKey.currentState?.validate() ??
                                        false)
                                      {
                                        weatherController.getWeatherData(
                                            city: _controller.value.text)
                                      }
                                  },
                              icon: Icon(Icons.search, color: colors.primary),
                              label: Text(
                                'Search',
                                style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Obx(() {
                if (weatherController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!weatherController.isLoading.value &&
                    weatherController.weather == null) {
                  return Container();
                } else {
                  return Column(
                    children: [
                      Text(
                        DateFormat('MMMM dd, yyyy HH:mm:ss').format(
                            DateTime.now().toUtc().add(Duration(
                                seconds:
                                    weatherController.weather!.timezone!))),
                        style:
                            TextStyle(fontSize: h! / 36, color: colors.primary),
                      ),
                      Center(child: weatherController.icon!),
                      Text('${weatherController.weather!.city}',
                          style: TextStyle(
                              fontSize: h! / 20,
                              fontWeight: FontWeight.w400,
                              color: colors.primary)),
                      Text('${weatherController.weather!.temp!}°C',
                          style: TextStyle(fontSize: h! / 20)),
                      Text(weatherController.weather!.description!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: h! / 36)),
                      const SizedBox(height: 20),
                      Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: IntrinsicColumnWidth(),
                          1: IntrinsicColumnWidth(),
                          2: IntrinsicColumnWidth()
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: colors.primary,
                                              width: 4))),
                                  child: Text(
                                      'Wind speed: ${weatherController.weather!.windSpeed!}m/s'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: colors.primary,
                                              width: 4))),
                                  child: Text(
                                      'Pressure: ${weatherController.weather!.pressure!}hPa'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: colors.primary,
                                              width: 4))),
                                  child: Text(
                                      'Humidity: ${weatherController.weather!.humidity!}%'),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  );
                }
              }))
        ],
      ),
    );
  }
}
