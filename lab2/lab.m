 
%create simulation 
r = sim150.instance()
r.ready();

%adjust speed
%r.speed(60)

%% Part 6 of lab

% 1)
Jdeg = [0 90 0 0 0];
r.dhmadeg(Jdeg);

% 2)

Jdeg = [0 90 0 0 90];
r.dhmadeg(Jdeg);
Jdeg = [0 90 0 0 -90];
r.dhmadeg(Jdeg);
Jdeg = [0 90 0 0 0];
r.dhmadeg(Jdeg);

% 3)
Jdeg = [-90 90 0 0 0];
r.dhmadeg(Jdeg);

% 4) 
Jdeg = [-90 90 -90 0 0];
r.dhmadeg(Jdeg);

%5)
Jdeg = [-90 45 -90 0 0];
r.dhmadeg(Jdeg);

%6)
Jdeg = [-90 45 -90 0 90];
r.dhmadeg(Jdeg);

%7)
r.close();

%8)
Jdeg = [-90 90 -90 0 90];
r.dhmadeg(Jdeg);

%9)
Jdeg = [90 90 -90 0 90];
r.dhmadeg(Jdeg);

%10)
Jdeg = [90 45 -90 0 90];
r.dhmadeg(Jdeg);

%11)
r.open()

%12)
r.ready();


% exit simulation
r.quit()