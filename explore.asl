+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(move,_) & lastActionParams([n],_)
	<- 	-position(me,X,Y,_);
		+position(me,X,Y-1,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(move,_) & lastActionParams([s],_)
	<- 	-position(me,X,Y,_);
		+position(me,X,Y+1,TIME).
		
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(move,_) & lastActionParams([e],_)
	<- 	-position(me,X,Y,_);
		+position(me,X+1,Y,TIME).
		
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(success,_) & lastAction(move,_) & lastActionParams([w],_)
	<- 	-position(me,X,Y,_);
		+position(me,X-1,Y,TIME).
		
	///////////////////////////
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,_) & lastAction(move,_) & lastActionParams([n],_) & .intend(explore)
	<-  -moving(n);+moving(e);-position(me,X,Y,_);+position(me,X,Y,TIME).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,_) & lastAction(move,_) & lastActionParams([e],_) & .intend(explore)
	<-  -moving(e);+moving(s);-position(me,X,Y,_);+position(me,X,Y,TIME).

+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,_) & lastAction(move,_) & lastActionParams([s],_) & .intend(explore)
	<-  -moving(s);+moving(w);-position(me,X,Y,_);+position(me,X,Y,TIME).
	
+!handleLastActionResult(ACTION,TIME)
    :   lastActionResult(failed_path,_) & lastAction(move,_) & lastActionParams([w],_) & .intend(explore)
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
