import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Color bgcolor = Color(0xFFF6F8FE);
  Color secondry = Color(0xFFECEFF9);
  Color highlight = Color(0xFFE7EBF7);

  List<dynamic> LapsList = [
    {'lap' : 'LAP 1','time' : '00:00:56'},
    {'lap' : 'LAP 2','time' : '00:03:37'},
    {'lap' : 'LAP 3','time' : '00:04:56'},
    {'lap' : 'LAP 4','time' : '00:09:37'},
    {'lap' : 'LAP 5','time' : '02:01:47'}
  ];

  Timer? _timer;
  Duration _elapsedTime = Duration.zero;


  bool isStart = false;
  bool ispause = false;

  String timeFormate(Duration _duration) {
    // 1:23:5 => 01:23:05
    String twodigited(int n) => n.toString().padLeft(2,'0');
    String Hour = twodigited(_duration.inHours);
    String Min = twodigited(_duration.inMinutes.remainder(60));
    String Sec = twodigited(_duration.inSeconds.remainder(60));
    return '$Hour:$Min:$Sec';

  }

  void StarWatch() {
    // on Stopwatch Start

    if (isStart) {

        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
                  _elapsedTime += Duration(seconds: 1);
                  
          });

        });


    }
    
    setState(() {
      isStart = true;
    });

  }

  void PauseWatch() {
    _timer?.cancel();
    setState(() {
      ispause = true;
      isStart = false;
    });
  }

  void Reset() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    LapsList.clear();
    setState(() {
      isStart = false;
      ispause = false;
    });

  }

  void Stop() {
    _timer?.cancel();
    _elapsedTime = Duration.zero;
    setState(() {
      isStart = false;
      ispause = false;
    });

  }

  void Laps() {
    LapsList.add({'lap' : 'LAP ${LapsList.length + 1}','time' : timeFormate(_elapsedTime)});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      // appbar
      appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 25, top : 20),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              ),
            ),
            title: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15, right: 55, bottom: 5),
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: secondry,
                        borderRadius: BorderRadius.circular(360)
                    ),
                    child: Center(
                      child: Text(
                        'StopWatch',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),

                  ),)
            )



        ),

      // body
      body: Column(
        children: [
          //Timer
          Padding(
            padding: EdgeInsets.only(top: 110),
            child: Center(
              child: InkWell(
                onTap: () {
                  if (isStart) {
                    Laps();
                  }
                },
                child: Container(
                    height: 270,
                    width: 270,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(360),
                        boxShadow: List.filled(10, BoxShadow(
                            color: highlight,
                            blurRadius:30
                        ))
                    ),
                    child: Center(
                      child: Text(
                        timeFormate(_elapsedTime),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontFamily: 'Redex'
                        ),
                      ),
                    )

                ),
              )
            ),
          ),

          // List - laps
          Container(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              itemCount: LapsList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 80
              ),
              itemBuilder: (context, index) {
                final _lapsItem = LapsList[index];
                return Padding(
                  padding: EdgeInsets.only(top: 30,left: 10,right: 5),
                  child: Container(
                    height: 120,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(padding: EdgeInsets.only(top: 10,right: 10),
                              child: Icon(
                                Icons.delete,
                                size: 20,
                                color: highlight,
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            _lapsItem['lap'],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Redex',
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                            _lapsItem['time'],
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: 'Ubuntu',
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                );
              },
            ),
          ),

          Spacer(),

          Padding(
              padding: EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [

                // Button 1 - Start, pause, resume
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      if (isStart)  {
                        PauseWatch();
                      }else {
                      isStart = true;
                      StarWatch();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isStart ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.grey.shade300,
                            size: 35,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            isStart ? 'PAUSE':ispause? 'RESUME':'START',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 19,
                              fontFamily: 'Ubuntu',
                            ),
                          )
                        ],
                      ),

                    ),
                  )
                ),

                Spacer(),

                // Button 2 - Reset, stop
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      if (isStart) {
                        Stop();
                      } else {
                        Reset();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isStart? Icons.stop_rounded : Icons.restart_alt,
                            color: Colors.grey.shade300,
                            size: 35,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            isStart? 'STOP': 'RESET',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 19,
                              fontFamily: 'Ubuntu',
                            ),
                          )
                        ],
                      ),

                    ),
                  )
                )

              ],
            ),
          )


        ],
      ),
    );
  }
}
