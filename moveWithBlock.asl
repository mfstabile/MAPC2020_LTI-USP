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
                          position(XPosition,YPosition,_) &
                          carryBlockTo(XTarget,YTarget) &
                          (((XTarget-XPosition)**2 + (YTarget-YPosition)**2)**0.5) < 10 &
                          not ownerPositioned
<-  !performAction(skip);
    !verifyTargetOccupation.

//////////////////////////////Owner/////////////////////////////////////////////

+!verifyTargetOccupation: carryBlockTo(XTarget,YTarget) &
                          position(XPosition,YPosition,_) &
                          (((XTarget-XPosition)**2 + (YTarget-YPosition)**2)**0.5) < 5 &
                          thing(XTarget-XPosition,YTarget-YPosition,_,_,_) &
                          auxiliarPosition(AuxiliarAgentName,XAgentPosition,YAgentPosition,Direction,BlockType) &
                          mapper(AuxiliarAgentName,XMapper,YMapper)
<-  .print("Changing goal position because it is occupied");
    ?getLastPosition(MyX,MyY);
    !chooseGoal(XNearGoal,YNearGoal);
    .abolish(carryBlockTo(_,_));
    +carryBlockTo(XNearGoal,YNearGoal);
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
    .print("New goal position because it is occupied");
    .

+!verifyTargetOccupation <- true.

+!chooseGoal(XNearGoal,YNearGoal)
<-  ?getLastPosition(MyX,MyY);
    .setof(g(((XGoal-MyX)**2)+((YGoal-MyY)**2),XGoal,YGoal),goal(XGoal,YGoal) & not thing(XTarget-MyX,YTarget-MyY,_,_,_),GoalList);
    .min(GoalList,g(Dist,XNearGoal,YNearGoal)).
