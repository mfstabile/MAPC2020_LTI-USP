//+!achieve : .intend(achieve) | .intend(achieve(N)) <- .print(" -----------------------New achieve").
+!achieve : maxAgents(Ags) & .count(taken(_,_,_),T) & T > Ags/3 <- !!explore.//keep exploring - talvez mudar em função dos busy e conhecidos

+!achieve <- 
	!removeMoving;
	.my_name(Me);
	+busy(Me);
	.broadcast(tell,busy(Me))
	!goTo(taskboard);
	!getTask;//Verificar se o retorno é o nome de uma task
	.my_name(M);
	?taken(T,Reqs,M);
	.length(Reqs,R);
	!achieve(R);
	-busy(Me);
	.broadcast(untell,busy(Me))
	!!explore.

+!removeMoving : moving(_) <- -moving(_).
+!removeMoving <- true.

+!achieve(1) <- 
	?taken(T,[req(XB,YB,B)],M);
	!goTo(dispenser,B);
	!getBlock(B);
	!goTo(goal);
	!rotateBlock(XB,YB,B);
	!performAction(submit(T)).
	
+!achieve(2) <- 
	.my_name(M);
	?istaken(T,[req(XA,YA,A),req(XB,YB,B)],M);
	!selectAgent(1);
	!getGoal(XG,YG);
	!calcBlockAndAgentPosition(XA,YA,XB,YB,B,XG,YG);//askAgent for block and goal
	!goTo(dispenser,A);
	!getBlock(A);
	!goTo(XG,YG);
	!rotateBlock(XA,YA,A);
	!waitAg(1);
	!connectBlock(1);
	!performAction(submit(T));
	-agPos(_,_,_,_,_,_).
	
+!achieve(3) <- 
	.my_name(M);
	?taken(T,[req(XA,YA,A),req(XB,YB,B),req(XC,YC,C)],M);
	//select agent
	//askAgent for block and goal
	!goTo(dispenser,A);
	!getBlock(A);
	!goTo(goal);
	!rotateBlock(XA,YA,A);
	//waitAgent
	//connectBlock
	!performAction(submit(T)).

+!getGoal(XG,YG) : position(me,Xme,Yme,_) <- 
.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),goal(X,Y),L);
.min(L,g(_,XG,YG));
?goal(XG,YG).

-!getGoal(XG,YG) <- .print("------------------ERROU");.fail.
	
+!selectAgent(I) : available(M) & mapper(M,_,_,_,_,_) & not busy(M) & not taken(_,_,M) <- 
		.my_name(Me);
		.send(M,askOne,group(Me,R),group(Me,Reply),30000);
		if (Reply == true){
			+worker(M,I);
			+busy(M);
		}
		else{
			+busy(M);
			!selectAgent(I);
		}.
		
+!selectAgent(I) <- .print(" Select agent failed");!performAction(skip);!selectAgent(I).

+?istaken(T,[req(XA,YA,A),req(XB,YB,B)],M) : taken(T,[req(0,1,A),req(XB,YB,B)],M) <- XA = 0;YA = 1.
+?istaken(T,[req(XA,YA,A),req(XB,YB,B)],M) : taken(T,[req(XB,YB,B),req(0,1,A)],M) <- XA = 0;YA = 1.

//Calc: X,YA:X,YAgent ~ X,YB: X,YBlock ~ B:Blocktype
+!calcBlockAndAgentPosition(XA,YA,XB,YB,B,XG,YG) : XA=XB & worker(M,1) & mapper(M,X,Y,_,_,_)
	<- +agPos(M,XB+1,YB,XB,YB,B);.my_name(Me);.send(M,achieve,achieve(XG+XB+1+X,YG+YB+Y,XG+XB+X,YG+YB+Y,B,XG+XA+X,YG+YA+Y,Me)). //em baixo
+!calcBlockAndAgentPosition(XA,YA,XB,YB,B,XG,YG) : YA=YB & worker(M,1) & mapper(M,X,Y,_,_,_)
	<- +agPos(M,XB,YB-1,XB,YB,B);.my_name(Me);.send(M,achieve,achieve(XG+XB+X,YG+YB-1+Y,XG+XB+X,YG+YB+Y,B,XG+XA+X,YG+YA+Y,Me)). //ao lado

+!waitAg(1) : worker(M,1) & agPos(M,XAg,YAg,XBl,YBl,Bl) & thing(XAg,YAg,entity,_,_) & thing(XBl,YBl,block,_,_) <- .print("Finished waiting for ",M).
+!waitAg(1) : .my_name(Me) & taken(N,R,Me) & not task(N,_,_,_,_) <- ?worker(M,1);.send(M,unachieve,achieve(_,_,_,_,_,_,_,_));.fail. //desiste da task.
+!waitAg(1) : worker(M,1) <- .print("Waiting for ",M);!performAction(skip);!waitAg(1).
//TODO: add cldesiste 

-!achieve : hasBlock(_) <- !moveandclear;-hasBlock(_);!!explore.//TODO: clear missions?

+!connectBlock(1) : worker(M,1) & taken(T,[req(XA,YA,A),req(XB,YB,B)],N) <- !performAction(connect(M,XA,YA)).
+!connectBlock(1) <- .print(" Error connecting block");.fail.
-!connectBlock(1) <- !connectBlock(1).
//Get perform action connect fail

//+!goTo(taskboard) : thing(XT,YT,taskboard) <- !goTo(XT,YT).
+!goTo(taskboard) : position(me,Xme,Yme,_) & thing(_,_,taskboard) <- 
.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),thing(X,Y,taskboard),L);
.min(L,g(_,XG,YG));
!goTo(XG,YG).


+!getTask <- //!clearTasks;
	.findall(X,task(N,X,_,[req(_,_,_),req(_,_,_)],_) & not taken(N,_,_),Deadlines);
	if(Deadlines == []){
		!performAction(skip);!getTask;
	}
	else{
		.max(Deadlines,D);?task(N,D,_,R,_);.print(" Taking ",N);!performAction(accept(N));.my_name(M);?taken(_,R,M);
	}.
//-!getTask <- !getTask.

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(accept,_) & lastActionParams([N],_)
	<- 	!updatePosition(TIME);.my_name(M);?task(N,_,_,R,_);.broadcast(tell,taken(N,R,M));+taken(N,R,M);.print("Accepted ",N).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(submit,_) & lastActionParams(_,_)
	<- 	.print("--------------------------------------------------------SCORE!");
		!updatePosition(TIME);.my_name(M);?taken(N,R,M);.abolish(taken(_,_,M));.broadcast(untell,taken(N,R,M)).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_target,_) & lastAction(submit,_) & lastActionParams([T],_) & not task(T,_,_,_,_,_)
	<- 	!updatePosition(TIME);.my_name(M);?taken(N,R,M);.abolish(taken(_,_,M));.broadcast(untell,taken(N,R,M));?worker(W,_);-worker(W,_);.send(W,unachieve,achieve(_,_,_,_,_,_,_,_));!moveandclear.


-!getTask : thing(0,0,taskboard,_,_) <- .print("taskboard problem 1");!getTask.
-!getTask : not thing(X,Y,taskboard,_,TIME) & thing(XM,YM,taskboard) & position(me,XM,YM,TIME) <- .print("taskboard problem 2");-thing(XM,YM,taskboard);!goTo(taskboard);!getTask.
-!getTask : not thing(XM,YM,taskboard) <- .print("taskboard problem 3");.drop_all_intentions;!!explore.
-!getTask <- .print("taskboard problem 4");!goTo(taskboard);!getTask.

+!clearTasks : task(_,X,_,_,_) & taken(X) <- -task(_,X,_,_,_);!clearTasks.
+!clearTasks <- true.

//+!goTo(dispenser,B) : thing(XT,YT,dispenser,B) <- !goTo(XT,YT);?position(me,XT,YT,T);?thing(0,0,dispenser,B,T);.print("Em cima do dispenser").
+!goTo(dispenser,B) : position(me,Xme,Yme,_) & thing(_,_,dispenser,B) <- 
.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),thing(X,Y,dispenser,B),L);
.min(L,g(_,XG,YG));
!goTo(XG,YG);
?position(me,XG,YG,T);!checkDispenser;.print("Em cima do dispenser").

+!checkDispenser <- ?thing(0,0,dispenser,B,T).
-!checkDispenser : position(me,Xme,Yme,T) & thing(X,Y,dispenser,B,T) & thing(Xme,Yme,dispenser,B)<- -thing(Xme,Yme,dispenser,B);!goTo(XME+X,YME+Y).
-!checkDispenser : position(me,Xme,Yme,T) & not thing(X,Y,dispenser,B,T) & thing(Xme,Yme,dispenser,B)<- -thing(Xme,Yme,dispenser,B);!goTo(dispenser,B).

//-!goTo(dispenser,B) : position(me,XM,YM,T) & thing(XT,YT,dispenser,B) & XM\==XT & YM\==YT <- !goTo(dispenser,B).
-!goTo(dispenser,B) : position(me,XM,YM,T) & thing(XT,YT,dispenser,B) & not thing(0,0,dispenser,B,T) <- -thing(XT,YT,dispenser,B);!goTo(dispenser,B).
-!goTo(dispenser,B) : not thing(XT,YT,dispenser,B) <- .drop_all_intentions;!!explore.

+!getBlock(B) : not blocked(0,+1,_) <- !performAction(move(s));!performAction(request(n));!performAction(attach(n));+hasBlock(n).
+!getBlock(B) : not blocked(0,-1,_) <- !performAction(move(n));!performAction(request(s));!performAction(attach(s));+hasBlock(s).
+!getBlock(B) : not blocked(-1,0,_) <- !performAction(move(w));!performAction(request(e));!performAction(attach(e));+hasBlock(e).
+!getBlock(B) : not blocked(+1,0,_) <- !performAction(move(e));!performAction(request(w));!performAction(attach(w));+hasBlock(w).

-!getBlock(B) : thing(0,0,dispenser,B,T) <- !getBlock(B).
-!getBlock(B) : thing(XD,YD,dispenser,B,T) & not thing(_,_,block,B,_) <- ?position(me,X,Y,_);!goTo(X+XD,Y+YD);!getBlock(B).

+!goTo(goal) : goal(X,Y) <- !goTo(X,Y).
-!goTo(goal) : goal(X,Y) <- !goTo(X,Y).

+!rotateBlock(XB,YB,B) : thing(XB,YB,block,B,_) <- true.
+!rotateBlock(XB,YB,B) : thing(XB,YB,_,B,_) <- !performAction(skip);!rotateBlock(XB,YB,B).
+!rotateBlock(XB,YB,B) <- !performAction(rotate(cw));!rotateBlock(XB,YB,B).
-!rotateBlock(XB,YB,B) <- !performAction(skip);!rotateBlock(XB,YB,B).

+!moveandclear : team(Team) & .count(thing(_,_,entity,TEAM,_),N) & N < 2 <- !performAction(clear(0,0)). // is alone
+!moveandclear <- 
	.random(R);
	if (R < 0.25) {
       !performAction(move(n));
    }elif (R < 0.5) {
       !performAction(move(e));
    }elif (R < 0.75) {
       !performAction(move(s));
    }else{
       !performAction(move(w));		
	}!moveandclear.

