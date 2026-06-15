function img_comp = jpeg_compression(img_path, F, d)
    
    if nargin < 3
        % Selezione interattiva
        [file, path] = uigetfile('*.jpg', 'Seleziona un''immagine .jpg');
        if isequal(file,0)
            disp('Nessun file selezionato. Operazione annullata.');
            return;
        end
        img_path = fullfile(path, file);
        F = input('Inserisci l''ampiezza dei macro-blocchi F: ');
        d = input(sprintf('Inserisci la soglia d (tra 0 e %d): ', 2*F - 2));
    end

    % Lettura immagine
    img = imread(img_path);
    if size(img, 3) == 3
        img = rgb2gray(img); % Converte in toni di grigio se è a colori
    end
    img = double(img);
    [R, C] = size(img);

    % Scarto degli avanzi (dimensioni compatibili con F)
    R_new = floor(R / F) * F;
    C_new = floor(C / F) * F;
    img = img(1:R_new, 1:C_new);

    % Inizializzazione immagine compressa
    img_comp = zeros(R_new, C_new);

    % Creazione della maschera per azzerare le frequenze
    mask = zeros(F, F);
    for r = 1:F
        for c = 1:F
            if ((r-1) + (c-1)) < d
                mask(r, c) = 1; % Mantengo le frequenze sotto la soglia d
            end
        end
    end

    % Suddivisione in blocchi e trasformazione
    for i = 1:F:R_new
        for j = 1:F:C_new
            % Estrazione blocco
            block = img(i:i+F-1, j:j+F-1);
            
            % DCT2
            c_block = dct2(block);
            
            % Eliminazione frequenze
            c_block_mod = c_block .* mask;
            
            % IDCT2
            ff = idct2(c_block_mod);
            
            % Arrotondamento e vincoli (0 - 255)
            ff = round(ff);
            ff(ff < 0) = 0;
            ff(ff > 255) = 255;
            
            % Ricomposizione
            img_comp(i:i+F-1, j:j+F-1) = ff;
        end
    end

    % Casting a uint8 per la corretta visualizzazione delle immagini
    img_comp = uint8(img_comp);
    img_orig = uint8(img);

    % Visualizzazione affiancata
    figure('Name', sprintf('Compressione: %s (F=%d, d=%d)', img_path, F, d), 'Color', 'w');
    subplot(1,2,1); 
    imshow(img_orig); 
    title('Immagine Originale');
    
    subplot(1,2,2); 
    imshow(img_comp); 
    title(sprintf('Compressa (F = %d, d = %d)', F, d));
end
