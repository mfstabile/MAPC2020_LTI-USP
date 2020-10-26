+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,TIME) & lastAction(move,TIME) & lastActionParams([n],TIME)
	<- 	-position(me,X,Y,_);
		+position(me,X,Y-1,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,TIME) & lastAction(move,TIME) & lastActionParams([s],TIME)
	<- 	-position(me,X,Y,_);
		+position(me,X,Y+1,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,TIME) & lastAction(move,TIME) & lastActionParams([e],TIME)
	<- 	-position(me,X,Y,_);
		+position(me,X+1,Y,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,TIME) & lastAction(move,TIME) & lastActionParams([w],TIME)
	<- 	-position(me,X,Y,_);
		+position(me,X-1,Y,TIME).

	///////////////////////////
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,TIME) & lastAction(move,TIME) & lastActionParams([n],TIME) & .intend(explore)
	<-  -moving(n);+moving(e);-position(me,X,Y,_);+position(me,X,Y,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,TIME) & lastAction(move,TIME) & lastActionParams([e],TIME) & .intend(explore)
	<-  -moving(e);+moving(s);-position(me,X,Y,_);+position(me,X,Y,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,TIME) & lastAction(move,TIME) & lastActionParams([s],TIME) & .intend(explore)
	<-  -moving(s);+moving(w);-position(me,X,Y,_);+position(me,X,Y,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,TIME) & lastAction(move,TIME) & lastActionParams([w],TIME) & .intend(explore)
	<-  -moving(w);+moving(n);-position(me,X,Y,_);+position(me,X,Y,TIME).
///////////////////////////

+!explore : recognized(Mapps) & Mapps >= 4 & //conhece agentes
			.count(taken(_,_,_),Tk) & Tk <= Ags/3 & //poucas tasks
			task(_,_,_,_,_) & // pelo menos uma task
			thing(_,_,taskboard) &
			.my_name(M) & available(M) & // conhece os dispensers
			goal(_,_)
	<- !!achieve.

+!pula(0)<- true.
+!pula(N)<-!performAction(skip);!pula(N-1).

+!explore : not moving(_)
<- 	.random(R);
	if (R < 0.25) { // where vl(X) is a belief
       +moving(n);
	   !performAction(move(n));
    }
	elif (R < 0.5) { // where vl(X) is a belief
       +moving(s);
	   !performAction(move(s));
    }
	elif (R < 0.75) { // where vl(X) is a belief
       +moving(e);
	   !performAction(move(e));
    }else{
		+moving(w);
		!performAction(move(w));
	}
	!explore.

+!explore : moving(X)
<- 	!performAction(move(X));
	.random(R);
	if (R < 0.005) { // where vl(X) is a belief
       -moving(_);+moving(n);
    }
	elif (R < 0.01) { // where vl(X) is a belief
       -moving(_);+moving(e);
    }
	elif (R < 0.015) { // where vl(X) is a belief
       -moving(_);+moving(s);
    }
	!explore.

//-!explore <- !explore.
