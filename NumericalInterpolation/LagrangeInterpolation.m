syms x
points = [1 101.25; 2 106; 3 104.01; 5 105.71; 6 106.09; 7 120.9];

terms = [];


for j=1:length(points)
    y = 1;
    for i=1:length(points)
        row = points(i,:);
        if(i ~= j)
            y = y*((x - row(1)));
        end
    end
    terms = [terms; y];
end

denominators = [];
for j=1:length(points)
    y = 1;
    for i=1:length(points)
        row = points(i,:);
        fxn = points(j,:);
        fxn = fxn(1);
        if(i ~= j)
            y = y*((fxn - row(1)));
        end
    end
    denominators = [denominators; y];
end

y = 0;
for g=1:length(points)
        fxn = points(g,:);
        fxn = fxn(2);
    y = y + fxn *(terms(g)/denominators(g));
end

disp(simplify(y)); % Simplified Lagrange Interpolation

results = [vpa(subs(y, x, 1)) vpa(subs(y, x, 2)) vpa(subs(y, x, 3))];
results = [results vpa(subs(y, x, 5)) vpa(subs(y, x, 6)) vpa(subs(y, x, 7))];
disp(results); % Must contain exactly all f(x);
disp(vpa(subs(y, x, 4))); % Interpolation at x =4
disp(vpa(subs(y, x, 8))); % Extrapolation at x =8
