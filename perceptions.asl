
//DISPENSER
+thing(X,Y,dispenser,B,TIME) : position(me,XM,YM,TIME) & not thing(X+XM,Y+YM,dispenser,B) <-
	!addDispenser(X,XM,Y,YM,B).
+thing(X,Y,dispenser,B,TIME) : not position(me,XM,YM,TIME) <- 
	.wait("+position(me,_,_,TIME)");
	?position(me,XM,YM,TIME);
	if(not thing(X+XM,Y+YM,dispenser,B)){
		!addDispenser(X,XM,Y,YM,B);
	}.

+!addDispenser(X,XM,Y,YM,B) <-
	+thing(X+XM,Y+YM,dispenser,B);// !checkDispensers;
	for ( mapper(A,XA,YA) ) {
		.send(A,tell,thing(X+XM+XA,Y+YM+YA,dispenser,B));
    }.
	
+!checkDispensers : thing(_,_,dispenser,b0) & 
					thing(_,_,dispenser,b1) & 
					thing(_,_,dispenser,b2) & 
					.my_name(M) & not available(M) 
<- +available(M);.broadcast(tell,available(M)).
+!checkDispensers <- true.

//TASKBOARD
+thing(X,Y,taskboard,_,TIME) : position(me,XM,YM,TIME) <-
	+thing(X+XM,Y+YM,taskboard);
	for ( mapper(A,XA,YA) ) {
    	.send(A,tell,thing(X+XM+XA,Y+YM+YA,taskboard));
    }.
+thing(X,Y,taskboard,_,TIME) : not position(me,XM,YM,TIME) <-
	.wait("+position(me,_,_,TIME)");
	?position(me,XM,YM,TIME);
	+thing(X+XM,Y+YM,taskboard);
	for ( mapper(A,XA,YA) ) {
    	.send(A,tell,thing(X+XM+XA,Y+YM+YA,taskboard));
    }.


//GOAL	
//+goal(X,Y,TIME) : goal(X+1,Y,TIME) & goal(X-1,Y,TIME) & goal(X,Y+1,TIME) & goal(X,Y-1,TIME) & position(me,XM,YM,TIME)<- 
+goal(X,Y,TIME) : position(me,XM,YM,TIME)<- 
	+goal(X+XM,Y+YM);
	for ( mapper(A,XA,YA) ) {
    	.send(A,tell,goal(X+XM+XA,Y+YM+YA));
    }.
//+goal(X,Y,TIME) : goal(X+1,Y,TIME) & goal(X-1,Y,TIME) & goal(X,Y+1,TIME) & goal(X,Y-1,TIME) & not position(me,XM,YM,TIME)<- 
+goal(X,Y,TIME) : not position(me,XM,YM,TIME)<- 
	.wait("+position(me,_,_,TIME)");
	?position(me,XM,YM,TIME);
	+goal(X+XM,Y+YM);
	for ( mapper(A,XA,YA) ) {
    	.send(A,tell,goal(X+XM+XA,Y+YM+YA));
    }.

