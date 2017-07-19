syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x y z invalid;
lb = ConvergenceTester([(2*x1 + x2 -0.2*x3 +0.2*x4- 0.4) (0.6*x1 + 3*x2 -0.6*x3 -0.3*x4 +7.8) (-0.1*x1 -0.2*x2 + 1*x3 +0.2*x4 -1) (0.4*x1 +1.2*x2 + 0.8*x3 +4*x4 +10)]);
disp(lb.SassenfeldCriteria());

