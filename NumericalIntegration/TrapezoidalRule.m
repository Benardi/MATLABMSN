syms x a b;
tr = TrapezoidalIntegration((1 + x^2)^(-1/2)); 
f(x) = (1 + x^2)^(-1/2);
tries = 5000; 
a = 0;
b = 4;

h = b - a;
t = f(b);
T = f(a);
result = vpa((h/2) * (t + T));
disp(result);
disp(tr.simpleTrapezoidalRule(a,b));

interval = [];
interval = [a interval];
points = 10;
for i=1:(points-2)
    intSect = (b * i)/(points-1);
    interval = [interval intSect];
end
interval = [interval b];
disp(interval);