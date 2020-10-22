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

@performAction[atomic]
+!performAction(ACTION)
<-  .print(" Executing action ",ACTION);
	ACTION;
	.wait("+step(_,_)"); // Wait for the next simulation step
	?step(STEP_AFTER,TIME);
	.print("New Step: ", STEP_AFTER);
	!handleLastActionResult(ACTION,TIME);
	!updatePosition(TIME).
	//.wait(300).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(rotate,_) & lastActionParams([cw],_)
    <-  !updateBlockCW;!updatePosition(TIME).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(rotate,_) & lastActionParams([ccw],_)
    <-  !updateBlockCCW;!updatePosition(TIME).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(clear,_) & lastActionParams([0,0],_) & thing(X,Y,block,_,_)
    <-  !updatePosition(TIME);!performAction(clear(0,0)).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(LACTION,_) & lastActionParams(PARAMS,_) & LACTION \==move
    <-  !updatePosition(TIME).

+!handleLastActionResult(ACTION,TIME)
    :   (lastActionResult(failed_random,_)|lastActionResult(failed_resources,_)|lastActionResult(failed_status,_)) & lastAction(LACTION,_) & lastActionParams(PARAMS,_)
    <-  !updatePosition(TIME);(ACTION).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(RES,_) & lastAction(LACTION,_) & lastActionParams(PARAMS,_) & not .intend(explore) & LACTION \==move
    <-  !updatePosition(TIME);.print("failed action ",RES);.fail.
	
	
+!updateBlockCW : hasBlock(n) <- -hasBlock(n);+hasBlock(e).
+!updateBlockCW : hasBlock(e) <- -hasBlock(e);+hasBlock(s).
+!updateBlockCW : hasBlock(s) <- -hasBlock(s);+hasBlock(w).
+!updateBlockCW : hasBlock(w) <- -hasBlock(w);+hasBlock(n).

+!updateBlockCCW : hasBlock(n) <- -hasBlock(n);+hasBlock(w).
+!updateBlockCCW : hasBlock(e) <- -hasBlock(e);+hasBlock(n).
+!updateBlockCCW : hasBlock(s) <- -hasBlock(s);+hasBlock(e).
+!updateBlockCCW : hasBlock(w) <- -hasBlock(w);+hasBlock(s).

+!updatePosition(TIME) <- -position(me,X,Y,_);+position(me,X,Y,TIME).
