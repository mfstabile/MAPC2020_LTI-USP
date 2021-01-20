+?canAssist(TaskOwnerName,Answer) : .my_name(MyName) & not taskowner(MyName) & not auxiliar(MyName,_) & mapper(TaskOwnerName,_,_)
<-  +auxiliar(MyName,TaskOwnerName);
    .broadcast(tell,auxiliar(MyName,TaskOwnerName));
    .print("Assisting -> ", TaskOwnerName);
    Answer = true.

+?canAssist(TaskOwnerName,Answer) : .my_name(MyName) & not taskowner(MyName) & not auxiliar(MyName,_) & not mapper(TaskOwnerName,_,_)
<-  Answer = mapper.

+?canAssist(TaskOwnerName,Answer) <- Answer = false.

///////////////////////////////////////////////////////////////////////////
+!goAssist(XAgentPosition,YAgentPosition,BlockType,BlockDirection)
<-  .print("started goAssist");
    +blockType(BlockType);
    !goToDispenser(BlockType);
    !getBlock;
    .my_name(MyName);
    if(auxiliar(MyName,TaskOwnerName)){
      .abolish(carryBlockTo(_,_));
      +carryBlockTo(XAgentPosition,YAgentPosition);
      !carryBlock;
      !setupBlock(BlockDirection);
      .send(TaskOwnerName,tell,readyToConnect(MyName));
      !skip;
    }else{
      !stopAndRestart;
    }.



///////////////////////////////////////////////////////////////////////////
+?hasFixAuxiliarSetup(Answer) : .intend(fixAuxiliarSetup(_,_,_,_,_)) <- Answer=true.
+?hasFixAuxiliarSetup(Answer) <- Answer=false.
///////////////////////////////////////////////////////////////////////////
+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : .intend(fixAuxiliarSetup(_,_,_,_,_)) <- true.

+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : carryingBlock
<-  .print("started fixAuxiliarSetup");
    +blockType(BlockType);
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .my_name(MyName);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip;
    .print("ended fixAuxiliarSetup");.

+!fixAuxiliarSetup(XAgentPosition,YAgentPosition,BlockDirection,TaskOwnerName,BlockType) : not carryingBlock
<-  .print("started fixAuxiliarSetup");
    +blockType(BlockType);
    !goToDispenser(BlockType);
    !getBlock;
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XAgentPosition,YAgentPosition);
    !carryBlock;
    !setupBlock(BlockDirection);
    .my_name(MyName);
    .send(TaskOwnerName,tell,readyToConnect(MyName));
    !skip;
    .print("ended fixAuxiliarSetup");.

///////////////////////////////////////////////////////////////////////////
+!connectAuxiliar : .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  //.print("started connectAuxiliar");
    ?carrying(XBlock,YBlock,_);
    !performAction(connect(TaskOwnerName,XBlock,YBlock));
    ?lastActionResult(success,Time);
    ?lastAction(connect,Time);
    ?getDirection(XBlock,YBlock,Direction);
    !performAction(detach(Direction));
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    !!startMovement.

+!connectAuxiliar //: not auxiliar(MyName,TaskOwnerName)
<-  .print("auxiliar literal not found");
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
+!clearBlockAuxiliar : step(Step,T) & carrying(X,Y,T) & not thing(X,Y,block,_,T) <- .abolish(carrying(X,Y,T)).
+!clearBlockAuxiliar : thing(X,Y,entity,_,_) & (X\==0 | Y\==0) <- !moveToEmptySpace;!clearBlockAuxiliar.
+!clearBlockAuxiliar : step(Step,T) & not carrying(_,_,T) <- .wait("+carrying(_,_,T)",10,Arg); !clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(0,1,T) & thing(0,1,block,_,T) <- !performAction(clear(1,1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(1,0,T) & thing(1,0,block,_,T) <- !performAction(clear(1,1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(0,-1,T) & thing(0,-1,block,_,T) <- !performAction(clear(-1,-1));!clearBlockAuxiliar.
+!clearBlockAuxiliar : carrying(-1,0,T) & thing(-1,0,block,_,T) <- !performAction(clear(-1,-1));!clearBlockAuxiliar.

///////////////////////////////////STOP AND RESTART////////////////////////////////////////
+!stopAndRestart : .intend(goAssist(_,_,_,_)) <- .drop_intention(goAssist(_,_,_,_));!stopAndRestart.
+!stopAndRestart : .intend(fixAuxiliarSetup(_,_,_,_,_)) <- .drop_intention(fixAuxiliarSetup(_,_,_,_,_));!stopAndRestart.
+!stopAndRestart : .intend(connectAuxiliar) <- .drop_intention(connectAuxiliar);!stopAndRestart.

+!stopAndRestart : carrying(X, Y, Time) & .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  !clearBlockAuxiliar;
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    .print("Data cleared");
    !!startMovement;
    .print("Should random walk").

+!stopAndRestart : carrying(X, Y, Time) & .my_name(MyName) & not auxiliar(MyName,TaskOwnerName)
<-  !clearBlockAuxiliar;
    .abolish(ownerPositioned);
    .abolish(blockType(_));
    .print("Data cleared");
    !!startMovement;
    .print("Should random walk").

+!stopAndRestart : .my_name(MyName) & auxiliar(MyName,TaskOwnerName)
<-  .abolish(ownerPositioned);
    .abolish(blockType(_));
    .abolish(auxiliar(MyName,TaskOwnerName));
    .broadcast(untell,auxiliar(MyName,TaskOwnerName));
    .print("Data cleared");
    !!startMovement;
    .print("Should random walk").

+!stopAndRestart
<-  .abolish(ownerPositioned);
    .abolish(blockType(_));
    .print("Data cleared");
    !!startMovement;
    .print("Should random walk").
