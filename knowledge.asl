////////////////////////////////ADDING TASKBOARD///////////////////////////////////////////
+thing(XTask,YTask,taskboard,_,Time) : position(XAg,YAg,Time) & not taskboard(XTask+XAg,YTask+YAg)
<-  +taskboard(XTask+XAg,YTask+YAg);
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,taskboard(XTask+XAg+XMapper, YTask+YAg+YMapper));
    }
    .

+thing(XTask,YTask,taskboard,_,Time) : not position(XAg,YAg,Time)
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(taskboard(XTask+XAg,YTask+YAg),0)){
        +taskboard(XTask+XAg,YTask+YAg);
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,taskboard(XTask+XAg+XMapper, YTask+YAg+YMapper));
        };
    }.

////////////////////////////////ADDING DISPENSER///////////////////////////////////////////
+thing(XDisp,YDisp,dispenser,DispType,Time) : position(XAg,YAg,Time) & not dispenser(XDisp+XAg,YDisp+YAg,DispType)
// +thing(XDisp,YDisp,dispenser,DispType,Time) : position(XAg,YAg,Time) & not dispenser(_,_,DispType)
<-  +dispenser(XDisp+XAg,YDisp+YAg,DispType);
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,dispenser(XDisp+XAg+XMapper, YDisp+YAg+YMapper, DispType));
    }
    .

+thing(XDisp,YDisp,dispenser,DispType,Time) : not position(XAg,YAg,Time)
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(dispenser(XDisp+XAg,YDisp+YAg,DispType),0)){
    // if (.count(dispenser(_,_,DispType),0)){
        +dispenser(XDisp+XAg,YDisp+YAg,DispType);
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,dispenser(XDisp+XAg+XMapper, YDisp+YAg+YMapper, DispType));
        };
    }.

////////////////////////////////ADDING GOAL///////////////////////////////////////////
+goal(XGoal,YGoal,Time) :
    position(XAg,YAg,Time) & not goal(XGoal+XAg,YGoal+YAg) &
    (
    (not goal(XGoal-1,YGoal,Time) & not goal(XGoal+1,YGoal,Time) & not goal(XGoal,YGoal-1,Time) & goal(XGoal,YGoal+1,Time)) |
    (not goal(XGoal-1,YGoal,Time) & not goal(XGoal+1,YGoal,Time) & not goal(XGoal,YGoal+1,Time) & goal(XGoal,YGoal-1,Time)) |
    (not goal(XGoal,YGoal-1,Time) & not goal(XGoal,YGoal+1,Time) & not goal(XGoal-1,YGoal,Time) & goal(XGoal+1,YGoal,Time)) |
    (not goal(XGoal,YGoal-1,Time) & not goal(XGoal,YGoal+1,Time) & not goal(XGoal+1,YGoal,Time) & goal(XGoal-1,YGoal,Time)) ) &
    ((XGoal)**2 + (YGoal)**2)**(0.5) < 3
    // goal(XGoal+1,YGoal,Time) &
    // goal(XGoal-1,YGoal,Time) &
    // goal(XGoal,YGoal+1,Time) &
    // goal(XGoal,YGoal-1,Time) &

<-  +goal(XGoal+XAg,YGoal+YAg);
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,goal(XGoal+XAg+XMapper, YGoal+YAg+YMapper));
    }
    .

+goal(XGoal,YGoal,Time) :
    (
    (not goal(XGoal-1,YGoal,Time) & not goal(XGoal+1,YGoal,Time) & not goal(XGoal,YGoal-1,Time) & goal(XGoal,YGoal+1,Time)) |
    (not goal(XGoal-1,YGoal,Time) & not goal(XGoal+1,YGoal,Time) & not goal(XGoal,YGoal+1,Time) & goal(XGoal,YGoal-1,Time)) |
    (not goal(XGoal,YGoal-1,Time) & not goal(XGoal,YGoal+1,Time) & not goal(XGoal-1,YGoal,Time) & goal(XGoal+1,YGoal,Time)) |
    (not goal(XGoal,YGoal-1,Time) & not goal(XGoal,YGoal+1,Time) & not goal(XGoal+1,YGoal,Time) & goal(XGoal-1,YGoal,Time)) ) &
    // goal(XGoal+1,YGoal,Time) &
    // goal(XGoal-1,YGoal,Time) &
    // goal(XGoal,YGoal+1,Time) &
    // goal(XGoal,YGoal-1,Time) &
    not position(XAg,YAg,Time) &
    ((XGoal)**2 + (YGoal)**2)**(0.5) < 3
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(goal(XGoal+XAg,YGoal+YAg),0)){
        +goal(XGoal+XAg,YGoal+YAg);
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,goal(XGoal+XAg+XMapper, YGoal+YAg+YMapper));
        };
    }.
