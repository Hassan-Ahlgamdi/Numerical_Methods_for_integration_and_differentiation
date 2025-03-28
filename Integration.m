Fx = @(x) x.^4 - 6*x.^2 + x + 2 ;
Fx_lower_limit = 0;
Fx_upper_limit = 1;

Gx = @(x) sin(x).^3 - cos(x).^2;
Gx_lower_limit = 0; 
Gx_upper_limit = pi;

Hx = @(x) exp(-x.^2);
Hx_lower_limit = -1; 
Hx_upper_limit =1;


function I = trapozodial(F,lower_limit, upper_limit, n)
    % F : is function to be integrated
    % n : number of intervals
    h = (upper_limit - lower_limit) / n;
    s = 0.5*(F(lower_limit) + F(upper_limit));
    for i = 1:n - 1
        s = s + (F(lower_limit + i*h));
    end

    T_I = s * h;  
    I = T_I; 
    return;

end

function I = simpson(F,lower_limit, upper_limit,n)
    % F : is function to be integrated
    % n : number of intervals "must be even"
    % finding the width
    h = (upper_limit - lower_limit) / n;
    % calculating the first and last terms
    s = F(lower_limit) + F(upper_limit); 

    % loop over the odd values
    for i=1:2:n-1
        s = s + 4*F(lower_limit + i*h);
    end
    % loop over the even values
    for i = 2: 2: n-1
        s = s + 2*F(lower_limit + i*h);
    end
    % calculate the simpson integration
    S_I = h/3 * s; 
    I = S_I; 
    return;
end


function I = monte_carlo(F,lower_limit,upper_limit, N)
    % F : is function to be integrated
    % N : number of points
    if nargin < 4
        N = 10000;
    end
    M = 1.4 * max(F(linspace(lower_limit,upper_limit)));
    for i = 1:N
        % generate random points
        x_val = rand(1) * (upper_limit - lower_limit) + lower_limit;
        y_val = rand(1) * M;
        % compare random against the curve 
        fx = F(x_val);
        if y_val < fx
            under(i,1) = x_val;
            under(i,2) = y_val;
        else 
            above(i,1) = x_val; 
            above(i,2) = y_val;
        end
    end
    % remove the zeros from the array
    under2(:,1) = nonzeros(under(:,1)); 
    under2(:,2) = nonzeros(under(:,2)); 
    above2(:,1) = nonzeros(above(:,1));
    above2(:,2) = nonzeros(above(:,2));
    % calculate the Monte carol integration
    M_I = length(under2) / N * (M*(upper_limit - lower_limit)); 

    % plot the points
    F_str = func2str(F); 
    F_str = F_str(5:end);
    plot(above2(:,1), above2(:,2), 'ro', 'MarkerFaceColor','r')
    hold on
    plot(under2(:,1), under2(:,2), 'bo', 'MarkerFaceColor','b')
    title("For the Function: "+F_str), xlabel('X values'), ylabel('Y values')
    legend('above', 'under')

    
    
    I = M_I;
    return;
end

function Integ(F,lower_limit,upper_limit,Number_of_partions)
    Tr_I = trapozodial(F,lower_limit,upper_limit,Number_of_partions); 
    Sm_I = simpson(F,lower_limit, upper_limit, Number_of_partions); 
    MC_I = monte_carlo(F,lower_limit,upper_limit);

    F_str = char(F); 

    I = integral(F,lower_limit, upper_limit);
    fprintf("For the Function: %s\n", F_str(5:end));
    fprintf('The analytical solution is: %.6f \n', I);
    fprintf("The Trapozodial solution is: %.6f \n", Tr_I);
    fprintf("The Error using Trapozodial is: %.6f\n", abs(Tr_I - I));
    fprintf("The Simpson solution is: %.6f \n", Sm_I);  
    fprintf("The Error using Simpson is: %.6f\n", abs(Sm_I - I));
    fprintf("The Monte Carlo solution is: %.6f\n", MC_I);
    fprintf("The Error using Monte Carlo is: %.6f\n", abs(MC_I - I));
end


%Integ(Fx,Fx_lower_limit,Fx_upper_limit,16);
%Integ(Gx,Gx_lower_limit,Gx_upper_limit,16);
Integ(Hx,Hx_lower_limit,Hx_upper_limit,16);