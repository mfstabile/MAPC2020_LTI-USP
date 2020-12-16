+!achieveTask
<-  .print("Achieving");
    !goToTaskboard;
    !getTask;
    !goToDispenser;
    !getBlock;
    !goToGoal;
    !setupBlock;
    !checkGoalPosition;
    !submitTask;
    // !achieveTask.
    //!performAction(move(e));
    !skip.

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
+!goToDispenser : accepted(TaskName,_) & task(TaskName,_,_,[req(0,1,DispType)],_)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XDisp-MyX)**2)+((YDisp-MyY)**2),XDisp,YDisp),dispenser(XDisp,YDisp,DispType),DispList);
    .min(DispList,g(Dist,XNearDisp,YNearDisp));
    !goToPosition(XNearDisp, YNearDisp).

///////////////////////////////////////////////////////////////////////////
+!getBlock
<-  !shift(Direction);
    !requestBlock(Direction);
    !attachBlock(Direction).

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
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal),GoalList);
    .min(GoalList,g(Dist,XNearGoal,YNearGoal));
    !carryBlock(XNearGoal,YNearGoal).
///////////////////////////////////////////////////////////////////////////
//block south
+!setupBlock : carrying(0,1,_) <- true.
//block north
+!setupBlock : carrying(0,-1,_) & not blocked(e)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock.
+!setupBlock : carrying(0,-1,_) & not blocked(w)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock.

+!setupBlock : carrying(0,-1,_) & not blockBlocked(n) <- !performAction(move(n));!setupBlock;!performAction(move(s)).
+!setupBlock : carrying(0,-1,_) & not blockBlocked(n) <- !performAction(move(n));!setupBlock;!performAction(move(s)).

+!setupBlock : carrying(0,-1,_) & not blocked(s) <- !performAction(move(s));!setupBlock;!performAction(move(n)).

+!setupBlock : carrying(0,-1,_) <- !performAction(skip);!setupBlock.
//block east
+!setupBlock : carrying(1,0,_) & not blocked(s)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock.

+!setupBlock : carrying(1,0,_) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n));!setupBlock;!performAction(move(s)).

//block west
+!setupBlock : carrying(-1,0,_) & not blocked(s)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock.

+!setupBlock : carrying(-1,0,_) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n));!setupBlock;!performAction(move(s)).
//fail recover

-!setupBlock <- !setupBlock.


///////////////////////////////////////////////////////////////////////////

+!checkGoalPosition : goal(0,0,_) <- true.
+!checkGoalPosition
<-  !goToGoal;
    !setupBlock;
    !checkGoalPosition.
///////////////////////////////////////////////////////////////////////////
//verificar deadline
//verificar se está com bloco
+!submitTask : accepted(TaskName,_) & task(TaskName,_,_,_,_)
<-  !performAction(submit(TaskName));
    .count(task(TaskName,_,_,_,_), 0).

-!submitTask <- !submitTask.
