function[x] = gauss_elim(A,b)
    % Merge two matrix as M.
    M = [A b];
    disp (M);

    % 第一列
    cof = M(2,1) / M(1,1);
    for i = 1:size(M, 2)
        M(2,i) = M(2,i)-cof*M(1,i);
    end
    cof = M(3,1) / M(1,1);
    for i = 1:size(M, 2)
        M(3,i) = M(3,i)-cof*M(1,i);
    end
    disp(M);
    % 第二列
    cof = M(3,2) / M(1,2);
    for i = 2:size(M, 2)
        M(3,i) = M(3,i)-cof*M(1,i);
    end
    disp(M);
    x3 = M(3,4)/M(3,3);
    disp(M(3,4)/M(3,3));
    x2 = (5 - 10 * M(3,4)/M(3,3)) / 5;
    disp((5 - 10 * M(3,4)/M(3,3)) / 5);
    disp(1 - 3*x3 - 2*x2);
end