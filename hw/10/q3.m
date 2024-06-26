function B = q3(w,vo,k,sig, accept)
            w = w';
            vo = vo';
            err1 = 100;
            err2 = 100;
            err3 = 100;


            while (err1 > accept && err2 > accept && err3 > accept)

                resid = vo - (k * sig) ./ ((w .^2 + sig^2) .^ .5);

                dk = (sig) ./ ((w .^2 + sig^2) .^ .5);

                dsig = (k * w .^2) ./ ((w .^2 + sig^2) .^ (3/2));

       


                J = [dk dsig];

                B = (J' * J ) \ (J' * resid);


                err1 = abs(B(1) / k) + abs(B(2) / sig);
                err2 = sqrt((abs(B(1) / k)^2 + abs(B(2) / sig)^2));
                err3 = sqrt((abs(B(1) / k)^2 + abs(B(2) / sig)^2)) + accept * abs(B(1) / k) + abs(B(2) / sig);
                

                
                k = k + B(1);
                sig = sig + B(2);



            end


            B(1) = k;
            B(2) = sig;

            fit = (k * sig) ./ ((w .^2 + sig^2) .^ .5);
            figure(1);
            hold on
            plot(w, vo, 'ob');
            plot(w, fit, '-r');
            hold off




        end



        

