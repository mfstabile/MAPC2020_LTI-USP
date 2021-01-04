+?canAssist(TaskOwnerName,Answer) : .my_name(MyName) & not taskowner(MyName) & not auxiliar(MyName,_)
<-  +auxiliar(MyName,TaskOwnerName);
    .broadcast(tell,auxiliar(MyName,TaskOwnerName));
    .print("Assisting -> ", TaskOwnerName);
    Answer = true.

+?canAssist(TaskOwnerName,Answer) <- Answer = false.

///////////////////////////////////////////////////////////////////////////
+!goAssist(XAgentPosition,YAgentPosition,BlockType,BlockDirection)
<-  !goToDispenser(BlockType);
    !getBlock;
    .my_name(MyName);
    ?auxiliar(MyName,TaskOwnerName);
    ?acceptedTask(TaskOwnerName, TaskName);
    ?task(TaskName,_,_,Requirements,_);
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip.

///////////////////////////////////////////////////////////////////////////
+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & task(TaskName,Deadline,_,_,_) & step(Step, _) & Step > Deadline & carrying(_,_,_)
<-  .print("Entrando no check deadline");
    !setupBlock(s);
    .print("Bloco deveria estar no sul");
    !clearBlock;
    .print("Deveria ter apagado bloco");
    .abolish(carrying(_,_,_));
    .print("Deadline 3");
    -ownerPositioned;.abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    Answer = false.

+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & not task(TaskName,_,_,_,_) & carrying(_,_,_)
<-  !setupBlock(s);
    !performAction(detach(s));
    !clearBlock;
    .abolish(carrying(_,_,_));
    .print("Deadline 4");
    -ownerPositioned;.abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    Answer = false.

+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & task(TaskName,Deadline,_,_,_) & step(Step, _) & Step > Deadline <- .print("Deadline 1");-ownerPositioned;.abolish(auxiliar(MyName,TaskOwnerName));.broadcast(untell,auxiliar(MyName,TaskOwnerName));Answer = false.
+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & not task(TaskName,Deadline,_,_,_) & step(Step, _) <- .print("Deadline 2");-ownerPositioned;.abolish(auxiliar(MyName,TaskOwnerName));.broadcast(untell,auxiliar(MyName,TaskOwnerName));Answer = false.
+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & task(TaskName,Deadline,_,_,_) & step(Step, _) <- Answer = true.
///////////////////////////////////////////////////////////////////////////
+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : carrying(_,_,_)
<-  .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .my_name(MyName);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip.

+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : not carrying(_,_,_)
<-  !goToDispenser(BlockType);
    !getBlock;
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .my_name(MyName);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip.

///////////////////////////////////////////////////////////////////////////
+!connectAuxiliar : .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  ?carrying(XBlock,YBlock,_);
    !performAction(connect(TaskOwnerName,XBlock,YBlock));
    ?lastActionResult(success,Time);
    ?lastAction(connect,Time);
    ?getDirection(XBlock,YBlock,Direction);
    !performAction(detach(Direction));
    -ownerPositioned;.abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    !!startMovement.

-!connectAuxiliar <- !connectAuxiliar.

///////////////////////////////////////////////////////////////////////////
+?getDirection(0,1,s).
+?getDirection(0,-1,n).
+?getDirection(1,0,e).
+?getDirection(-1,0,w).
