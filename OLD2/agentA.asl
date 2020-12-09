{ include("explore.asl") }
{ include("perceptions.asl") }
{ include("achieve.asl") }
{ include("achieve_aux.asl") }
{ include("move.asl") }
{ include("acknowledge.asl") }

/* Initial beliefs and rules */
position(me,0,0,0).
maxAgents(15).

blocked(X,Y,T) :- obstacle(X,Y,T) | thing(X,Y,entity,_,T) | thing(X,Y,block,_,T).
seeBlock(n) :- thing(0,-1,block,_,_).
seeBlock(s) :- thing(0,1,block,_,_).
seeBlock(e) :- thing(1,0,block,_,_).
seeBlock(w) :- thing(-1,-1,block,_,_).
/* Initial goals */

//!start.
!waitRegister.
//!explore.
/* Plans */

+!waitRegister <- !performAction(skip);!moveRegister.

+!moveRegister : attached(_,_,_) <- !performAction(clear(0,0));?thing(0,0,entity,TEAM,_);+team(TEAM);!explore.
+!moveRegister <- !performAction(move(n));?thing(0,0,entity,TEAM,_);+team(TEAM);!explore.

+!performAction(ACTION)
<-  ?step(STEP,T);
	ACTION;
	.wait("+step(_,_)"); // Wait for the next simulation step
	?step(STEP_NEW,TIME);
	?lastActionResult(LAR,TIME);
	?lastAction(LACT,TIME);
	?lastActionParams(LAP,TIME);
	!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP);
	!checkDispensers.
	
+step(STEP_NEW,TIME) <- +stepLog(STEP_NEW,TIME).

+?step(STEP,T) : not stepLog(_,_) <- STEP=0;T=0.
	
+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   (LAR==failed_random|LAR==failed_resources|LAR==failed_status)
    <-  !updatePosition(TIME);!performAction(ACTION).

+!updatePosition(TIME)
<- 	-position(me,X,Y,_);
	+position(me,X,Y,TIME).

+position(me,XM,YM,T) <- +logposition(me,XM,YM,T).

+lastAction(no_action,TIME) <- !updatePosition(TIME).

+!handleLastActionResult(ACTION,TIME,LAR,connect,_) : LAR \== success
    <-  !updatePosition(TIME);.fail.

+!handleLastActionResult(ACTION,TIME,success,rotate,[cw])
    <-  !updateBlockCW;!updatePosition(TIME).

+!handleLastActionResult(ACTION,TIME,success,rotate,[ccw])
    <-  !updateBlockCCW;!updatePosition(TIME).
	
+!handleLastActionResult(ACTION,TIME,failed,rotate,[ccw])
    <-  !updatePosition(TIME);.fail.
	
+!updateBlockCW : hasBlock(n) <- -hasBlock(n);+hasBlock(e).
+!updateBlockCW : hasBlock(e) <- -hasBlock(e);+hasBlock(s).
+!updateBlockCW : hasBlock(s) <- -hasBlock(s);+hasBlock(w).
+!updateBlockCW : hasBlock(w) <- -hasBlock(w);+hasBlock(n).

+!updateBlockCCW : hasBlock(n) <- -hasBlock(n);+hasBlock(w).
+!updateBlockCCW : hasBlock(e) <- -hasBlock(e);+hasBlock(n).
+!updateBlockCCW : hasBlock(s) <- -hasBlock(s);+hasBlock(e).
+!updateBlockCCW : hasBlock(w) <- -hasBlock(w);+hasBlock(s).

+!handleLastActionResult(ACTION,TIME,success,LACT,LAP)
<-	!updatePosition(TIME).
