disp('aaaaaaa')
v = zeros(10, 1);
A = rand(10,10);
x=rand(10,1);
for i = 1:10
  for j = 1:10
    v(i) = v(i) + A(i, j) * x(j);
  end
end
disp(v)
disp(A*x)
disp(x'*A)
disp(sum(A*x))