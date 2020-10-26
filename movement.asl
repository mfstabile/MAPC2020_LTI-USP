+!pgoTo(X,Y) <- .drop_all_intentions;!goTo(X,Y);!pula(600).

+!goTo(X,Y) : position(me,X,Y,_) <- .print(" CHEGUEI!");-movingsideways.//true. //está no lugar certo

+!goTo(X,Y) : position(me,A,B,_) & Y > B & not blocked(0,+1,_) & not movingsideways <- !performAction(move(s));!goTo(X,Y).
+!goTo(X,Y) : position(me,A,B,_) & Y > B & blocked(0,1,_) & not movingsideways <- !desvia(w);!goTo(X,Y).//print("Parou por block1");.

+!goTo(X,Y) : position(me,A,B,_) & Y < B & not blocked(0,-1,_) & not movingsideways <- !performAction(move(n));!goTo(X,Y).
+!goTo(X,Y) : position(me,A,B,_) & Y < B & blocked(0,-1,_) & not movingsideways <- !desvia(e);!goTo(X,Y).//print("Parou por block2").

+!goTo(X,Y) : position(me,A,B,_) & Y == B & not movingsideways <- +movingsideways;!goTo(X,Y).

+!goTo(X,Y) : position(me,A,B,_) & X < A & not blocked(-1,0,_) <- !performAction(move(w));!goTo(X,Y).
+!goTo(X,Y) : position(me,A,B,_) & X < A & blocked(-1,0,_) <- !desvia(n);!goTo(X,Y).//print("Parou por block3").

+!goTo(X,Y) : position(me,A,B,_) & X > A & not blocked(1,0,_) <- !performAction(move(e));!goTo(X,Y).
+!goTo(X,Y) : position(me,A,B,_) & X > A & blocked(1,0,_) <- !desvia(s);!goTo(X,Y).//print("Parou por block4");.

+!goTo(X,Y) : position(me,A,B,_) & X == A & movingsideways <- -movingsideways;!goTo(X,Y).

+!goTo(X,Y) : position(me,A,B,_) <- .print(" ué").

+!desvia(s) : position(me,A,B,_) & not blocked(0,1,_) <- !performAction(move(s)).//print("Parou por block1");.
+!desvia(n) : position(me,A,B,_) & not blocked(0,-1,_) <- !performAction(move(n)).//print("Parou por block2").
+!desvia(w) : position(me,A,B,_) & not blocked(-1,0,_) <- !performAction(move(w)).//print("Parou por block3").
+!desvia(e) : position(me,A,B,_) & not blocked(1,0,_) <- !performAction(move(e)).//print("Parou por block4");.

+!desvia(s) : position(me,A,B,_) & blocked(0,1,_) <- !desvia(w);!desvia(s).//print("Parou por block1");.
+!desvia(n) : position(me,A,B,_) & blocked(0,-1,_) <- !desvia(e);!desvia(n).//print("Parou por block2").
+!desvia(w) : position(me,A,B,_) & blocked(-1,0,_) <- !desvia(n);!desvia(w).//print("Parou por block3").
+!desvia(e) : position(me,A,B,_) & blocked(1,0,_) <- !desvia(s);!desvia(e).//print("Parou por block4");.


+!desvia(X) <- true.

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(ACT,TIME) & lastAction(move,TIME) & lastActionParams(_,TIME) & not .intend(explore) & ACT \== success & attached(_,_,_)
	<-  !updatePosition(TIME);!randomRotation;.//.

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(ACT,TIME) & lastAction(move,TIME) & lastActionParams(D,TIME) & not .intend(explore) & ACT \== success
	<-  !updatePosition(TIME).

+!randomRotation <- .random(R);
	if (R < 0.5) { // where vl(X) is a belief
    	!performAction(rotate(cw));
    }
	else { // where vl(X) is a belief
    	!performAction(rotate(ccw));
    }.

-!randomRotation <- !randomRotation.
