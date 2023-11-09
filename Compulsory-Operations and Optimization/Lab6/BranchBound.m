% Operational Research
% @author ������ 20123101
% Jan 5, 2023
%Aeq   ��ʽԼ��ϵ������
%Beq   ��ʽԼ������������
%vlb   ��������½磻      
%vub   ��������Ͻ磻
%optXin   ÿ�ε���������x   
%optF  ÿ�ε������ŵ�fֵ  
%iter  ��������
function [xstar, fxstar] = BranchBound(A, b, c, Aeq, Beq, vlb, vub, optXin, optF, iter)
    global optX optVal optFlag;
    iter = iter + 1;
    optX = optXin; optVal = optF;
    
    [x, fit, status] = linprog(c, A, b, Aeq, Beq, vlb, vub, []);
   
    if status ~= 1%û���ҵ����Ž�
        xstar = x;
        fxstar = fit;
        flagOut = status;
        return;
    end
    
    if max(abs(round(x) - x)) >= 1e-3%�ҵ��ĺ������Ž��Բ���������
        if fit > optVal  
            xstar = x;
            fxstar = fit;
            flagOut = -100;
            return;
        end
        
    else%��ʱ��õĺ�����Ϊ������
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
