
[🇬🇧 English](README.md) | [🇫🇷 Français](README.fr.md)

# Configuration Neovim

Mes notes personnelles et ma configuration de Neovim.

Ce dépôt commence par quelques commandes de base et des pense-bêtes pour m'accompagner dans mon apprentissage.

Au fur et à mesure que je découvre et personnalise Neovim, j'y ajouterai mes propres paramètres, raccourcis clavier et configurations.

N'hésitez pas à parcourir le dépôt, à réutiliser ce qui vous intéresse ou simplement à vous en inspirer. Si cela peut vous être utile, tant mieux !

## Police

J'ai choisi la police [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads), que je trouve particulièrement agréable à lire, avec un design épuré.

**Pour les utilisateurs de macOS :** petite précision, télécharger la police ne suffit pas. Au départ, je l'avais installée dans `~/.local/share/fonts/`, mais le Terminal de macOS ne la reconnaissait pas.

Pour que tout fonctionne correctement, j'ai dû copier les fichiers de police dans le dossier des polices utilisateur de macOS :

```bash
~/Library/Fonts/
```

Après cela, j'ai redémarré le Terminal et sélectionné JetBrainsMono Nerd Font dans :

Terminal → Réglages → Profils → Texte → Police

Cette manipulation a également résolu les problèmes d'icônes manquantes et de petits carrés avec des points d'interrogation dans le tableau de bord de Neovim.

Une petite chose à garder en tête si vous configurez Neovim sur Mac !

## Norminette pour l'école 42

À l'école 42, nous utilisons Norminette pour vérifier que notre code respecte la norme de programmation imposée.

Cette configuration lance automatiquement [norminette](https://github.com/42School/norminette) grâce à [nvim-lint](https://github.com/mfussenegger/nvim-lint) et formate les fichiers C avec [c_formatter_42](https://github.com/dawnbeen/c_formatter_42), via [conform.nvim](https://github.com/stevearc/conform.nvim).

Les deux outils, [norminette](https://github.com/42School/norminette) et [c_formatter_42](https://github.com/dawnbeen/c_formatter_42), sont configurés dans un [registre Mason personnalisé](https://github.com/mason-org/mason.nvim#registries).

**Configuration en cours de développement.**
