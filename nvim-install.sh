- name: Bootstrap development environment
  hosts: localhost
  roles:
    - markosamuli.nvm
  tasks:
    - name: Add apt key
      ansible.builtin.apt_key:
        url: https://apt.releases.hashicorp.com/gpg
        state: present
    - name: Add apt repo num#1
      become: yes
      ansible.builtin.apt_repository:
        repo: "deb  https://apt.releases.hashicorp.com {{ ansible_distribution_release }} main"
    - name: Add apt repo num#2
      become: yes
      ansible.builtin.apt_repository:
        repo: "ppa:aslatter/ppa"
    - name: Install packages with apt
      ansible.builtin.apt:
        update_cache: true
        name:
          - git
          - i3
          - tmux
          - alacritty
          - curl
          - neovim
          - python3-pip
          - python3-neovim
          - packer
          - clang-12
          - zsh
        state: present
    - name: Install rigrep
      ansible.builtin.apt:
        deb: https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    - name: Setup zsh
      shell: |
        chsh -s $(which zsh)
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      ignore_errors: true
    - name: Download fzf
      ansible.builtin.git:
        repo: https://github.com/junegunn/fzf.git
        dest: ~/.fzf
        depth: 1
    - name: Install fzf
      ansible.builtin.shell: |
        yes | ~/.fzf/install
        source ~/.zshrc
      args:
        executable: /usr/bin/zsh
      become: yes
    - name: Install nvm
      ansible.builtin.shell: >
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | sh
      args:
        creates: "{{ ansible_env.HOME }}/.nvm/nvm.sh"
      become: true
    - name: Install node
      ansible.builtin.shell: |
        /bin/bash -c "source ~/.nvm/nvm.sh && nvm install node"
        creates=/home/{{ ansible_user_id }}/.nvm/alias
    - name: Install linters and formatters with npm
      loop:
        - eslint_d
        - typescript
        - cspell
        - typescript-language-server
        - tree-sitter-cli
      community.general.npm:
        name: "{{ item }}"
        global: true
        state: present
