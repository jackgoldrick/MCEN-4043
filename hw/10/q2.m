
function [wn, w_3dB] = q2(k, a, b, c, d, stepd, wMax)

    W = 1000:stepd:wMax;
    log10W = log10(W);


    dB_MagG2 = 20 .* log10( abs(k * 1) ./ sqrt(( 441890107.5992 - (W .^2)) .^ 2 + (( 2*4739.8784085619 .* W) .^ 2)) );
    deg_phaseG2 = (- 180 / pi) * atan((2*4739.8784085619) ./ (441890107.5992 - W .^2));
    A2 = deg_phaseG2;
    A2(A2<=0) = - inf;
    [~,id2] = max(A2);
    deg_phaseG2(id2:length(W)) = deg_phaseG2(id2:length(W)) - 2* 90 ;



    dB_MagG = 20 .* log10( abs(k) ./ sqrt(  ( (d - b .* (W .^2))) .^ 2 + ((c - a .* ( W .^ 2) ) .* W) .^ 2) );
    deg_phaseG = (- 180 / pi) * atan((( c .* W  - a .* (W .^ 3)) ./ (d - b .* (W .^2)) ));
    A = deg_phaseG;
    A(A<=0) = - inf;
    [~,id] = max(A);
    deg_phaseG(id:length(W)) = deg_phaseG(id:length(W)) - 2* 90 ;

    [~,wn] = max(dB_MagG);

    wn = W(wn);
    B  =  abs(- 123 - dB_MagG);
    [~,i_123] = min(B);

    w_3dB = W(i_123);
    tf1 = tf(k,[a b c d]);
    tf2 = tf(k,[1 2*4739.8784085619 441890107.5992]);
    
    
    
    
    
    fig1 = figure(1);
    sgtitle('Part (b.)');
    subplot(2,1,1)
        hold on
            title('Magnitude');
            ylabel('dB');
            %ylim([-250 -100]);
            xlabel('$\log_{10}(\omega)$', 'Interpreter','latex');
            plot(log10W, dB_MagG,'-b',LineWidth=2);
            plot(log10W, dB_MagG2,'-g',LineWidth=2);
        hold off
    subplot(2,1,2)
    hold on
    title('Phase');
    ylabel('Degrees');
    xlabel('$\log_{10}(\omega)$', 'Interpreter','latex');
    %ylim([-270 0]);
    plot(log10W, deg_phaseG,'-r',LineWidth=2);
    plot(log10W, deg_phaseG2,'-g',LineWidth=2);
    
    hold off
    
    figure(2);
    bode(tf2);
    figure(3);
    step(tf1, tf2)

   
    
    



end