% Operational Research
% @author 李昀哲 20123101
% Dec 1, 2022
% Generate a mxn matrix where an eye is randomly assigned in it.
m = 3;
n = 8;
A = 10 * randn(m, n);
I = eye(m, m);
randIndex = randperm(size(A, 2));
A(:,randIndex(1:m))=I;
disp(A);

% Our expectation is to extract those columns which is an element of I. 
for i  = 1:size(A, 2)
    for j = 1:size(A,2)
            if isequal(i, j)
                continue;
            end
        for k = 1:size(A,2)
            if or (isequal(i, k), isequal(j, k))
                continue;
            end
            temp = A(:, [i j k]);
    
            % Judge if temp is equal I to determine whether exist eye.
            if (isequal(temp, I))
                 break;
            end
        end
        if (isequal(temp, I))
            break;
        end
    end
        if (isequal(temp, I))
            break;
        end
end

% Result Output
if (isequal(temp, I))
    disp("Has eye");
    fprintf("i = %d, j = %d, k = %d\n", i, j, k);
else
    disp("No eye!")
end


