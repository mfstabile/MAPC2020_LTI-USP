+thing(X,Y,dispenser,B,TIME) : position(me,XM,YM,TIME) & not thing(X+XM,Y+YM,dispenser,B)<-
	+thing(X+XM,Y+YM,dispenser,B); !checkDispensers;
	for ( mapper(A,_,_) ) {
    	?mapper(A,XA,YA);
		.send(A,tell,thing(X+XM+XA,Y+YM+YA,dispenser,B));
    }.
	
+!checkDispensers : thing(_,_,dispenser,b0) & thing(_,_,dispenser,b1) & thing(_,_,dispenser,b2) & .my_name(M) & not available(M) <- +available(M);.broadcast(tell,available(M)).
+!checkDispensers <- true.

+!stop <- !performAction(skip);!stop.
	
+thing(X,Y,taskboard,_,TIME) : position(me,XM,YM,TIME) <-
	+thing(X+XM,Y+YM,taskboard);
	for ( mapper(A,_,_) ) {
    	?mapper(A,XA,YA);
		.send(A,tell,thing(X+XM+XA,Y+YM+YA,taskboard));
    }.
	
+goal(X,Y,TIME) : goal(X+1,Y,TIME) & goal(X-1,Y,TIME) & goal(X,Y+1,TIME) & goal(X,Y-1,TIME) & position(me,XM,YM,TIME)<- 
	+goal(X+XM,Y+YM);
	for ( mapper(A,_,_) ) {
    	?mapper(A,XA,YA);
		.send(A,tell,goal(X+XM+XA,Y+YM+YA));
    }.
	
//+obstacle(X,Y,TIME) : position(me,XM,YM,TIME)<- 
//	+obstacle(X+XM,Y+YM).

blocked(X,Y,_) :- obstacle(X,Y,_) | thing(X,Y,entity,_,_) | thing(X,Y,block,_,_).
