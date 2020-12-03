{ include("explore.asl") }// Agent bob in project MAPC2018.mas2j
{ include("perceptions.asl") }
{ include("achieve.asl") }
{ include("achieve_aux.asl") }
{ include("movement.asl") }
{ include("acknowledge.asl") }

/* Initial beliefs and rules */
position(me,0,0,0).
maxAgents(15).
/* Initial goals */

//!start.
!waitRegister.
//!explore.
/* Plans */

+!waitRegister <- !performAction(skip);!moveRegister.

+!moveRegister : attached(_,_,_) <- !performAction(clear(0,0));?thing(0,0,entity,TEAM,_);+team(TEAM);!explore.
+!moveRegister <- !performAction(move(n));?thing(0,0,entity,TEAM,_);+team(TEAM);!explore.

//@performAction[atomic]
+!performAction(ACTION)
<-  //.print(" Executing action ",ACTION);
	//.wait(1000);
	ACTION;
	?step(STEP,T);
	.wait("+step(_,_)"); // Wait for the next simulation step
	?step(STEP_NEW,TIME);
	+stepLog(STEP_NEW,TIME);
	?lastActionResult(LAR,TIME);
	?lastAction(LACT,TIME);
	?lastActionParams(LAP,TIME);
	//.print("New Step: ", STEP+1);
	!checkDispensers;
	!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP).

+?step(STEP,T) : not stepLog(_,_) <- STEP=0;T=0.
	//.wait(300).

+!handleLastActionResult(skip,TIME,LAR,LACT,LAP) <- !updatePosition(TIME).

+!handleLastActionResult(ACTION,TIME,success,clear,[0,0])
    :   thing(0,1,block,_,_) | thing(0,-1,block,_,_) | thing(1,0,block,_,_) | thing(-1,0,block,_,_)
    <-  !updatePosition(TIME);!performAction(clear(0,0)).

+!handleLastActionResult(ACTION,TIME,success,LACT,LAP)
    :   LACT \==move
    <-  !updatePosition(TIME).

+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   (LAR==failed_random|LAR==failed_resources|LAR==failed_status)
    <-  !updatePosition(TIME);!performAction(ACTION).

+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   not .intend(explore) & LACT \==move
    <-  !updatePosition(TIME);.print("failed action ",ACTION);.fail.


+!updateBlockCW : hasBlock(n) <- -hasBlock(n);+hasBlock(e).
+!updateBlockCW : hasBlock(e) <- -hasBlock(e);+hasBlock(s).
+!updateBlockCW : hasBlock(s) <- -hasBlock(s);+hasBlock(w).
+!updateBlockCW : hasBlock(w) <- -hasBlock(w);+hasBlock(n).

+!updateBlockCCW : hasBlock(n) <- -hasBlock(n);+hasBlock(w).
+!updateBlockCCW : hasBlock(e) <- -hasBlock(e);+hasBlock(n).
+!updateBlockCCW : hasBlock(s) <- -hasBlock(s);+hasBlock(e).
+!updateBlockCCW : hasBlock(w) <- -hasBlock(w);+hasBlock(s).

+!updatePosition(TIME) <- -position(me,X,Y,_);+position(me,X,Y,TIME).

//test:
+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   lastActionResult(ACT,TIME) & lastAction(move,TIME) & lastActionParams(D,TIME) & not .intend(explore)
	<- .print("-------------------------------------------",ACT,ACTION,D);.fail.

+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   lastActionResult(ACT,TIME) & lastAction(move,TIME) & lastActionParams(D,TIME)
	<- .print("-------------------------------------------expl",ACT,ACTION,D);.fail.

+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    :   lastActionResult(ACT,TIME) & lastAction(LACT,TIME) & lastActionParams(D,TIME)
	<- .print("-------------------------------------------misterio1",ACT,LACT,D);.fail.
	
+!handleLastActionResult(ACTION,TIME,LAR,LACT,LAP)
    //:   lastActionResult(ACT,TIME) & lastAction(LACT,TIME) & lastActionParams(D,TIME)
	<- 	.print("-------------------------------------------misterio2",ACTION,TIME);
	?lastActionResult(A,T);
	?lastAction(LACT,T);
	.print("-------------------------------------------misterio2",A,T,LACT);
	?lastActionResult(ACT,TIME);
	?lastAction(LACT,TIME);
	?lastActionParams(D,TIME);
	.fail.
