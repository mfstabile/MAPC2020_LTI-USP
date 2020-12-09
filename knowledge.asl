////////////////////////////////ADDING TASKBOARD///////////////////////////////////////////
+thing(XTask,YTask,taskboard,_,Time) : position(XAg,YAg,Time) & not taskboard(XTask+XAg,YTask+YAg)
<-  +taskboard(XTask+XAg,YTask+YAg);
    .print("Adding taskboard 1");
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,taskboard(XTask+XAg+XMapper, YTask+YAg+YMapper));
    }
    .

+thing(XTask,YTask,taskboard,_,Time) : not position(XAg,YAg,Time)
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(taskboard(XTask+XAg,YTask+YAg),0)){
        +taskboard(XTask+XAg,YTask+YAg);
        .print("Adding taskboard 2");
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,taskboard(XTask+XAg+XMapper, YTask+YAg+YMapper));
        };
    }.

////////////////////////////////ADDING DISPENSER///////////////////////////////////////////
+thing(XDisp,YDisp,dispenser,DispType,Time) : position(XAg,YAg,Time) & not dispenser(XDisp+XAg,YDisp+YAg,DispType)
<-  +dispenser(XDisp+XAg,YDisp+YAg,DispType);
    .print("Adding dispenser 1 ",DispType);
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,dispenser(XDisp+XAg+XMapper, YDisp+YAg+YMapper, DispType));
    }
    .

+thing(XDisp,YDisp,dispenser,DispType,Time) : not position(XAg,YAg,Time)
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(dispenser(XDisp+XAg,YDisp+YAg,DispType),0)){
        +dispenser(XDisp+XAg,YDisp+YAg,DispType);
        .print("Adding dispenser 2 ",DispType);
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,dispenser(XDisp+XAg+XMapper, YDisp+YAg+YMapper, DispType));
        };
    }.

////////////////////////////////ADDING GOAL///////////////////////////////////////////
+goal(XGoal,YGoal,Time) : position(XAg,YAg,Time) & not goal(XGoal+XAg,YGoal+YAg)
<-  +goal(XGoal+XAg,YGoal+YAg);
    .print("Adding goal 1");
    for ( mapper(Sender, XMapper, YMapper) ) {
      .send(Sender,tell,goal(XGoal+XAg+XMapper, YGoal+YAg+YMapper));
    }
    .

+goal(XGoal,YGoal,Time) : not position(XAg,YAg,Time)
<-  .wait("+position(XAg,YAg,Time)");
    ?position(XAg,YAg,Time);
    if (.count(goal(XGoal+XAg,YGoal+YAg),0)){
        +goal(XGoal+XAg,YGoal+YAg);
        .print("Adding goal 2");
        for ( mapper(Sender, XMapper, YMapper) ) {
          .send(Sender,tell,goal(XGoal+XAg+XMapper, YGoal+YAg+YMapper));
        };
    }.
