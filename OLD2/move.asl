+!goTo(X,Y) : step(_,TIME) & not position(me,_,_,TIME) <- .wait("+position(me,_,_,TIME)");!goTo(X,Y).

+!goTo(X,Y) : step(_,TIME) & position(me,X,Y,TIME) <- true.//está no lugar certo
+!goTo(X,Y) : step(_,TIME) & position(me,_,Y,TIME) <- !moveHorizontal(X,Y);!goTo(X,Y).
+!goTo(X,Y) : step(_,TIME) & position(me,_,_,TIME) <- !moveVertical(X,Y);!goTo(X,Y).

+!moveVertical(X,Y) : step(_,TIME) & not position(me,_,_,TIME) <- .wait("+position(me,_,_,TIME)");!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(me,_,Y,TIME) <- !goTo(X,Y).

+!moveVertical(X,Y) : step(_,TIME) & position(me,_,YM,TIME) & YM > Y & not blocked(0,-1,TIME) <- !performAction(move(n));!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(me,_,YM,TIME) & YM > Y & blocked(0,-1,TIME) <- !desvia(e);!moveVertical(X,Y).

+!moveVertical(X,Y) : step(_,TIME) & position(me,_,YM,TIME) & YM < Y & not blocked(0,1,TIME) <- !performAction(move(s));!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(me,_,YM,TIME) & YM < Y & blocked(0,1,TIME) <- !desvia(w);!moveVertical(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & not position(me,_,_,TIME) <- .wait("+position(me,_,_,TIME)");!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(me,X,_,TIME) <- !goTo(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & position(me,XM,_,TIME) & XM > X & not blocked(-1,0,TIME) <- !performAction(move(w));!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(me,XM,_,TIME) & XM > X & blocked(-1,0,TIME) <- !desvia(s);!moveHorizontal(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & position(me,XM,_,TIME) & XM < X & not blocked(1,0,TIME) <- !performAction(move(e));!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(me,XM,_,TIME) & XM < X & blocked(1,0,TIME) <- !desvia(n);!moveHorizontal(X,Y).

+!desvia(s) : position(me,A,B,_) & not blocked(0,1,_) <- !performAction(move(s)).
+!desvia(n) : position(me,A,B,_) & not blocked(0,-1,_) <- !performAction(move(n)).
+!desvia(w) : position(me,A,B,_) & not blocked(-1,0,_) <- !performAction(move(w)).
+!desvia(e) : position(me,A,B,_) & not blocked(1,0,_) <- !performAction(move(e)).

+!desvia(s) : position(me,A,B,_) & blocked(0,1,_) <- !desvia(w);!desvia(s).
+!desvia(n) : position(me,A,B,_) & blocked(0,-1,_) <- !desvia(e);!desvia(n).
+!desvia(w) : position(me,A,B,_) & blocked(-1,0,_) <- !desvia(n);!desvia(w).
+!desvia(e) : position(me,A,B,_) & blocked(1,0,_) <- !desvia(s);!desvia(e).

+!handleLastActionResult(ACTION,TIME,failed_path,move,_)
	<- 	-position(me,X,Y,_);
		+position(me,X,Y,TIME).	

+!handleLastActionResult(ACTION,TIME,success,move,[n])
	<- 	-position(me,X,Y,_);
		+position(me,X,Y-1,TIME).

+!handleLastActionResult(ACTION,TIME,success,move,[s])
	<- 	-position(me,X,Y,_);
		+position(me,X,Y+1,TIME).

+!handleLastActionResult(ACTION,TIME,success,move,[e])
	<- 	-position(me,X,Y,_);
		+position(me,X+1,Y,TIME).

+!handleLastActionResult(ACTION,TIME,success,move,[w])
	<- 	-position(me,X,Y,_);
		+position(me,X-1,Y,TIME).
