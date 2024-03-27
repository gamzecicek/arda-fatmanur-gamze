clear
clc
close all

global Mmat Props X Y Z K M N inputs;

save_msg = 1; test_msg = 'NeutralB'; case_msg = 'DiveMode';

x = 0; y = 0; z = 0;
phi = 0.0; theta = 0.0; psi = 0;

u = 0; v = 0; w = 0;
p = 0; q = 0; r = 0;

props = 0; delR = 0.; delS = 0.1;
Xprops = 2600.0;
inputs = [Xprops;delR;delS];

global var1;
var1 = 1;

[Mmat,Props,X,Y,Z,K,M,N] = AUV();

told = 0;
tend = 200;
tspan = told:1:tend;

init = [u,v,w,p,q,r,x,y,z,phi,theta,psi];

StateVec = [init];
TVec = told;

while (told <= tend)
    told
    if told > 60
        delS = 0;
        inputs = [Xprops,delR,delS];
    end
    tspan = told:0.1:told + 1;
    [t,states] = ode45('odefunc',tspan,init);
    u = states(end,1);
    v = states(end,2);
    w = states(end,3);
    p = states(end,4);
    q = states(end,5);
    r = states(end,6);
    x = states(end,7);
    y = states(end,8);
    z = states(end,9);
    phi = states(end,10);
    theta = states(end,11);
    psi = states(end,12);
    told = t(end);
    init = [u,v,w,p,q,r,x,y,z,phi,theta,psi];
    init(find(abs(init) < 1e-5)) = 0;
    StateVec = vertcat(StateVec,init);
    TVec = vertcat(TVec,told);
end

