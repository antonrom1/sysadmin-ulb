{pkgs, nixvim, ...}: {
  programs.neovim = {
    enable = true;
    # being able to use `vi` when something is wrong with neovim is useful
    viAlias = false;
    vimAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      vim-lastplace
      vim-airline # Provides an enhanced status and tabline. To customize: :help airline
      vim-airline-themes # Themes for vim-airline. Change theme with `let g:airline_theme='theme_name'`
      rainbow # Colors matching parentheses. No further configuration required.
      jellybeans-vim
      nerdtree # Filesystem explorer. Toggle with <Ctrl-n>, customize with `:help NERDTree`.
      fzf-vim # Fuzzy file search integration. Invoke with :Files, :GFiles, etc. :Rg for ripgrep.
      vim-devicons # Adds file icons to Vim plugins like NERDTree. Requires a patched font.
      coc-nvim # IntelliSense engine. Configure with `:help coc-nvim`.
      # CoC extensions for various languages and snippets. Add more as needed.
      coc-json
      coc-css
      coc-html
      coc-python
      coc-snippets
      coc-docker
      copilot-vim
      vim-polyglot # Language pack supporting a wide array of languages.
      vim-lightline-coc # Lightweight statusline/tabline, integrates with CoC. Customize in `g:lightline`.
      vim-gitgutter # Shows git diff in the gutter. Customize with `:help gitgutter`.
      ale # Asynchronous linting/fixing framework. Configure with `:help ale`.
      vim-commentary # Commenting plugin. Use `gcc` to comment out a line, `gc` to comment out the target of a motion.
      vim-be-good # Vim learning game. Use `:VimBeGood` to start.
    ];
    extraConfig = ''
      syntax on
      set backspace=indent,eol,start
      filetype plugin indent on
      set wrap
      set linebreak
      set breakindent
      set number! relativenumber!
      set cursorline
      set cursorcolumn
      set showmatch
      set matchtime=2
      set termguicolors
      set emoji
      colorscheme jellybeans
      let g:rainbow_active = 1
      set laststatus=2
      let g:airline_theme='bubblegum'
      " NERDTree configuration - Toggle NERDTree with <Ctrl-n>
      map <C-n> :NERDTreeToggle<CR>
      let NERDTreeShowHidden=1

      " FZF and Ripgrep integration for enhanced searching
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
      " Use Ripgrep with FZF for searching

      " CoC (Conquer of Completion) configuration
      " For detailed setup and shortcuts, visit: https://github.com/neoclide/coc.nvim
      " Example: To add more CoC extensions, modify the list below
      let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-html', 'coc-python', 'coc-snippets', 'coc-docker', 'coc-yaml']
      " " Use <Tab> to navigate the completion menu
      " inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

      " Use <CR> (Enter) to accept completion suggestion
      inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

      " Lightline configuration - Set colorscheme for Lightline
      let g:lightline = { 'colorscheme': 'wombat' }

      " Vim GitGutter - Enable git diff in gutter
      let g:gitgutter_enabled = 1

      " ALE Configuration - Enable fixing on save and explicit linter configuration
      let g:ale_fix_on_save = 1
      let g:ale_linters_explicit = 1
    '';
  };
}
