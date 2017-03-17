function I = vec2mat(v)

size = sqrt(length(v));
l = 1;
I = zeros(size);

for i = 1:size
    for j = 1:size
      I(i,j) = v(l);
      l = l+1;
    end
end

end