+!checkObstacle(Time) :
  obstacle(XObstacle,YObstacle,Time) &
  obstacle(XObstacle+1,YObstacle-1,Time) &
  obstacle(XObstacle+2,YObstacle,Time) &
  not obstacle(XObstacle+1,YObstacle,Time) &
  not thing(XObstacle+1,YObstacle,_,_,Time)
<-  +obstacle(XObstacle+1,YObstacle,Time);
    !checkObstacle(Time).

+!checkObstacle(Time) :
  obstacle(XObstacle,YObstacle,Time) &
  obstacle(XObstacle+1,YObstacle+1,Time) &
  obstacle(XObstacle+2,YObstacle,Time) &
  not obstacle(XObstacle+1,YObstacle,Time) &
  not thing(XObstacle+1,YObstacle,_,_,Time)
<-  +obstacle(XObstacle+1,YObstacle,Time);
    !checkObstacle(Time).

+!checkObstacle(Time) :
  obstacle(XObstacle,YObstacle,Time) &
  obstacle(XObstacle+1,YObstacle+1,Time) &
  obstacle(XObstacle+1,YObstacle-1,Time) &
  not obstacle(XObstacle+1,YObstacle,Time) &
  not thing(XObstacle+1,YObstacle,_,_,Time)
<-  +obstacle(XObstacle+1,YObstacle,Time);
    !checkObstacle(Time).

+!checkObstacle(Time) :
  obstacle(XObstacle,YObstacle,Time) &
  obstacle(XObstacle-1,YObstacle-1,Time) &
  obstacle(XObstacle-1,YObstacle+1,Time) &
  not obstacle(XObstacle-1,YObstacle,Time) &
  not thing(XObstacle-1,YObstacle,_,_,Time)
<-  +obstacle(XObstacle-1,YObstacle,Time);
    !checkObstacle(Time).

+!checkObstacle(Time) <- true.
