% Operational Research
% @author 李昀哲 20123101
% Jan 5, 2023
%Aeq   等式约束系数矩阵；
%Beq   等式约束常数向量；
%vlb   定义域的下界；      
%vub   定义域的上界；
%optXin   每次迭代的最优x   
%optF  每次迭代最优的f值  
%iter  迭代次数
function [xstar, fxstar] = BranchBound(A, b, c, Aeq, Beq, vlb, vub, optXin, optF, iter)
    global optX optVal optFlag;
    iter = iter + 1;
    optX = optXin; optVal = optF;
    
    [x, fit, status] = linprog(c, A, b, Aeq, Beq, vlb, vub, []);
   
    if status ~= 1%没有找到最优解
        xstar = x;
        fxstar = fit;
        flagOut = status;
        return;
    end
    
    if max(abs(round(x) - x)) >= 1e-3%找到的函数最优解仍不是整数解
        if fit > optVal  
            xstar = x;
            fxstar = fit;
            flagOut = -100;
            return;
        end
        
    else%此时解得的函数解为整数解
        if fit > optVal  
            xstar = x;
            fxstar = fit;
            flagOut = -101;
            return;
        else   
            optVal = fit;
            optX = x;
            optFlag = status;
            xstar = x;
            fxstar = fit;
            flagOut = status;
            return;
        end
    end
    midX = abs(round(x) - x);
    notIntV = find(midX > 1e-3);
    pXidx = notIntV(1);
    tempVlb = vlb;
    tempVub = vub;
    if vub(pXidx) >= fix(x(pXidx)) + 1
        tempVlb(pXidx) = fix(x(pXidx)) + 1;
        [~, ~] = BranchBound(A, b, c, Aeq, Beq, tempVlb, vub, optX, optVal, iter + 1);
    end
    
    if vlb(pXidx) <= fix(x(pXidx))
        tempVub(pXidx) = fix(x(pXidx));
        [~, ~] = BranchBound(A, b, c, Aeq, Beq, vlb, tempVub, optX, optVal, iter + 1);
    end
    xstar = optX;
    fxstar = optVal;
    flagOut = optFlag;
end
