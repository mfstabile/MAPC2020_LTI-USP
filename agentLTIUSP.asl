{ include("knowledge.asl") }
{ include("mapping.asl") }
{ include("taskManagement.asl") }
{ include("movement.asl") }
{ include("moveWithBlock.asl") }
{ include("unblock.asl") }
{ include("obstacle.asl") }
{ include("auxiliar.asl") }
{ include("blockPosition.asl") }

position(0,0,0).

blocked(n) :- obstacle(0,-1,T) | thing(0,-1,entity,_,T) | (thing(0,-1,block,_,T) & (not carrying(0,-1,T))).
blocked(s) :- obstacle(0,+1,T) | thing(0,+1,entity,_,T) | (thing(0,+1,block,_,T) & (not carrying(0,+1,T))).
blocked(e) :- obstacle(+1,0,T) | thing(+1,0,entity,_,T) | (thing(+1,0,block,_,T) & (not carrying(+1,0,T))).
blocked(w) :- obstacle(-1,0,T) | thing(-1,0,entity,_,T) | (thing(-1,0,block,_,T) & (not carrying(-1,0,T))).

blockBlocked(n) :- carrying(Xblock,Yblock,T) &
 									 (obstacle(Xblock+0,Yblock-1,T) |
									 (thing(Xblock+0,Yblock-1,entity,_,T) & (Xblock+0 \== 0 | Yblock-1 \== 0)) |
									  thing(Xblock+0,Yblock-1,block,_,T)).

blockBlocked(s) :- carrying(Xblock,Yblock,T) &
 									 (obstacle(Xblock+0,Yblock+1,T) |
									 (thing(Xblock+0,Yblock+1,entity,_,T) & (Xblock+0 \== 0 | Yblock+1 \== 0)) |
									  thing(Xblock+0,Yblock+1,block,_,T)).

blockBlocked(e) :- carrying(Xblock,Yblock,T) &
 									 (obstacle(Xblock+1,Yblock+0,T) |
									 (thing(Xblock+1,Yblock+0,entity,_,T) & (Xblock+1 \== 0 | Yblock+0 \== 0)) |
									  thing(Xblock+1,Yblock+0,block,_,T)).

blockBlocked(w) :- carrying(Xblock,Yblock,T) &
 									 (obstacle(Xblock-1,Yblock+0,T) |
									 (thing(Xblock-1,Yblock+0,entity,_,T) & (Xblock-1 \== 0 | Yblock+0 \== 0)) |
									  thing(Xblock-1,Yblock+0,block,_,T)).


!startMovement2.

+!startMovement2 <- .wait("+step(_,Time)");!startMovement.

+!chooseDirection
<-
		if (blocked(n)){
			N = [];
		}else{
			N = [n];
		}
		if (blocked(s)){
			S = [];
		}else{
			S = [s];
		}
		if (blocked(e)){
			E = [];
		}else{
			E = [e];
		}
		if (blocked(w)){
			W = [];
		}else{
			W = [w];
		}
		.concat(N,S,E,W,DirectionList);
		.shuffle(DirectionList,ShuffledList);
		.nth(0,ShuffledList,Direction);
		+direction(Direction).

-!chooseDirection <- !performAction(skip);!chooseDirection.

+!startMovement
<-	//.set_random_seed(17);
    !chooseDirection;
		!randomWalk.

+!randomWalk : not noMoreOwners &
         step(Step,Time) &
         //Step < 100 &
         dispenser(_,_,b0) &
				 dispenser(_,_,b1) &
				 dispenser(_,_,b2) &
				 taskboard(_,_) &
				 goal(_,_) &
				 .all_names(AllAgents) &
				 .length(AllAgents,AgentAmount) &
				 .count(mapper(AgentName, _, _) & not taskowner(AgentName) & not auxiliar(AgentName,_), AvailableAgents) &
				 AvailableAgents > 1 &
         .my_name(MyName) &
         not auxiliar(MyName,_)
<-    .broadcast(tell, taskowner(MyName));
      +taskowner(MyName);
      .count(taskowner(Owner),TaskOwnerAmountNew);
      if(TaskOwnerAmountNew>=(AgentAmount/3)){
        .broadcast(tell, noMoreOwners);
        .print("noMoreOwners");
      }
      !!achieveTask.

+!randomWalk
<-	.random(Number);
	if(Number < 0.01){
		-direction(_);
		!chooseDirection;
	}
	?direction(Direction);
	if (not blocked(Direction)){
		!performAction(move(Direction));
	}
	else{
		-direction(_);
		!chooseDirection;
	}
	!randomWalk.

+!performAction(Action)
<-	Action;
		.wait("+step(_,Time)").

+!performMoveAction(Direction)
<-	!performAction(move(Direction));
    ?lastActionResult(Result,Time);
    if(Result\==success){
      !performMoveAction(Direction);
    }.

+?getLastPosition(X,Y)
<-	.findall(Timestamp, position(_,_,Timestamp), TimestampList);
		.max(TimestampList, Max);
		?position(X,Y,Max).

///////////////////////////////UPDATE AGENT POSITION////////////////////////////////////////////
+!updatePosition(success,move,[n],Time)
<-	?getLastPosition(X,Y);
		+position(X,Y-1,Time).

+!updatePosition(success,move,[s],Time)
<-	?getLastPosition(X,Y);
		+position(X,Y+1,Time).

+!updatePosition(success,move,[e],Time)
<-	?getLastPosition(X,Y);
		+position(X+1,Y,Time).

+!updatePosition(success,move,[w],Time)
<-	?getLastPosition(X,Y);
		+position(X-1,Y,Time).

+!updatePosition(_,_,_,Time)
<-	?getLastPosition(X,Y);
		+position(X,Y,Time).

///////////////////////////////UPDATE BLOCK POSITION////////////////////////////////////////////
+!updateBlock(success,rotate,[cw],Time) : carrying(-1,0,_)
<-	+carrying(0,-1,Time);
    -carrying(-1,0,_).

+!updateBlock(success,rotate,[cw],Time) : carrying(0,-1,_)
<-	+carrying(1,0,Time);
		-carrying(0,-1,_).

+!updateBlock(success,rotate,[cw],Time) : carrying(1,0,_)
<-	+carrying(0,1,Time);
		-carrying(1,0,_).

+!updateBlock(success,rotate,[cw],Time) : carrying(0,1,_)
<-	+carrying(-1,0,Time);
		-carrying(0,1,_).

+!updateBlock(success,rotate,[ccw],Time) : carrying(-1,0,_)
<-	+carrying(0,1,Time);
		-carrying(-1,0,_).

+!updateBlock(success,rotate,[ccw],Time) : carrying(0,-1,_)
<-	+carrying(-1,0,Time);
		-carrying(0,-1,_).

+!updateBlock(success,rotate,[ccw],Time) : carrying(1,0,_)
<-	+carrying(0,-1,Time);
		-carrying(1,0,_).

+!updateBlock(success,rotate,[ccw],Time) : carrying(0,1,_)
<-	+carrying(1,0,Time);
		-carrying(0,1,_).

+!updateBlock(_,_,_,Time) : carrying(X,Y,Old)
<-	+carrying(X,Y,Time);
		-carrying(X,Y,Old).

+!updateBlock(_,_,_,Time)
<-	true.
///////////////////////////////////////////////////////////////////////////
