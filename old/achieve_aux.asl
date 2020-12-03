+?group(M,R) : .my_name(Me) & not busy(Me) & not taken(_,_,Me) <- +busy(Me);R = true;+workingWith(M);.drop_all_intentions;.broadcast(tell,busy(Me)).
+?group(M,R) <- R = false.

+!skip <- !performAction(skip);!skip.

+!achieve(XA,YA,XB,YB,B,XM,YM,M) : workingWith(M) & not .intend(achieve(XA,YA,XB,YB,B,XM,YM,M)) <-
	.drop_all_intentions;
	!goTo(dispenser,B);
	!getBlock(B);
	!goTo(XA,YA);
	!rotateBlock(XB-XA,YB-YA,B);
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
