+!achieve <- 
	.findall(disp(X,Y),thing(X,Y,dispenser,B),Dispensers);
	.shuffle(Dispensers,ShufDisp);
	.nth(0,ShufDisp,disp(X,Y));
	!goTo(X,Y);
	!performAction(skip);
	?thing(0,0,dispenser,_,_);
	!performAction(skip);
	!achieve.
	
	
+!achieve <-
	!removeMoving;
	.my_name(Me);
	+busy(Me);
	.broadcast(tell,busy(Me));
	!goTo(taskboard);
	!checkTaskboard;
	!getTask;
	?taken(T,Reqs,Me);
	.length(Reqs,R);
	!achieve(R);
	-busy(Me);
	.broadcast(untell,busy(Me));
	!!achieve.
	
	
+!achieve(2) <-
	.my_name(M);
	?istaken(T,[req(XReqA,YReqA,BlockTypeA),req(XReqB,YReqB,BlockTypeB)],M);
	!selectAgent(1,BlockTypeB);
	!getGoal(XGoal,YGoal);
	!calcBlockAndAgentPosition(XReqA,YReqA,XReqB,YReqB,BlockTypeB,XGoal,YGoal);//askAgent for block and goal
	!goTo(dispenser,BlockTypeA);
	!checkDispenser(BlockTypeA);
	!getBlock(BlockTypeA);
	!goTo(XGoal,YGoal);
	!rotateBlock(BlockTypeA,s);
	!waitAg(1);
	!connectBlock(1);
	!performAction(submit(T));
	-agPos(_,_,_).

+!removeMoving : moving(_) <- -moving(_).
+!removeMoving <- true.

+!goTo(taskboard) : position(me,Xme,Yme,_) & thing(_,_,taskboard) <-
	.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),thing(X,Y,taskboard),L);
	.min(L,g(D,XG,YG));
	!goTo(XG,YG).
	
+!goTo(taskboard) : not position(me,Xme,Yme,_)<-
	.wait("+position(me,_,_,_)");
	!goTo(taskboard).
+!goTo(taskboard) : not thing(TX,TY,taskboard)<-
	//TODO: add fail state
	.fail.

+!checkTaskboard : position(me,Xme,Yme,T) & thing(0,0,taskboard,_,T) <- true.
+!checkTaskboard : position(me,Xme,Yme,T) & not thing(0,0,taskboard,_,T) & thing(Xme,Yme,taskboard) <-
	.print("removing taskboard");
	-thing(Xme,Yme,taskboard);
	!goTo(taskboard);
	!checkTaskboard.
+!checkTaskboard : position(me,Xme,Yme,T) & not thing(0,0,taskboard,_,T) <-
	!goTo(taskboard);
	!checkTaskboard.	
+!checkTaskboard : not position(me,Xme,Yme,_) <-
	.wait("+position(me,_,_,_)");
	!checkTaskboard.

+!getTask <-
	.findall(X,task(N,X,_,[req(_,_,_),req(_,_,_)],_) & not taken(N,_,_),Deadlines);
	if(Deadlines == []){
		!performAction(skip);
		!getTask;
	}
	else{
		.max(Deadlines,Dead);
		?task(Name,Dead,_,Req,_);
		.print(" Taking ",Name);
		!performAction(accept(Name));
		.my_name(Me);
		?taken(_,Req,Me);
	}.

+?istaken(T,[req(XA,YA,A),req(XB,YB,B)],M) : taken(T,[req(0,1,A),req(XB,YB,B)],M) <- XA = 0;YA = 1.
+?istaken(T,[req(XA,YA,A),req(XB,YB,B)],M) : taken(T,[req(XB,YB,B),req(0,1,A)],M) <- XA = 0;YA = 1.

	
+!selectAgent(I,BlockTypeB) : available(M) & mapper(M,_,_) & not busy(M) & not taken(_,_,M) <-
		.my_name(Me);
		.send(M,askOne,group(Me,Reply,BlockTypeB),group(Me,Reply,BlockTypeB));
		if (Reply == true){
			+worker(M,I);
			+busy(M);
		}
		else{
			+busy(M);
			!selectAgent(I,BlockTypeB);
		}.
+!selectAgent(I,BlockTypeB) <- .print("No agents available for selection.");!performAction(skip);!selectAgent(I,BlockTypeB).
	
+!getGoal(XG,YG) : position(me,Xme,Yme,_) <-
	.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),goal(X,Y),L);
	.min(L,g(_,XG,YG));
	?goal(XG,YG).
+!getGoal(XG,YG) : not position(me,Xme,Yme,_) <-
	.wait("+position(me,_,_,TIME)");
	!getGoal(XG,YG).
	

+!calcBlockAndAgentPosition(XReqA,YReqA,XReqB,YReqB,BlockTypeB,XGoal,YGoal) : XReqA=XReqB & worker(Worker,1) & mapper(Worker,XWorkerMap,YWorkerMap)
<-  +agPos(Worker,XReqB+1,YReqB);
	.my_name(Me);
	.send(Worker,achieve,achieve(Me,XGoal+XReqB+1+XWorkerMap,YGoal+YReqB+YWorkerMap,BlockTypeB,w)). //bloco em baixo
+!calcBlockAndAgentPosition(XReqA,YReqA,XReqB,YReqB,BlockTypeB,XGoal,YGoal) : YReqA=YReqB & worker(Worker,1) & mapper(Worker,XWorkerMap,YWorkerMap)
<-  +agPos(Worker,XReqB,YReqB-1);
	.my_name(Me);
	.send(Worker,achieve,achieve(Me,XGoal+XReqB+XWorkerMap,YGoal+YReqB+YWorkerMap-1,BlockTypeB,s)). //bloco ao lado


+!goTo(dispenser,B) : position(me,Xme,Yme,_) & thing(_,_,dispenser,B) <-
	.setof(g(((X-Xme)**2)+((Y-Yme)**2),X,Y),thing(X,Y,dispenser,B),L);
	.min(L,g(_,XG,YG));
.print("going to ",XG,":",YG);
	!goTo(XG,YG).
+!goTo(dispenser,B) : not position(me,Xme,Yme,_) <-
	.wait("+position(me,_,_,_)");
	!goTo(dispenser,B).
+!goTo(dispenser,B) : not thing(_,_,dispenser,B) <-
	//TODO: add fail state
	.fail.

+!checkDispenser(A) : position(me,Xme,Yme,T) & thing(0,0,dispenser,A,T) <- .print("at dispenser").
+!checkDispenser(A) : position(me,Xme,Yme,T) & thing(Xme,Yme,dispenser,A) & not thing(0,0,dispenser,A,T) <-
.print("removing wrong dispenser");
	.abolish(thing(Xme,Yme,dispenser,A));
	!goTo(dispenser,A);
	!checkDispenser(A).
+!checkDispenser(A) : not position(me,Xme,Yme,_) <-
	.wait("+position(me,_,_,_)");
	!checkDispenser(A).
	
+!getBlock(B) : not blocked(0,+1,_) <- !getBlock(B,s).
+!getBlock(B,s) <- !performAction(move(s));!performAction(request(n));!performAction(attach(n));+hasBlock(n).
-!getBlock(B,s) : not thing(0,0,dispenser,B,T) <- ?position(me,X,Y,_); !goto(X,Y+1);!getBlock(B).

+!getBlock(B) : not blocked(0,-1,_) <- !getBlock(B,n).
+!getBlock(B,n) <- !performAction(move(n));!performAction(request(s));!performAction(attach(s));+hasBlock(s).
-!getBlock(B,n) : not thing(0,0,dispenser,B,T) <- ?position(me,X,Y,_); !goto(X,Y-1);!getBlock(B).

+!getBlock(B) : not blocked(-1,0,_) <- !getBlock(B,w).
+!getBlock(B,w) <- !performAction(move(w));!performAction(request(e));!performAction(attach(e));+hasBlock(e).
-!getBlock(B,w) : not thing(0,0,dispenser,B,T) <- ?position(me,X,Y,_); !goto(X-1,Y);!getBlock(B).

+!getBlock(B) : not blocked(+1,0,_) <- !getBlock(B,e).
+!getBlock(B,e) <- !performAction(move(e));!performAction(request(w));!performAction(attach(w));+hasBlock(w).
-!getBlock(B,e) : not thing(0,0,dispenser,B,T) <- ?position(me,X,Y,_); !goto(X+1,Y);!getBlock(B).

-!getBlock(B) : thing(0,0,dispenser,B,T) <- !getBlock(B).

-!getBlock(B) : thing(XD,YD,dispenser,B,T) & not thing(_,_,block,B,_) <- ?position(me,X,Y,_);!goTo(X+XD,Y+YD);!getBlock(B).
	
+!rotateBlock(BlockType,Dir) <- !rotateBlock(BlockType,Dir,cw).

+!rotateBlock(BlockType,Dir,RDir) : hasBlock(Dir) & seeBlock(Dir) <- true.
+!rotateBlock(BlockType,Dir,RDir) : hasBlock(CurDir) & seeBlock(CurDir) <- !performAction(rotate(RDir));!rotateBlock(BlockType,Dir,RDir).
+!rotateBlock(BlockType,Dir,_) : hasBlock(CurDir) & not seeBlock(CurDir) <- 
	//TODO: add fail state
	.fail.
+!rotateBlock(BlockType,Dir,_) : not hasBlock(_) <- 
	//TODO: add fail state
	.fail.
-!rotateBlock(BlockType,Dir,cw) <- !rotateBlock(BlockType,Dir,ccw).
-!rotateBlock(BlockType,Dir,ccw) <- !rotateBlock(BlockType,Dir,cw).

+!waitAg(1) : worker(M,1) & 
			  agPos(M,XAg,YAg) & 
			  thing(XAg,YAg,entity,_,_) & 
			  .my_name(Me) & 
			  taken(N,R,Me) & 
			  task(N,_,_,[req(_,_,_),req(XReqB,YReqB,BlockTypeB)],_) &
			  thing(XReqB,YReqB,block,BlockTypeB,_)<- .print("Finished waiting for ",M).
+!waitAg(1) : .my_name(Me) & taken(N,R,Me) & not task(N,_,_,_,_) <- ?worker(M,1);.send(M,unachieve,achieve(_,_,_,_,_));.fail. //desiste da task.
+!waitAg(1) : worker(M,1) <- .print("Waiting for ",M);!performAction(skip);!waitAg(1).

+!connectBlock(1) : worker(M,1) & .my_name(Me) & taken(T,[req(XA,YA,A),req(XB,YB,B)],Me) <- !performAction(connect(M,XA,YA)).
+!connectBlock(1) <- .print(" Error connecting block");.fail. //TODO: add fail state

+!handleLastActionResult(ACTION,TIME,success,accept,[N])
    <- 	!updatePosition(TIME);.my_name(M);?task(N,_,_,R,_);.broadcast(tell,taken(N,R,M));+taken(N,R,M);.print("Accepted ",N).

+!handleLastActionResult(ACTION,TIME,success,submit,LAP)
	<- 	.print("--------------------------------------------------------SCORE!");
		!updatePosition(TIME);.my_name(M);?taken(N,R,M);.abolish(taken(_,_,M));.broadcast(untell,taken(N,R,M)).

