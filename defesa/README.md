# Defesa: por que a foto entrega tua localização e como cortar isso

## O que é EXIF
Quando teu celular tira uma foto, ele grava, **dentro do arquivo .jpg**, um bloco de
metadados chamado **EXIF**: modelo do aparelho, data, hora, orientação, configurações da
lente e, se a localização da câmera estiver ligada, a **latitude e longitude exatas** de
onde a foto foi tirada. A imagem que tu vê não mostra nada disso. Vai tudo escondido.

Um comando lê em segundos:
```bash
exiftool -gps:all -make -model -datetimeoriginal foto.jpg
```

## Onde mora o risco
A sacada que confunde todo mundo: **as plataformas tratam isso de formas diferentes.**

| Canal | O que acontece com o GPS |
|---|---|
| Postar no Instagram / Facebook | **Removido** no upload (eles re-processam a imagem) |
| WhatsApp como **Foto** | **Removido** (recomprime) |
| WhatsApp como **Documento** | **Preservado** (manda o arquivo original) |
| E-mail, Google Drive, AirDrop, Telegram "arquivo" | **Preservado** |
| Anúncio de venda / marketplace com foto original | Depende, muitas vezes **preservado** |

Ou seja: não adianta confiar que "a internet limpa". O momento perigoso é mandar a
**original** por um canal que preserva. E foto de perfil antiga, print, foto vendendo um
móvel com o endereço no fundo... tudo soma.

## Como cortar (resumo)
1. **Desliga a localização da câmera** (para de criar o problema).
2. **Remove o EXIF antes de mandar a original.**
3. **Escolhe o canal** (Foto, não Documento).
4. **Confere** nas propriedades.

Passo a passo clicável por aparelho no [checklist.md](checklist.md).

## Para quem é dev / faz app
Se teu app recebe upload de foto de usuário, **remove o EXIF no servidor** antes de
armazenar ou reexibir (strip de metadados no pipeline de upload). Não repasse o arquivo
original pra outros usuários. Tratar metadado de imagem como dado pessoal (LGPD) é o certo.
