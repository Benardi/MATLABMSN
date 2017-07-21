syms x
points = [1 2;2 5;6 3; 10 8];

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

disp(y);
subs(y, x, 10);
