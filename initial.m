function initial
[chi,N,L,gi,btR,btI] = parinput;
Ng = numel(gi);
NbR = numel(btR);
NbI = numel(btI);
for k = 1:Ng
    tic
    Z = zeros(NbI,NbR);
    g = gi(k);
    for i = 1:NbI
        for j = 1:NbR
            x = btR(j);
            y = btI(i);
            b = x + y*pi*1i;
            [Z(i,j),~] = coarsegrain(b,chi,N,L,g);
            % fprintf('Z(%.4g,%.4g) = %.12g + %.12gi\n',x,y,real(Z(j,i)),imag(Z(j,i)))
            save('Z.mat',"Z")
        end
    end
    load('Z.mat');  % Assuming 'Z.mat' contains variables A, B, C, etc.
    Zfilename = ['Z_',num2str(L*2),'sites','_g',sprintf('%.1f', g),'_n',num2str(log2(N)),'_D',num2str(chi),'.mat'];
    save(Zfilename,'-v7.3');
    toc
    disp(['g = ',sprintf('%.1f', g),', 运行时间: ',num2str(toc)]);
    % movefile Z.mat Zfilename
    [X,Y] = meshgrid(btR,btI);
    figure
    contour(X, Y, real(Z), [0 0],'r')
    hold on
    contour(X, Y, imag(Z), [0 0],'b')
    title({[num2str(L*2),' sites',', g = ',num2str(g)]; ...
        ['evolve step N=',num2str(N),', Dbond=',num2str(chi)]})
    legend("Z_r","Z_i")
    xlabel('\beta_r')
    ylabel('\beta_i (\pi)')
    filename = [num2str(L*2),'sites','_g',sprintf('%.1f', g),'_n',num2str(log2(N)),'_D',num2str(chi),'.fig'];
    savefig(filename)
    % Set the desired resolution (dpi)
    resolution = 600;  % Adjust as needed
    filename = [num2str(L*2),'sites','_g',sprintf('%.1f', g),'_n',num2str(log2(N)),'_D',num2str(chi),'.png'] ;
    print(gcf, filename, '-dpng', ['-r' num2str(resolution)]);
end