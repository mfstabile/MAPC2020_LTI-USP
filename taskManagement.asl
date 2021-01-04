+!achieveTask
<-  .print("Achieving");
    !goToTaskboard;
    !getTask;
    ?accepted(TaskName,_);
    ?task(TaskName,_,_,Requirements,_);
    .length(Requirements, RequirementsSize);
    !executeTask(RequirementsSize);
    .print("Task Achieved").

+!executeTask(1)
<-  !goToDispenser(1);
    !getBlock;
    !goToGoal;
    !setupBlock(s);
    !checkGoalPosition;
    !submitTask;
    .abolish(carrying(_,_,_));
    !!achieveTask.

+!executeTask(2)
<-  !chooseGoal(XGoal,YGoal);
    !chooseAgent;
    !setAvailableRequirements;
    .my_name(MyName);
    ?auxiliar(AuxiliarAgentName,MyName);
    !sendInstructions(AuxiliarAgentName, XGoal, YGoal);
    !getOwnerBlockType(BlockType);
    !goToDispenser(BlockType);
    !getBlock;
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XGoal,YGoal);
    !carryBlock;
    !setupBlock(s);
    !checkObstacleAuxiliarArea;
    .send(AuxiliarAgentName,tell,ownerPositioned);
    // !checkThingAuxiliarArea;
    !waitAuxiliar;
    !checkSetup;
    !connect;
    !submitTask;
    .abolish(carrying(_,_,_));
    .print("Deveria ter entregue a task");
    !clearSubmittedInformation;
    !!achieveTask;
.

+!skip <- !performAction(skip);!skip.

///////////////////////////////////////////////////////////////////////////
+!goToTaskboard
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XTask-MyX)**2)+((YTask-MyY)**2),XTask,YTask),taskboard(XTask,YTask),TaskList);
    .min(TaskList,g(Dist,XNearTask,YNearTask));
    !goToPosition(XNearTask, YNearTask).

///////////////////////////////////////////////////////////////////////////
+!getTask
<-  .findall(IntTaskNumber,task(TaskName,_,_,_,_) & not acceptedTask(_,TaskName) & .delete("task",TaskName,TaskNumber) & .term2string(IntTaskNumber,TaskNumber),TaskNameList);
    if(.empty(TaskNameList))
    {
      !performAction(skip);
      !getTask;
    }
    else{
      .max(TaskNameList,MaxTaskNumber);
      .concat("task",MaxTaskNumber,MaxTask);
      !performAction(accept(MaxTask));
      .term2string(MaxTaskTerm,MaxTask);
      !verifyAccepted(MaxTaskTerm);
    }.


+!verifyAccepted(MaxTask) : accepted(MaxTask,_)
<-  .my_name(MyName);
    .broadcast(tell,acceptedTask(MyName, MaxTask)).

+!verifyAccepted(MaxTask) <- !getTask.

///////////////////////////////////////////////////////////////////////////
+!goToDispenser(1) : accepted(TaskName,_) & task(TaskName,_,_,[req(0,1,DispType)],_)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XDisp-MyX)**2)+((YDisp-MyY)**2),XDisp,YDisp),dispenser(XDisp,YDisp,DispType),DispList);
    .min(DispList,g(Dist,XNearDisp,YNearDisp));
    !goToPosition(XNearDisp, YNearDisp).

///////////////////////////////////////////////////////////////////////////
+!goToDispenser(BlockType) : dispenser(_,_,BlockType)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XDisp-MyX)**2)+((YDisp-MyY)**2),XDisp,YDisp),dispenser(XDisp,YDisp,BlockType),DispList);
    .min(DispList,g(Dist,XNearDisp,YNearDisp));
    !goToPosition(XNearDisp, YNearDisp).

+!goToDispenser(BlockType)
<-  .my_name(MyName);
    ?auxiliar(MyName,TaskOwnerName);
    .send(TaskOwnerName,askOne,dispenser(XDispenser,YDispenser,BlockType));
    ?mapper(TaskOwnerName,XMapper,YMapper);
    +dispenser(XDispenser-XMapper,YDispenser-YMapper,BlockType);
    !goToPosition(XDispenser-XMapper,YDispenser-YMapper).

///////////////////////////////////////////////////////////////////////////
+!getBlock
<-  ?checkDeadline(Active);
    if(Active){
      !shift(Direction);
      !requestBlock(Direction);
      !attachBlock(Direction);
    }.

+!shift(Direction) :  not blocked(s) <- !performAction(move(s)); ?thing(0,-1,dispenser,_,_); Direction = n.
+!shift(Direction) :  not blocked(n) <- !performAction(move(n)); ?thing(0,1,dispenser,_,_); Direction = s.
+!shift(Direction) :  not blocked(e) <- !performAction(move(e)); ?thing(-1,0,dispenser,_,_); Direction = w.
+!shift(Direction) :  not blocked(w) <- !performAction(move(w)); ?thing(1,0,dispenser,_,_); Direction = e.

-!shift(Direction) <- !shift(Direction).

+!requestBlock(n) <- !performAction(request(n));?thing(0,-1,block,_,_).
+!requestBlock(s) <- !performAction(request(s));?thing(0,1,block,_,_).
+!requestBlock(e) <- !performAction(request(e));?thing(1,0,block,_,_).
+!requestBlock(w) <- !performAction(request(w));?thing(-1,0,block,_,_).

-!requestBlock(Direction) <- !requestBlock(Direction).

+!attachBlock(n) : step(_,Time) <- !performAction(attach(n));?attached(0,-1,_);+carrying(0,-1,Time).
+!attachBlock(s) : step(_,Time) <- !performAction(attach(s));?attached(0,1,_);+carrying(0,1,Time).
+!attachBlock(e) : step(_,Time) <- !performAction(attach(e));?attached(1,0,_);+carrying(1,0,Time).
+!attachBlock(w) : step(_,Time) <- !performAction(attach(w));?attached(-1,0,_);+carrying(-1,0,Time).

-!attachBlock(Direction) <- !attachBlock(Direction).

///////////////////////////////////////////////////////////////////////////
+!goToGoal
<-  ?checkDeadline(Active);
    ?hasBlock(HasBlock);
    if(Active & HasBlock){
      ?getLastPosition(MyX,MyY);
      .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal),GoalList);
      .min(GoalList,g(Dist,XNearGoal,YNearGoal));
      .abolish(carryBlockTo(_,_));
      +carryBlockTo(XNearGoal,YNearGoal);
      !carryBlock;
    }.
///////////////////////////////////////////////////////////////////////////
+!chooseGoal(XNearGoal,YNearGoal)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal),GoalList);
    .min(GoalList,g(Dist,XNearGoal,YNearGoal)).

///////////////////////////////////////////////////////////////////////////

+!checkGoalPosition : goal(0,0,_) <- true.
+!checkGoalPosition
<-  ?checkDeadline(Active);
    ?hasBlock(HasBlock);
    if(Active & HasBlock){
      !goToGoal;
      !setupBlock(s);
      !checkGoalPosition;
    }.
///////////////////////////////////////////////////////////////////////////
+!submitTask : accepted(TaskName,_) & task(TaskName,_,_,_,_)
<-  ?checkDeadline(Active);
    ?hasBlock(HasBlock);
    if(Active & HasBlock){
      !performAction(submit(TaskName));
      .count(task(TaskName,_,_,_,_), 0);
      .print("Task submitted ",TaskName);
    }else{
      .print("submit failed ", Active, HasBlock);
    }.

+!submitTask
<-  ?checkDeadline(Active);
    ?hasBlock(HasBlock);
    .

-!submitTask <- !submitTask.

///////////////////////////////////////////////////////////////////////////
+!clearBlock : not thing(0,1,block,_,_) <- true.
+!clearBlock : thing(X,Y,entity,_,_) & (X\==0 | Y\==0) <- !moveToEmptySpace;!clearBlock.
+!clearBlock : thing(0,1,block,_,_) <- !performAction(clear(1,1));!clearBlock.

+!moveToEmptySpace
<- .random(Number);
    if(Number <0.25){
    	!performAction(move(n));
    }
    elif(Number < 0.5){
    	!performAction(move(s));
    }
    elif(Number < 0.75){
    	!performAction(move(w));
    }
    else {
    	!performAction(move(e));
    }.

+?checkDeadline(Answer) : accepted(TaskName,_) & task(TaskName,Deadline,_,_,_) & step(Step, _) & Step > Deadline & carrying(_,_,_)
<-  .print("Entrando no check deadline");
    !setupBlock(s);
    .print("Bloco deveria estar no sul");
    !clearBlock;
    .print("Deveria ter apagado bloco");
    .abolish(carrying(_,_,_));
    .print("Deadline 3");
    Answer = false.

+?checkDeadline(Answer) : accepted(TaskName,_) & not task(TaskName,_,_,_,_) & carrying(_,_,_)
<-  !setupBlock(s);
    !performAction(detach(s));
    !clearBlock;
    .abolish(carrying(_,_,_));
    .print("Deadline 4");
    Answer = false.

+?checkDeadline(Answer) : accepted(TaskName,_) & task(TaskName,Deadline,_,_,_) & step(Step, _) & Step > Deadline <- .print("Deadline 1");Answer = false.
+?checkDeadline(Answer) : accepted(TaskName,_) & not task(TaskName,Deadline,_,_,_) & step(Step, _) <- .print("Deadline 2");Answer = false.
+?checkDeadline(Answer) : accepted(TaskName,_) & task(TaskName,Deadline,_,_,_) & step(Step, _) <- Answer = true.

+?hasBlock(Answer) : step(_,Time) & not carrying(_,_,Time) <- .wait("+carrying(_,_,Time)",10,Arg);?hasBlock(Answer).
+?hasBlock(Answer) : carrying(XBlock,YBlock,Time) & thing(XBlock,YBlock,block,_,Time) <- Answer = true.
+?hasBlock(Answer) : carrying(XBlock,YBlock,Time) & not thing(XBlock,YBlock,block,_,Time) <- Answer = false.
+?hasBlock(Answer) <- Answer = false.

///////////////////////////////////////////////////////////////////////////
+!chooseAgent
<-  .findall(AgentName, mapper(AgentName,_,_), AllAgents);
    .findall(AgentName, taskowner(AgentName) | auxiliar(AgentName,_), BusyAgentList);
    .difference(AllAgents,BusyAgentList,AvailableAgents);
    if(.empty(AvailableAgents)){
      !performAction(skip);
      !chooseAgent;
    }
    else{
      .nth(0,AvailableAgents,AuxiliarAgent);
      .my_name(MyName);
      .send(AuxiliarAgent,askOne,canAssist(MyName,Answer),canAssist(MyName, Answer));
      if(not Answer){
        !chooseAgent;
      }
    }.

///////////////////////////////////////////////////////////////////////////
+!setAvailableRequirements
<-  ?accepted(TaskName,_);
    ?task(TaskName,_,_,Requirements,_);
    .delete(req(0,1,_),Requirements,RemainingRequirements);
    +requirementAvailable(RemainingRequirements).
///////////////////////////////////////////////////////////////////////////
+!sendInstructions(AuxiliarAgentName, XGoal, YGoal)
<-  ?requirementAvailable(AvailableRequirements);
    .nth(0,AvailableRequirements, req(XBlock,YBlock,BlockType));
    .delete(req(XBlock,YBlock,BlockType),AvailableRequirements,RemainingRequirements);
    .abolish(requirementAvailable(AvailableRequirements));
    if(not .empty(RemainingRequirements)){
      +requirementAvailable(RemainingRequirements);
    };
    ?mapper(AuxiliarAgentName,XMapper,YMapper);
    if(XBlock == 0){
      XAgentPosition = XGoal+XBlock+XMapper-1;
      YAgentPosition = YGoal+YBlock+YMapper;
      Direction = e;
    }else{
      XAgentPosition = XGoal+XBlock+XMapper;
      YAgentPosition = YGoal+YBlock+YMapper-1;
      Direction = s;
    }
    .send(AuxiliarAgentName,unachieve,startMovement);
    .send(AuxiliarAgentName,achieve,goAssist(XAgentPosition,YAgentPosition,BlockType,Direction));
    +auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType).

///////////////////////////////////////////////////////////////////////////

+!getOwnerBlockType(BlockType)
<-  ?accepted(TaskName,_);
    ?task(TaskName,_,_,Requirements,_);
    .findall(BType, .member(req(0,1,BType),Requirements), BTypeList);
    .nth(0,BTypeList,BlockType).

///////////////////////////////////////////////////////////////////////////
+!waitAuxiliar : .my_name(MyName) & auxiliar(Auxiliar1,MyName) & auxiliar(Auxiliar2,MyName) & Auxiliar1 \== Auxiliar2
<-  ?readyToConnect(Auxiliar1);
    ?readyToConnect(Auxiliar2).

+!waitAuxiliar : .my_name(MyName) & auxiliar(Auxiliar1,MyName)
<-  ?readyToConnect(Auxiliar1).

-!waitAuxiliar <- !performAction(skip);!waitAuxiliar.
///////////////////////////////////////////////////////////////////////////
+!checkSetup: accepted(TaskName,_) & task(TaskName,_,_,Requirements,_)
<-  for ( .member(req(XBlock,YBlock,BlockType),Requirements) ) {         // iteration
      ?thing(XBlock,YBlock,block,BlockType,_);
    };
    .

-!checkSetup <- !fixSetup.
///////////////////////////////////////////////////////////////////////////
+!fixSetup : auxiliarPosition(AuxiliarAgentName1,XAgentPosition1,YAgentPosition1,Direction1,BlockType) &
             auxiliarPosition(AuxiliarAgentName2,XAgentPosition2,YAgentPosition2,Direction2,BlockType) &
             AuxiliarAgentName1 \== AuxiliarAgentName2
<-  .my_name(MyName);
    .abolish(readyToConnect(_));
    .send(AuxiliarAgentName1,unachieve, skip);
    .send(AuxiliarAgentName2,unachieve, skip);
    .send(AuxiliarAgentName1,achieve,fixAuxiliarSetup(XAgentPosition1,YAgentPosition1,Direction1,MyName,BlockType));
    .send(AuxiliarAgentName2,achieve,fixAuxiliarSetup(XAgentPosition2,YAgentPosition2,Direction2,MyName,BlockType));
    !waitAuxiliar;
    .

+!fixSetup : auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType)
<-  .my_name(MyName);
    .abolish(readyToConnect(_));
    .send(AuxiliarAgentName,unachieve, skip);
    .send(AuxiliarAgentName,achieve,fixAuxiliarSetup(XAgentPosition,YAgentPosition,Direction,MyName,BlockType));
    !waitAuxiliar;
    .
///////////////////////////////////////////////////////////////////////////
+!connect : .my_name(MyName) & auxiliar(Auxiliar,MyName)
<-  .send(Auxiliar,unachieve, skip);
    .send(Auxiliar,achieve,connectAuxiliar);
    !connectOwner(Auxiliar).

+!connectOwner(Auxiliar)
<-  !performAction(connect(Auxiliar,0,1));
    ?lastActionResult(success,Time);
    ?lastAction(connect,Time).

-!connectOwner(Auxiliar)<-!connectOwner(Auxiliar).

///////////////////////////////////////////////////////////////////////////
+!checkObstacleAuxiliarArea : accepted(TaskName,_) &
                      task(TaskName,_,_,Requirements,_) &
                      auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType) &
                      mapper(AuxiliarAgentName,XMapper,YMapper)
<-  .delete(req(0,1,_),Requirements,[req(XBlock,YBlock,_)]);
    .count(obstacle(XBlock,YBlock,_), BlockObstacle);
    ?getLastPosition(MyX,MyY);
    XAuxiliar = XAgentPosition - XMapper - MyX;
    YAuxiliar = YAgentPosition - YMapper - MyY;
    .count(obstacle(XAuxiliar,YAuxiliar,_), AuxiliarObstacle);
    if(BlockObstacle>0 | AuxiliarObstacle > 0){
        .print("Goal Area is blocked");
        +goalChanged;
        !fixSubmitPosition;
        !checkObstacleAuxiliarArea;
    }elif(.count(goalChanged,Changed) & Changed > 0){
        .print("Goal Area unblocked successfully");
        .send(AuxiliarAgentName,unachieve, goAssist(_,_,_,_));
        .send(AuxiliarAgentName,unachieve, fixAuxiliarSetup(_,_,_,_,_));
        .my_name(MyName);
        if(XBlock == 0){
          XAgentPositionNew = MyX+XBlock+XMapper-1;
          YAgentPositionNew = MyY+YBlock+YMapper;
          DirectionNew = e;
        }else{
          XAgentPositionNew = MyX+XBlock+XMapper;
          YAgentPositionNew = MyY+YBlock+YMapper-1;
          DirectionNew = s;
        }
        .abolish(auxiliarPosition(AuxiliarAgentName,_,_,_,_));
        +auxiliarPosition(AuxiliarAgentName,XAgentPositionNew,YAgentPositionNew,DirectionNew,BlockType);
        .send(AuxiliarAgentName,achieve,fixAuxiliarSetup(XAgentPositionNew,YAgentPositionNew,DirectionNew,MyName,BlockType));
    }.

+!fixSubmitPosition : goal(0,-1,Time)
<-  !performAction(move(n)).

+!fixSubmitPosition : goal(1,0,Time)
<-  !performAction(move(e)).

+!fixSubmitPosition : goal(-1,0,Time)
<-  !performAction(move(w)).

+!fixSubmitPosition : goal(0,1,Time)
<-  !performAction(move(w)).

///////////////////////////////////////////////////////////////////////////

+!checkThingAuxiliarArea : accepted(TaskName,_) &
                      task(TaskName,_,_,Requirements,_) &
                      auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType) &
                      mapper(AuxiliarAgentName,XMapper,YMapper)
<-  .delete(req(0,1,_),Requirements,[req(XBlock,YBlock,_)]);
    .count(obstacle(XBlock,YBlock,_), BlockObstacle);
    ?getLastPosition(MyX,MyY);
    XAuxiliar = XAgentPosition - XMapper - MyX;
    YAuxiliar = YAgentPosition - YMapper - MyY;
    .count(obstacle(XAuxiliar,YAuxiliar,_), AuxiliarObstacle);
    if(BlockObstacle>0 | AuxiliarObstacle > 0){
        .print("Goal Area is blocked");
        +goalChanged;
        !fixSubmitPosition;
        !checkObstacleAuxiliarArea;
    }elif(.count(goalChanged,Changed) & Changed > 0){
        .print("Goal Area unblocked successfully");
        .send(AuxiliarAgentName,unachieve, goAssist(_,_,_,_));
        .my_name(MyName);
        if(XBlock == 0){
          XAgentPositionNew = MyX+XBlock+XMapper-1;
          YAgentPositionNew = MyY+YBlock+YMapper;
          DirectionNew = e;
        }else{
          XAgentPositionNew = MyX+XBlock+XMapper;
          YAgentPositionNew = MyY+YBlock+YMapper-1;
          DirectionNew = s;
        }
        .abolish(auxiliarPosition(AuxiliarAgentName,_,_,_,_));
        +auxiliarPosition(AuxiliarAgentName,XAgentPositionNew,YAgentPositionNew,DirectionNew,BlockType);
        .send(AuxiliarAgentName,achieve,fixAuxiliarSetup(XAgentPositionNew,YAgentPositionNew,DirectionNew,MyName,BlockType));
    }.

///////////////////////////////////////////////////////////////////////////
+!clearSubmittedInformation
<-  .abolish(auxiliarPosition(_,_,_,_,_));
    .abolish(goalChanged);
    .my_name(MyName);
    .broadcast(untell,acceptedTask(MyName, _));
    .abolish(readyToConnect(_)).
