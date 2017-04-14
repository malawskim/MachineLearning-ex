v=rand(7,1);
w=rand(7,1);
z = 0;
for i = 1:7
  z = z + v(i) * w(i);
end

disp(z)
disp(sum(v.*w))
disp(w'*v)
%disp(v*w)
%disp(w*v)