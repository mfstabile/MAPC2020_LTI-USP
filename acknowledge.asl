+thing(0,0,entity,_,T) <- true.
+thing(X,Y,entity,_,T) : position(me,XM,YM,T)  <- .my_name(M);.broadcast(achieve,acknowledge(M,X,Y,XM,YM,T)).

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
