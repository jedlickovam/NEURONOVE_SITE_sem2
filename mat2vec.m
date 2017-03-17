function v = mat2vec(I)

v = I(1,:);
n = length(I);

for j = 2:n
    v = [v , I(j,:)];
end

end