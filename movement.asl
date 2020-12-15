+!goToPosition(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!goToPosition(X,Y).

+!goToPosition(X,Y) : step(_,TIME) & position(X,Y,TIME) <- true.//arrived
+!goToPosition(X,Y) : step(_,TIME) & position(_,Y,TIME) <- !moveHorizontal(X,Y);!goToPosition(X,Y).
+!goToPosition(X,Y) : step(_,TIME) & position(_,_,TIME) <- !moveVertical(X,Y);!goToPosition(X,Y).

+!moveVertical(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(_,Y,TIME) <- true.

+!moveVertical(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM > Y & not blocked(n) <- !performAction(move(n));!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM > Y & blocked(n) <- !dodge(X,Y,e);!moveVertical(X,Y).

+!moveVertical(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM < Y & not blocked(s) <- !performAction(move(s));!moveVertical(X,Y).
+!moveVertical(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM < Y & blocked(s) <- !dodge(X,Y,w);!moveVertical(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",10,Arg);!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(X,_,TIME) <- !goToPosition(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM > X & not blocked(w) <- !performAction(move(w));!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM > X & blocked(w) <- !dodge(X,Y,s);!moveHorizontal(X,Y).

+!moveHorizontal(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM < X & not blocked(e) <- !performAction(move(e));!moveHorizontal(X,Y).
+!moveHorizontal(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM < X & blocked(e) <- !dodge(X,Y,n);!moveHorizontal(X,Y).

+!dodge(X,Y,Direction) : step(_,TIME) & not position(A,B,TIME) <- .wait("+position(_,_,TIME)",10,Arg); !dodge(X,Y,Direction).
+!dodge(X,Y,_) : step(_,TIME) & position(X,Y,TIME) <- true.
+!dodge(X,Y,s) : step(_,TIME) & position(A,B,TIME) & not blocked(s) <- !performAction(move(s)).
+!dodge(X,Y,n) : step(_,TIME) & position(A,B,TIME) & not blocked(n) <- !performAction(move(n)).
+!dodge(X,Y,w) : step(_,TIME) & position(A,B,TIME) & not blocked(w) <- !performAction(move(w)).
+!dodge(X,Y,e) : step(_,TIME) & position(A,B,TIME) & not blocked(e) <- !performAction(move(e)).

+!dodge(X,Y,s) : step(_,TIME) & position(A,B,TIME) & blocked(s) <- !dodge(X,Y,w);!dodge(X,Y,s).
+!dodge(X,Y,n) : step(_,TIME) & position(A,B,TIME) & blocked(n) <- !dodge(X,Y,e);!dodge(X,Y,n).
+!dodge(X,Y,w) : step(_,TIME) & position(A,B,TIME) & blocked(w) <- !dodge(X,Y,n);!dodge(X,Y,w).
+!dodge(X,Y,e) : step(_,TIME) & position(A,B,TIME) & blocked(e) <- !dodge(X,Y,s);!dodge(X,Y,e).
