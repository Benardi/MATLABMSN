syms x a b;

tr = TrapezoidalIntegration((1 + x^2)^(-1/2)); 
f = (1 + x^2)^(-1/2);
tries = 5000; 
a = 0;
b = 4;

interval = tr.createsSeriesOfIntervals(a,b,9);
disp(tr.simpleTrapezoidalRule(a,b));
disp(tr.compositeTrapezoidalRule(a,b,2));
disp(tr.compositeTrapezoidalRule(a,b,3));
disp(tr.compositeTrapezoidalRule(a,b,9));
disp(tr.estimatesErrrorAlt(a,b,9));
disp(tr.estimatesErrror(8, 0.5, a , b));