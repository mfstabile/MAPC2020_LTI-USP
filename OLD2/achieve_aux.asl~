+?group(Ag,Reply,BlockTypeB) : .my_name(Me) & not busy(Me) & not taken(_,_,Me) & thing(_,_,dispenser,BlockTypeB) 
<-	+busy(Me);
	Reply = true;
	+workingWith(Ag);
	.broadcast(tell,busy(Me)).
+?group(Ag,Reply,BlockTypeB) <- Reply = false.


+!achieve(Ag,XGoal,YGoal,BlockTypeB,Dir) : workingWith(Ag) & not .intend(achieve(_,_,_,_,_))
<-	.drop_all_intentions;
.print("going to dispenser ",BlockTypeB);
	!goTo(dispenser,BlockTypeB);
.print("checkDispenser ",BlockTypeB);
	!checkDispenser(BlockTypeB);
.print("getBlock ",BlockTypeB);
	!getBlock(BlockTypeB);
	!goTo(XGoal,YGoal);
	!rotateBlock(BlockTypeB,Dir);
	!waitLeader;
	!connectBlock(Ag,BlockTypeB,Dir);
	!detach(Dir);
	.broadcast(untell,busy(Me));
	!!explore.
	
+!connectBlock(Ag,BlockTypeB,Dir) 
<-	!getDir(Dir,XDir,YDir);
	!performAction(connect(Ag,XDir,YDir)).
	
-!connectBlock(Ag,BlockTypeB,Dir) <- !connectBlock(Ag,BlockTypeB,Dir) .

+!waitLeader : team(TEAM) & thing(X,Y,entity,TEAM,_) & (X\==0|Y\==0) & .count(thing(X,Y,block,_,_),Blocks) & Blocks > 1<- true.
+!waitLeader <- !performAction(skip);!waitLeader.

+!getDir(s,XDir,YDir) <- XDir = 0;YDir = 1.
+!getDir(n,XDir,YDir) <- XDir = 0;YDir = -1.
+!getDir(e,XDir,YDir) <- XDir = 1;YDir = 0.
+!getDir(w,XDir,YDir) <- XDir = -1;YDir = 0.

+!detach(Dir) <- !performAction(detach(Dir));-hasBlock(_).

/*
+!achieve(XA,YA,XB,YB,B,XM,YM,M) : workingWith(M) & not .intend(achieve(XA,YA,XB,YB,B,XM,YM,M)) <-
	

	!connectBlock(XA,YA,XB,YB,B,XM,YM,M);
	!detach;
	//	!performAction(disconnect(XB-XA,YB-YA));
	.broadcast(untell,busy(Me));
	!!explore.
	
+!achieve(XA,YA,XB,YB,B,XM,YM,M) <- .print("Agent ",M, " sent achieve without consent"). 
	
+!connectBlock(XA,YA,XB,YB,B,XM,YM,M) : not goal(X,Y,TIME) <- .print("Directions Failed");!performAction(skip);!goTo(XA,YA);!connectBlock(XA,YA,XB,YB,B,XM,YM,M).
+!connectBlock(XA,YA,XB,YB,B,XM,YM,M) : workingWith(M) & thing(XM-XA,YM-YA,block,_,_) <- !performAction(connect(M,XB-XA,YB-YA)).
+!connectBlock(XA,YA,XB,YB,B,XM,YM,M) <- !performAction(skip);!connectBlock(XM,YM).

-!connectBlock(XA,YA,XB,YB,B,XM,YM,M) <- !connectBlock(XA,YA,XB,YB,B,XM,YM,M).

+!detach : hasBlock(s) <- !performAction(detach(s));-hasBlock(_).
+!detach : hasBlock(n) <- !performAction(detach(n));-hasBlock(_).
+!detach : hasBlock(e) <- !performAction(detach(e));-hasBlock(_).
+!detach : hasBlock(w) <- !performAction(detach(w));-hasBlock(_).
+!detach : not hasBlock(_) <- .print("Não tem bloco?").
+!detach : hasBlock(_) & not attached(_,_,_) <- -hasBlock(_).
-!detach : hasBlock(X) <- -hasBlock(X).
*/
