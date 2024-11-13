# Extra instructions for the Nano editor
### Orginaly from: https://giacomo.coletto.io/blog/arch-conf/#edit-files-with-nano

1. Need to install the nano highlight package

```bash
yay -S nano-syntax-highlighting
```

2. Fix a highlight issue with the nano editor

```bash
sed -i "/usr/share/nano-syntax-highlighting/nanorc.nanorc" \
    -e 's|^icolor brightnormal " brightnormal"|icolor normal " normal"|'
```

3. Copy the nanorc file to /etc/nanorc

4. Copy the .nanorc file to /root/.nanorc
