+!explore : .my_name(Me) & 
			available(Me) & 
			not busy(Me) & 
			thing(_,_,taskboard) & 
			goal(_,_) & 
			.count(mapper(_,_,_),Map) & Map > 3 &
			.count(achieving(_),Tk) & Tk < 4
<- .print("achieving");
	+achieving(Me);.broadcast(tell,achieving(Me))
	!achieve. 
			
+!explore : not moving(_)
<- 	.random(R);
	if (R < 0.25) { // where vl(X) is a belief
       +moving(n);
	}
	elif (R < 0.5) { // where vl(X) is a belief
       +moving(s);
    }
	elif (R < 0.75) { // where vl(X) is a belief
       +moving(e);
    }
	else{
		+moving(w);
	}
	!explore.
	
+!explore :  moving(D) 
<-	!randomChange;
	!checkBlocked(0);
	?moving(ND);
	!performAction(move(ND));
	!explore.

+!randomChange
<-	if (R < 0.005) { // where vl(X) is a belief
       -moving(_);+moving(n);
    }
	elif (R < 0.01) { // where vl(X) is a belief
       -moving(_);+moving(e);
    }
	elif (R < 0.015) { // where vl(X) is a belief
       -moving(_);+moving(s);
    }
	elif (R < 0.02) { // where vl(X) is a belief
       -moving(_);+moving(w);
    }.

+!checkBlocked(4) <- !performAction(skip);!checkBlocked(0).
+!checkBlocked(I)
<-	?moving(D);
	if (D==n){
		if(blocked(0,-1,_)){
			-moving(_);+moving(e);
			!checkBlocked(I+1);
		}
	}
	elif (D==s){
		if(blocked(0,1,_)){
			-moving(_);+moving(w);
			!checkBlocked(I+1);
		}
	}
	elif (D==e){
		if(blocked(1,0,_)){
			-moving(_);+moving(s);
			!checkBlocked(I+1);
		}
	}
	elif (D==w){
		if(blocked(-1,0,_)){
			-moving(_);+moving(n);
			!checkBlocked(I+1);
		}
	}.
