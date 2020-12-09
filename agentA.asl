{ include("knowledge.asl") }
{ include("mapping.asl") }

position(0,0,0).

blocked(n) :- obstacle(0,-1,T) | thing(0,-1,entity,_,T).
blocked(s) :- obstacle(0,+1,T) | thing(0,+1,entity,_,T).
blocked(e) :- obstacle(+1,0,T) | thing(+1,0,entity,_,T).
blocked(w) :- obstacle(-1,0,T) | thing(-1,0,entity,_,T).


!chooseDirection.

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
	}
	!walk.


+!walk
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
	!walk.

+!performAction(Action)
<-	Action;
		.wait("+step(_,Time)").

+!getLastPosition(X,Y)
<-	.findall(Timestamp, position(_,_,Timestamp), TimestampList);
		.max(TimestampList, Max);
		?position(X,Y,Max).

+!updatePosition(success,move,[n],Time)
<-	!getLastPosition(X,Y);
		+position(X,Y-1,Time).

+!updatePosition(success,move,[s],Time)
<-	!getLastPosition(X,Y);
		+position(X,Y+1,Time).

+!updatePosition(success,move,[e],Time)
<-	!getLastPosition(X,Y);
		+position(X+1,Y,Time).

+!updatePosition(success,move,[w],Time)
<-	!getLastPosition(X,Y);
		+position(X-1,Y,Time).

+!updatePosition(_,_,_,Time)
<-	!getLastPosition(X,Y);
		+position(X,Y,Time).
