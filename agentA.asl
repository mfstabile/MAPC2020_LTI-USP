{ include("knowledge.asl") }
{ include("mapping.asl") }
{ include("taskManagement.asl") }
{ include("movement.asl") }
{ include("moveWithBlock.asl") }
{ include("unblock.asl") }

position(0,0,0).

blocked(n) :- obstacle(0,-1,T) | thing(0,-1,entity,_,T) | (thing(0,-1,block,_,T) & (not carrying(0,-1,T))).
blocked(s) :- obstacle(0,+1,T) | thing(0,+1,entity,_,T) | (thing(0,+1,block,_,T) & (not carrying(0,+1,T))).
blocked(e) :- obstacle(+1,0,T) | thing(+1,0,entity,_,T) | (thing(+1,0,block,_,T) & (not carrying(+1,0,T))).
blocked(w) :- obstacle(-1,0,T) | thing(-1,0,entity,_,T) | (thing(-1,0,block,_,T) & (not carrying(-1,0,T))).

blockBlocked(n) :- carrying(Xblock,Yblock,T) & (obstacle(Xblock+0,Yblock-1,T) | (thing(Xblock+0,Yblock-1,entity,_,T) & (Xblock+0 \== 0 | Yblock-1 \== 0)) | thing(Xblock+0,Yblock-1,block,_,T)).
blockBlocked(s) :- carrying(Xblock,Yblock,T) & (obstacle(Xblock+0,Yblock+1,T) | (thing(Xblock+0,Yblock+1,entity,_,T) & (Xblock+0 \== 0 | Yblock+1 \== 0)) | thing(Xblock+0,Yblock+1,block,_,T)).
blockBlocked(e) :- carrying(Xblock,Yblock,T) & (obstacle(Xblock+1,Yblock+0,T) | (thing(Xblock+1,Yblock+0,entity,_,T) & (Xblock+1 \== 0 | Yblock+0 \== 0)) | thing(Xblock+1,Yblock+0,block,_,T)).
blockBlocked(w) :- carrying(Xblock,Yblock,T) & (obstacle(Xblock-1,Yblock+0,T) | (thing(Xblock-1,Yblock+0,entity,_,T) & (Xblock-1 \== 0 | Yblock+0 \== 0)) | thing(Xblock-1,Yblock+0,block,_,T)).

!startMovement.

+!chooseDirection
<- 	.random(Number);
	if(Number <0.25){
		+direction(n);
	}
	elif(Number < 0.5){
		+direction(s);
	}
	elif(Number < 0.75){
		+direction(w);
	}
	else{
		+direction(e);
	}.

+!startMovement
<-	!chooseDirection;
		!randomWalk.

// +!randomWalk : dispenser(_,_,b0) &
// 				 dispenser(_,_,b1) &
// 				 dispenser(_,_,b2) &
// 				 taskboard(_,_) &
// 				 goal(_,_) &
// 				 .count(taskowner(Owner),TaskOwnerAmount) &
// 				 .count(.all_names(AllAgents),AgentAmount) &
// 				 TaskOwnerAmount < (AgentAmount/3) &
// 				 .count(mapper(AgentName, _, _) & not taskowner(AgentName) & not auxiliar(AgentName), AvailableAgents) &
// 				 AvailableAgents > 2
// <-		.my_name(MyName);
// 			+taskowner(MyName);
// 			.broadcast(tell, taskowner(MyName));
// 			!!achieveTask.

+!randomWalk : dispenser(_,_,b0) &
				 dispenser(_,_,b1) &
				 dispenser(_,_,b2) &
				 taskboard(_,_) &
				 goal(_,_) &
				 .count(taskowner(Owner),TaskOwnerAmount) &
				 .count(.all_names(AllAgents),AgentAmount) &
				 .count(mapper(AgentName, _, _) & not taskowner(AgentName) & not auxiliar(AgentName), AvailableAgents)
<-		.my_name(MyName);
			+taskowner(MyName);
			.broadcast(tell, taskowner(MyName));
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
<-	-carrying(-1,0,_);
		+carrying(0,-1,Time).

+!updateBlock(success,rotate,[cw],Time) : carrying(0,-1,_)
<-	-carrying(0,-1,_);
		+carrying(1,0,Time).

+!updateBlock(success,rotate,[cw],Time) : carrying(1,0,_)
<-	-carrying(1,0,_);
		+carrying(0,1,Time).

+!updateBlock(success,rotate,[cw],Time) : carrying(0,1,_)
<-	-carrying(0,1,_);
		+carrying(-1,0,Time).

+!updateBlock(success,rotate,[ccw],Time) : carrying(-1,0,_)
<-	-carrying(-1,0,_);
		+carrying(0,1,Time).

+!updateBlock(success,rotate,[ccw],Time) : carrying(0,-1,_)
<-	-carrying(0,-1,_);
		+carrying(-1,0,Time).

+!updateBlock(success,rotate,[ccw],Time) : carrying(1,0,_)
<-	-carrying(1,0,_);
		+carrying(0,-1,Time).

+!updateBlock(success,rotate,[ccw],Time) : carrying(0,1,_)
<-	-carrying(0,1,_);
		+carrying(1,0,Time).

+!updateBlock(_,_,_,Time) : carrying(X,Y,_)
<-	-carrying(X,Y,_);
		+carrying(X,Y,Time).

+!updateBlock(_,_,_,Time)
<-	true.
///////////////////////////////////////////////////////////////////////////
