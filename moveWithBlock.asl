+!carryBlock : carryBlockTo(X,Y) & step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!carryBlock.

+!carryBlock : carryBlockTo(X,Y) & step(_,TIME) & position(X,Y,TIME) <- true.//arrived
+!carryBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,Y,TIME) <- !verifyTargetOccupation;!moveHorizontalWithBlock;!carryBlock.
+!carryBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,_,TIME) <- !verifyTargetOccupation;!moveVerticalWithBlock;!carryBlock.

+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!moveVerticalWithBlock.
+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,Y,TIME) <- true.

+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM > Y & not blocked(n) & not blockBlocked(n) <- !verifyTargetOccupation; !performAction(move(n));!moveVerticalWithBlock.
+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM > Y & blocked(n) <- !verifyTargetOccupation; !dodgeWithBlock(e);!moveVerticalWithBlock.
+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM > Y & not blocked(n) & blockBlocked(n)<- !verifyTargetOccupation; !unblockBlock(n);!moveVerticalWithBlock.

+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM < Y & not blocked(s) & not blockBlocked(s) <- !verifyTargetOccupation; !performAction(move(s));!moveVerticalWithBlock.
+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM < Y & blocked(s) <- !verifyTargetOccupation; !dodgeWithBlock(w);!moveVerticalWithBlock.
+!moveVerticalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(_,YM,TIME) & YM < Y & not blocked(s) & blockBlocked(s) <- !verifyTargetOccupation; !unblockBlock(s);!moveVerticalWithBlock.

+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!moveHorizontalWithBlock.
+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(X,_,TIME) <- !carryBlock.

+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM > X & not blocked(w) & not blockBlocked(w) <- !verifyTargetOccupation; !performAction(move(w));!moveHorizontalWithBlock.
+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM > X & blocked(w) <- !verifyTargetOccupation; !dodgeWithBlock(s);!moveHorizontalWithBlock.
+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM > X & not blocked(w) & blockBlocked(w) <- !verifyTargetOccupation; !unblockBlock(w);!moveHorizontalWithBlock.

+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM < X & not blocked(e) & not blockBlocked(e) <- !verifyTargetOccupation; !performAction(move(e));!moveHorizontalWithBlock.
+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM < X & blocked(e) <- !verifyTargetOccupation; !dodgeWithBlock(n);!moveHorizontalWithBlock.
+!moveHorizontalWithBlock : carryBlockTo(X,Y) & step(_,TIME) & position(XM,_,TIME) & XM < X & not blocked(e) & blockBlocked(e) <- !verifyTargetOccupation; !unblockBlock(e);!moveHorizontalWithBlock.

+!dodgeWithBlock(Direction) : carryBlockTo(X,Y) & step(_,TIME) & not position(A,B,TIME) <- .wait("+position(_,_,TIME)",10,Arg); !dodgeWithBlock(Direction).
+!dodgeWithBlock(_) : carryBlockTo(X,Y) & step(_,TIME) & position(X,Y,TIME) <- true.
+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(s) & not blockBlocked(s) <- !verifyTargetOccupation; !performAction(move(s)).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(n) & not blockBlocked(n) <- !verifyTargetOccupation; !performAction(move(n)).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(w) & not blockBlocked(w) <- !verifyTargetOccupation; !performAction(move(w)).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(e) & not blockBlocked(e) <- !verifyTargetOccupation; !performAction(move(e)).

+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(s) <- !dodgeWithBlock(w);!dodgeWithBlock(s).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(n) <- !dodgeWithBlock(e);!dodgeWithBlock(n).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(w) <- !dodgeWithBlock(n);!dodgeWithBlock(w).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(e) <- !dodgeWithBlock(s);!dodgeWithBlock(e).

+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(s) & blockBlocked(s) <- !unblockBlock(s); !verifyTargetOccupation; !performAction(move(s)).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(n) & blockBlocked(n) <- !unblockBlock(n); !verifyTargetOccupation; !performAction(move(n)).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(w) & blockBlocked(w) <- !unblockBlock(w); !verifyTargetOccupation; !performAction(move(w)).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(e) & blockBlocked(e) <- !unblockBlock(e); !verifyTargetOccupation; !performAction(move(e)).


//////////////////////////////Auxiliar/////////////////////////////////////////////
+!verifyTargetOccupation: .my_name(MyName) &
                          auxiliar(MyName,TaskOwnerName) &
                          carryBlockTo(XTarget,YTarget) &
                          not ownerPositioned
<-  ?getLastPosition(XPosition,YPosition);
    ?hasBlock(HasBlock);
    if(not HasBlock){
      .abolish(carrying(_,_,_));
      ?blockType(BlockType);
      !goToDispenser(BlockType);
      !getBlock;
    };
    Distance = (((XTarget-XPosition)**2 + (YTarget-YPosition)**2)**0.5)
    if(Distance <10){
      !performAction(skip);
      !verifyTargetOccupation;
    }
    .
//////////////////////////////Owner/////////////////////////////////////////////
//Check if the agent still carries the block
+!checkBlock(Continue)
<-  ?hasBlock(HasBlock);
    if(not HasBlock){
      .abolish(carrying(_,_,_));
      ?accepted(TaskName,_);
      if (task(TaskName,Deadline,_,_,_)){
        ?step(Step, _);
        //verify if there is time for recovering
        //40 is an arbitrary value
        if(Step+40 < Deadline){
          !getOwnerBlockType(BlockType);
          !goToDispenser(BlockType);
          !getBlock;
          Continue = true;
        }else{
          //cancel all
          +exceededDeadline;
          Continue = false;
          ?getLastPosition(MyX,MyY);
          .abolish(carryBlockTo(_,_));
          +carryBlockTo(MyX,MyY);
          !clearBlock;
          !abortAuxiliarAssist;
        }
      }else{
        //cancel all
        +exceededDeadline;
        Continue = false;
        ?getLastPosition(MyX,MyY);
        .abolish(carryBlockTo(_,_));
        +carryBlockTo(MyX,MyY);
        !clearBlock;
        !abortAuxiliarAssist;
      }
    }.
//Verify Goal position if it is blocked with other agent/block
//implemented for 2 auxiliars
+!verifyTargetOccupation: carryBlockTo(XTarget,YTarget) &
                          auxiliarPosition(AuxiliarAgentName1,XAgentPosition1,YAgentPosition1,Direction1,BlockType1,1) &
                          auxiliarPosition(AuxiliarAgentName2,XAgentPosition2,YAgentPosition2,Direction2,BlockType2,2) &
                          mapper(AuxiliarAgentName1,XMapper1,YMapper1) &
                          mapper(AuxiliarAgentName2,XMapper2,YMapper2)
<-  !checkBlock(Continue);
    if(Continue){
      ?getLastPosition(MyX,MyY);
      Distance = (((XTarget-MyX)**2 + (YTarget-MyY)**2)**0.5);
      .count(thing(XTarget-MyX,YTarget-MyY,_,_,_),ThingAmount);
      if (Distance < 5 & ThingAmount > 0){
        // .print("--------------------->Changing goal position because it is occupied<-----------------");
        !chooseAvailableGoal(XNearGoal,YNearGoal);
        .abolish(carryBlockTo(_,_));
        +carryBlockTo(XNearGoal,YNearGoal);
        .send(AuxiliarAgentName1,unachieve, goAssist(_,_,_,_));
        .send(AuxiliarAgentName1,unachieve, fixAuxiliarSetup(_,_,_,_,_));
        .send(AuxiliarAgentName1,unachieve,connectAuxiliar);
        .send(AuxiliarAgentName2,unachieve, goAssist(_,_,_,_));
        .send(AuxiliarAgentName2,unachieve, fixAuxiliarSetup(_,_,_,_,_));
        .send(AuxiliarAgentName2,unachieve,connectAuxiliar);
        .my_name(MyName);
        ?accepted(TaskName,_);
        ?task(TaskName,_,_,Requirements,_);
        .delete(req(0,1,_),Requirements,[req(XBlockA,YBlockA,_),req(XBlockB,YBlockB,_)]);
        BlockDistanceA = (XBlockA)**2 + (YBlockA - 1)**2;
        //identifying requirement order
        if(BlockDistanceA == 1){
          XBlock1 = XBlockA;
          YBlock1 = YBlockA;
          XBlock2 = XBlockB;
          YBlock2 = YBlockB;
        }else{
          XBlock1 = XBlockB;
          YBlock1 = YBlockB;
          XBlock2 = XBlockA;
          YBlock2 = YBlockA;
        }
        //updating AuxiliarAgentName1 position
        if(XBlock1 == 0){
          XAgentPositionNew1 = XNearGoal+XBlock1+XMapper1-1;
          YAgentPositionNew1 = YNearGoal+YBlock1+YMapper1;
          DirectionNew1 = e;
        }else{
          XAgentPositionNew1 = XNearGoal+XBlock1+XMapper1;
          YAgentPositionNew1 = YNearGoal+YBlock1+YMapper1-1;
          DirectionNew1 = s;
        }
        //updating AuxiliarAgentName2 position
        if(XBlock2 < 0){
          XAgentPositionNew2 = XNearGoal+XBlock2+XMapper2-1;
          YAgentPositionNew2 = YNearGoal+YBlock2+YMapper2;
          DirectionNew2 = e;
        }else{
          XAgentPositionNew2 = XNearGoal+XBlock2+XMapper2+1;
          YAgentPositionNew2 = YNearGoal+YBlock2+YMapper2;
          DirectionNew2 = w;
        }
        .abolish(auxiliarPosition(_,_,_,_,_,_));
        +auxiliarPosition(AuxiliarAgentName1,XAgentPositionNew1,YAgentPositionNew1,DirectionNew1,BlockType1,1);
        +auxiliarPosition(AuxiliarAgentName2,XAgentPositionNew2,YAgentPositionNew2,DirectionNew2,BlockType2,2);
        .send(AuxiliarAgentName1,achieve,fixAuxiliarSetup(XAgentPositionNew1,YAgentPositionNew1,DirectionNew1,MyName,BlockType1));
        .send(AuxiliarAgentName2,achieve,fixAuxiliarSetup(XAgentPositionNew2,YAgentPositionNew2,DirectionNew2,MyName,BlockType2));
        // .print("***************************New goal position because it is occupied");
      }
    }
    .
//implemented for 1 auxiliar
+!verifyTargetOccupation: carryBlockTo(XTarget,YTarget) &
                          auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType,Order) &
                          mapper(AuxiliarAgentName,XMapper,YMapper)
<-  !checkBlock(Continue);
    if(Continue){
      ?getLastPosition(MyX,MyY);
      Distance = (((XTarget-MyX)**2 + (YTarget-MyY)**2)**0.5);
      .count(thing(XTarget-MyX,YTarget-MyY,_,_,_),ThingAmount);
      if (Distance < 5 & ThingAmount > 0){
        // .print("--------------------->Changing goal position because it is occupied<-----------------");
        !chooseAvailableGoal(XNearGoal,YNearGoal);
        .abolish(carryBlockTo(_,_));
        +carryBlockTo(XNearGoal,YNearGoal);
        .send(AuxiliarAgentName,unachieve, goAssist(_,_,_,_));
        .send(AuxiliarAgentName,unachieve, fixAuxiliarSetup(_,_,_,_,_));
        .send(AuxiliarAgentName,unachieve,connectAuxiliar);
        .my_name(MyName);
        ?accepted(TaskName,_);
        ?task(TaskName,_,_,Requirements,_);
        .delete(req(0,1,_),Requirements,[req(XBlock,YBlock,BlockType)]);
        if(XBlock == 0){
          XAgentPositionNew = XNearGoal+XBlock+XMapper-1;
          YAgentPositionNew = YNearGoal+YBlock+YMapper;
          DirectionNew = e;
        }else{
          XAgentPositionNew = XNearGoal+XBlock+XMapper;
          YAgentPositionNew = YNearGoal+YBlock+YMapper-1;
          DirectionNew = s;
        }
        .abolish(auxiliarPosition(AuxiliarAgentName,_,_,_,_,_));
        +auxiliarPosition(AuxiliarAgentName,XAgentPositionNew,YAgentPositionNew,DirectionNew,BlockType,Order);
        .send(AuxiliarAgentName,achieve,fixAuxiliarSetup(XAgentPositionNew,YAgentPositionNew,DirectionNew,MyName,BlockType));
        // .print("***************************New goal position because it is occupied");
      }
    }
    .

+!verifyTargetOccupation <- true.

-!verifyTargetOccupation : accepted(TaskName,_)
<- +exceededDeadline;
    ?getLastPosition(MyX,MyY);
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(MyX,MyY);
    !clearBlock;
    !abortAuxiliarAssist.

+!chooseAvailableGoal(XNearGoal,YNearGoal)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal) & not thing(XGoal-MyX,YGoal-MyY,_,_,_),GoalList);
    .min(GoalList,g(Dist,XNearGoal,YNearGoal));
    .// .print("########################Found new goal area: ",XNearGoal,":",YNearGoal).
