+thing(0,0,entity,_,T) <- true.
+thing(X,Y,entity,TEAM,T) : position(me,XM,YM,T) & team(TEAM) <- 
	+entity(X,Y,T);
	.my_name(M);
	.broadcast(tell,acknowledge(M,X,Y,XM,YM,T)).
+thing(X,Y,entity,TEAM,T) : not position(me,XM,YM,T) & team(TEAM) <- 
	.wait("+position(me,_,_,TIME)");
	?position(me,XM,YM,TIME);
	+entity(X,Y,T);
	.my_name(M);
	.broadcast(tell,acknowledge(M,X,Y,XM,YM,T)).

+position(me,XM,YM,T) <- +logposition(me,XM,YM,T).

+stepLog(STEP,_): stepLog(STEP-2,TIME) & acknowledge(_,_,_,_,_,TIME) & entity(_,_,TIME) <- 
for ( entity(XE,YE,TIME) ) {
	.setof(acknowledge(M,-XE,-YE,XM,YM,TIME),acknowledge(M,-XE,-YE,XM,YM,TIME),Acks);
	if (.length(Acks,1)){
		.nth(0,Acks,acknowledge(M,_,_,XA,YA,TIME))
		?logposition(me,XM,YM,TIME);
		+mapper(M,XA-(XM+XE),YA-(YM+YE),XE,YE,TIME);
		X1 = XA-(XM+XE);
		Y1 = YA-(YM+YE);
		.count(mapper(_,_,_,_,_,_),Mapps);
		-recognized(_);
		+recognized(Mapps);
		for ( thing(X,Y,dispenser,B) ) {
			.send(M,tell,thing(X+X1,Y+Y1,dispenser,B));
		}
		for ( thing(X,Y,taskboard) ) {
			.send(M,tell,thing(X+X1,Y+Y1,taskboard));
		}
		for ( goal(X,Y) ) {
			.send(M,tell,goal(X+X1,Y+Y1));
		}
	}
}.

/*
+!acknowledge(M,X,Y,XA,YA,T) : log(Ag,X,Y,T) <- 
	.abolish(mapper(_,_,_,X,Y,T));
	.count(mapper(_,_,_,_,_,_),Mapps);
	-recognized(_);
	+recognized(Mapps).

+!acknowledge(M,X,Y,XA,YA,T) : maxAgents(Max) & recognized(Max) & nolog <- true.
+!acknowledge(M,X,Y,XA,YA,T) : maxAgents(Max) & recognized(Max) <- .abolish(log(_,_,_,_));+nolog.

+!acknowledge(M,X,Y,XM,YM,T) : mapper(M,_,_,_,_,_) <- +log(M,X,Y,T).

+!acknowledge(M,X,Y,XA,YA,T) : position(me,XM,YM,T) & thing(-X,-Y,entity,_,T)
	<- +log(M,X,Y,T);
	.print(M," ",X," ",Y," ",XA," ",YA," ",XM," ",YM," ",XA-(XM-X)," ",YA-(YM-Y));
	+mapper(M,XA-(XM-X),YA-(YM-Y),X,Y,T);
	.count(mapper(_,_,_,_,_,_),Mapps);
	-recognized(_);
	+recognized(Mapps).
	
+!acknowledge(M,X,Y,XA,YA,T) : not thing(-X,-Y,entity,_,T) | not position(me,XM,YM,T)<- true.
*/
