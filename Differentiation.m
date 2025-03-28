Fx = "x.^4 - 6*x.^2 + x + 2";
Fx_x_values = linspace(-2, 2, 100); 
Fx_h_values = [0.5, 0.05, 0.005];

Gx = 'sin(x).^3 - cos(x).^2';
Gx_x_values = linspace(0,pi,100);
Gx_h_values = [0.5,0.05,0.005];

Hx = 'exp(-x.^2)';
Hx_x_values = linspace(-3,3,100);
Hx_h_values = [0.5,0.05,0.005];

function r = Forward_difference(func, x_val, step_size)
    % func : the function to be diffrentiated
    % x_val : array for x values
    % step_size : array for h values
    func_handle = str2func(['@(x)' char(func)]); % Convert string to function handle
    fx_plus_h = func_handle(x_val + step_size); % calculate f(x+h)
    fx = func_handle(x_val); % calculate f(x)
    r = (fx_plus_h - fx) ./ step_size; % evaluate the forward difference and return the value
end

function r = Backward_difference(func,x_val, step_size)
    % func : the function to be diffrentiated
    % x_val : array for x values
    % step_size : array for h values
    func_handle = str2func(['@(x)' char(func)]); % Convert string to function handle
    fx_minus_h = func_handle(x_val - step_size); % calculate f(x-h)
    fx = func_handle(x_val); % calculate f(x)
    r = (fx - fx_minus_h) ./ step_size; % evaluate the backward difference and return the value
end

function r = Central_difference(func, x_val , step_size)
    % func : the function to be diffrentiated
    % x_val : array for x values
    % step_size : array for h values
    func_handle = str2func(['@(x)' char(func)]); % Convert string to function handle
    fx_plus_h = func_handle(x_val + step_size); % calculate f(x+h)
    fx_minus_h = func_handle(x_val - step_size); % calculate f(x-h)
    r = (fx_plus_h - fx_minus_h) ./ (2.*step_size); % evaluate the central difference and return the value
end



function Diff(func, x_values, h_values)
    num_h = length(h_values);
    syms x
    f_prime = diff(str2sym(func));
    actual = double(subs(f_prime, x, x_values));
    
    % Initialize storage
    forward_results = zeros(length(x_values), num_h);
    backward_results = zeros(length(x_values), num_h);
    central_results = zeros(length(x_values), num_h);

    % Loop through step sizes
    for i = 1:num_h
        h = h_values(i);
        forward_results(:, i) = arrayfun(    @(xi) Forward_difference(func, xi, h), x_values     );
        backward_results(:, i) = arrayfun(    @(xi) Backward_difference(func, xi, h), x_values    );
        central_results(:, i) = arrayfun(    @(xi) Central_difference(func, xi, h), x_values     );
        
        subplot(1,num_h,i); 
        hold on;
        plot(x_values, forward_results(: ,i), 'r-', 'DisplayName', 'Forward');
        plot(x_values, backward_results(:,i), 'g--', 'DisplayName', 'Backward'); 
        plot(x_values, central_results(:,i), 'm-', 'DisplayName','Central');
        plot(x_values,actual, 'k-', 'DisplayName','Actual Diff'); 
        title(sprintf('h = %.3f', h)); 
        xlabel('x'); 
        ylabel('Derivative'); 
        legend show;
        grid on;
        hold off;
    end

    fprintf("For the Function :%s \n", func);
    for i = 1: num_h
        the_value_of_x = x_values(1); 
        the_value_of_x_at_forward = forward_results(1,i); 
        the_value_of_x_at_backward = backward_results(1,i); 
        the_value_of_x_at_central = central_results(1,i); 
        the_value_of_x_at_actual = actual(1);
        
        fprintf("at x = %d and h = %.4f\nThe Forward Difference = %.6f\nThe Backward Difference = %.6f\nThe Central Differeance = %.6f\nThe actual Value = %.6f\n\n" ...
            , the_value_of_x, h_values(i), the_value_of_x_at_forward,the_value_of_x_at_backward,the_value_of_x_at_central,the_value_of_x_at_actual);
        

        
    end


    sgtitle(sprintf('Numerical Differentiation for Function %s', func), 'Interpreter', 'none');
end   



Diff(Gx, Gx_x_values,Gx_h_values); 