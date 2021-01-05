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
+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(s) & not blockBlocked(s) <- !performAction(move(s)).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n)).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(w) & not blockBlocked(w) <- !performAction(move(w)).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(e) & not blockBlocked(e) <- !performAction(move(e)).

+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(s) <- !dodgeWithBlock(w);!dodgeWithBlock(s).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(n) <- !dodgeWithBlock(e);!dodgeWithBlock(n).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(w) <- !dodgeWithBlock(n);!dodgeWithBlock(w).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & blocked(e) <- !dodgeWithBlock(s);!dodgeWithBlock(e).

+!dodgeWithBlock(s) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(s) & blockBlocked(s) <- !unblockBlock(s);!performAction(move(s)).
+!dodgeWithBlock(n) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(n) & blockBlocked(n) <- !unblockBlock(n);!performAction(move(n)).
+!dodgeWithBlock(w) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(w) & blockBlocked(w) <- !unblockBlock(w);!performAction(move(w)).
+!dodgeWithBlock(e) : carryBlockTo(X,Y) & step(_,TIME) & position(A,B,TIME) & not blocked(e) & blockBlocked(e) <- !unblockBlock(e);!performAction(move(e)).


//////////////////////////////Auxiliar/////////////////////////////////////////////
+!verifyTargetOccupation: .my_name(MyName) &
                          auxiliar(MyName,TaskOwnerName) &
                          // position(XPosition,YPosition,_) &
                          carryBlockTo(XTarget,YTarget) &
                          // (((XTarget-XPosition)**2 + (YTarget-YPosition)**2)**0.5) < 10 &
                          not ownerPositioned
<-  ?getLastPosition(XPosition,YPosition);
    Distance = (((XTarget-XPosition)**2 + (YTarget-YPosition)**2)**0.5)
    if(Distance <15){
      !performAction(skip);
      !verifyTargetOccupation;
    }.
//////////////////////////////Owner/////////////////////////////////////////////
//Verify Goal position if it is blocked with other agent/block
//implemented for 1 auxiliar
+!verifyTargetOccupation: carryBlockTo(XTarget,YTarget) &
                          auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType,Order) &
                          mapper(AuxiliarAgentName,XMapper,YMapper)
<-  ?getLastPosition(MyX,MyY);
    Distance = (((XTarget-MyX)**2 + (YTarget-MyY)**2)**0.5);
    .count(thing(XTarget-MyX,YTarget-MyY,_,_,_),ThingAmount);
    if (Distance < 5 & ThingAmount > 0){
      .print("--------------------->Changing goal position because it is occupied<-----------------");
      !chooseAvailableGoal(XNearGoal,YNearGoal);
      .abolish(carryBlockTo(_,_));
      +carryBlockTo(XNearGoal,YNearGoal);
      .send(AuxiliarAgentName,unachieve, goAssist(_,_,_,_));
      .send(AuxiliarAgentName,unachieve, fixAuxiliarSetup(_,_,_,_,_));
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
      .print("***************************New goal position because it is occupied");
    }
    .

+!verifyTargetOccupation <- true.

+!chooseAvailableGoal(XNearGoal,YNearGoal)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal) & not thing(XGoal-MyX,YGoal-MyY,_,_,_),GoalList);
    .min(GoalList,g(Dist,XNearGoal,YNearGoal));
    .print("########################Found new goal area: ",XNearGoal,":",YNearGoal).
