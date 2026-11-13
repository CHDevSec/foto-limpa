# lab/

Demonstração auto-contida. Não usa nenhuma foto de terceiro: o `demo.sh` **gera** a própria
imagem de treino, planta um GPS fake e mostra o vazamento.

```bash
./demo.sh
```

Faz, em ordem:
1. gera `lab-foto.jpg` (imagem de treino nossa);
2. planta `Make/Model/DateTime` e a coordenada **GPS** fake nos metadados EXIF;
3. mostra o que o `exiftool` revela (modelo, data e a coordenada que cai no mapa);
4. gera `lab-foto-limpa.jpg` com `exiftool -all=` e prova que o GPS sumiu (imagem intacta).

Dependências: `exiftool` e `imagemagick` (instalação no [README raiz](../README.md)).

As imagens geradas (`lab-foto*.jpg`) são ignoradas pelo git — rode o script pra recriá-las.

> Uso só na foto de treino ou nas **suas próprias** fotos. Ver [../ETICA.md](../ETICA.md).
