clear; clc; clf; close all

I = importdata('output.dat','\t');  % Read in data
for i=1:size(I)
    A{i} = str2num(I{i});
    N(i,1) = A{i}(1);
    x(i,1) = A{i}(2);
    y(i,1) = A{i}(3);
    z(i,1) = A{i}(4);
    t(i,1) = A{i}(5);
end
Nobj = max(N);
colors1 =  {'ro','b-','g-','c-','m-','r--','b--','g--','c--'};   % plotting colors
colors2 =  {'r-','b-','g-','c-','m-','r--','b--','g--','c--'};


% Plot y(x,z) graph:
figure(1); hold on; grid on;
for i=1:Nobj
    plot3(x(i:Nobj:end),y(i:Nobj:end),z(i:Nobj:end),colors1{i})
end
xlabel('X,  [AU]')
ylabel('Y,  [AU]')
zlabel('Z,  [AU]')
%legend('Sun','Jupiter')
%legend('Earth','Moon')
legend('Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune')


% Plot x(t) graph:
figure(2); hold on; grid on;
for i=1:Nobj
    plot(t(i:Nobj:end),x(i:Nobj:end),colors2{i})
end
xlabel('Time, [s]')
ylabel('X, [AU]')
%xlim([0 3e9])
%legend('Sun','Jupiter')
%legend('Earth','Moon')
legend('Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune')

