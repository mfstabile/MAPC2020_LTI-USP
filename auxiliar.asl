+?canAssist(TaskOwnerName,Answer) : .my_name(MyName) & not taskowner(MyName) & not auxiliar(MyName,_)
<-  +auxiliar(MyName,TaskOwnerName);
    .broadcast(tell,auxiliar(MyName,TaskOwnerName));
    .print("Assisting -> ", TaskOwnerName);
    Answer = true.

+?canAssist(TaskOwnerName,Answer) <- Answer = false.

///////////////////////////////////////////////////////////////////////////
+!goAssist(XAgentPosition,YAgentPosition,BlockType,BlockDirection)
<-  +blockType(BlockType);
    !goToDispenser(BlockType);
    !getBlock;
    .my_name(MyName);
    ?auxiliar(MyName,TaskOwnerName);
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
    !clearBlockAuxiliar;
    .print("Deveria ter apagado bloco");
    .abolish(carrying(_,_,_));
    .print("Deadline Auxiliar 3");

    // .wait("+nunca");

    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .print("Erasing auxiliar to ",TaskOwnerName);
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    Answer = false.

+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & not task(TaskName,_,_,_,_) & carrying(_,_,_)
<-  !setupBlock(s);
    !performAction(detach(s));
    !clearBlockAuxiliar;
    .abolish(carrying(_,_,_));
    .print("Deadline Auxiliar 4");
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .print("Erasing auxiliar to ",TaskOwnerName);
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    Answer = false.

+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & task(TaskName,Deadline,_,_,_) & step(Step, _) & Step > Deadline
  <- .print("Deadline Auxiliar 1");
     .abolish(ownerPositioned);
     .abolish(blockType(_));
     .abolish(auxiliar(MyName,TaskOwnerName));
     .print("Erasing auxiliar to ",TaskOwnerName);
     .broadcast(untell,auxiliar(MyName,TaskOwnerName));
     Answer = false.
+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & not task(TaskName,Deadline,_,_,_) & step(Step, _)
  <- .print("Deadline Auxiliar 2");
     .abolish(ownerPositioned);
     .abolish(blockType(_));
     .abolish(auxiliar(MyName,TaskOwnerName));
     .print("Erasing auxiliar to ",TaskOwnerName);
     .broadcast(untell,auxiliar(MyName,TaskOwnerName));
     Answer = false.
+?checkDeadline(Answer) : .my_name(MyName) & auxiliar(MyName,TaskOwnerName) & acceptedTask(TaskOwnerName, TaskName) & task(TaskName,Deadline,_,_,_) & step(Step, _) <- Answer = true.
///////////////////////////////////////////////////////////////////////////
+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : carrying(_,_,_)
<-  +blockType(BlockType);
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .my_name(MyName);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip.

+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : not carrying(_,_,_)
<-  +blockType(BlockType);
    !goToDispenser(BlockType);
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
<-  ?checkDeadline(Answer);
    if(Answer){
      ?carrying(XBlock,YBlock,_);
      !performAction(connect(TaskOwnerName,XBlock,YBlock));
      ?lastActionResult(success,Time);
      ?lastAction(connect,Time);
      ?getDirection(XBlock,YBlock,Direction);
      !performAction(detach(Direction));
    }
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    !!startMovement.

-!connectAuxiliar <- !connectAuxiliar.

///////////////////////////////////////////////////////////////////////////
+?getDirection(0,1,s).
+?getDirection(0,-1,n).
+?getDirection(1,0,e).
+?getDirection(-1,0,w).

///////////////////////////////////////////////////////////////////////////

+!clearBlockAuxiliar : carrying(X,Y,T) & not thing(X,Y,block,_,T) <- -carrying(X,Y,T).
+!clearBlockAuxiliar : thing(X,Y,entity,_,_) & (X\==0 | Y\==0) <- !moveToEmptySpace;!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(0,1,T) & thing(0,1,block,_,T) <- !performAction(clear(1,1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(1,0,T) & thing(1,0,block,_,T) <- !performAction(clear(1,1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(0,-1,T) & thing(0,-1,block,_,T) <- !performAction(clear(-1,-1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(-1,0,T) & thing(-1,0,block,_,T) <- !performAction(clear(-1,-1));!clearBlockAuxiliar.

///////////////////////////////////STOP AND RESTART////////////////////////////////////////
+!stopAndRestart : carrying(X, Y, Time) & .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  !clearBlockAuxiliar;
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    !!startMovement.

+!stopAndRestart : .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    !!startMovement.
