# Bash tools for GitHub API

Tools for automating work with [GitHub](https://github.com/).

## Creating repository

- [repo.create.sh](repo.create.sh)
  - `-x 'TOKEN'`  
    GitHub user token.
  - `-o 'OWNER'`  
    Organization name. This is not case sensitive.
  - `-r 'REPO_1;REPO_2;REPO_3'`  
    Repository name (array).
  - `-d 'DESCRIPTION'`  
    Repository description.
  - `-s 'https://example.org/'`  
    Repository site URL.
  - `-l 'mit'`  
    Open source license template. For example, "mit" or "mpl-2.0".
  - `-p`  
    Whether repository is private.
  - `-i`  
    Enable issues for this repository.
  - `-j`  
    Enable projects for this repository.
    NOTE: If you're creating a repository in an organization that has disabled repository projects, the API returns an error.
  - `-w`  
    Enable wiki for this repository.
  - `-u`  
    Create an initial commit with empty README.

## Deleting repository

- [repo.delete.sh](repo.delete.sh)
  - `-x 'TOKEN'`  
    GitHub user token.
  - `-o 'OWNER'`  
    Repository owner (organization).
  - `-r 'REPO_1;REPO_2;REPO_3'`  
    Repository name (array).

## Updating topics

- [repo.topics.sh](repo.topics.sh)
  - `-x 'TOKEN'`  
    GitHub user token.
  - `-o 'OWNER'`  
    Repository owner (organization).
  - `-r 'REPO_1;REPO_2;REPO_3'`  
    Repository name (array).
  - `-t 'TOPIC_1;TOPIC_2;TOPIC_3'`  
    Topic name (array).

## Transfer repository

- [repo.transfer.sh](repo.transfer.sh)
  - `-x 'TOKEN'`  
    GitHub user token.
  - `-o 'OWNER_OLD'`  
    OLD repository owner (organization).
  - `-n 'OWNER_NEW'`  
    NEW repository owner (organization).
  - `-r 'REPO_1;REPO_2;REPO_3'`  
    Repository name (array).

## Updating repository

- [repo.update.sh](repo.update.sh)
  - `-x 'TOKEN'`  
    GitHub user token.
  - `-o 'OWNER'`  
    Repository owner (organization).
  - `-r 'REPO_1;REPO_2;REPO_3'`  
    Repository name (array).
  - `-d 'DESCRIPTION'`  
    Repository description.
  - `-s 'https://example.org/'`  
    Repository site URL.
  - `-p`  
    Whether repository is private.
  - `-i`  
    Enable issues for this repository.
  - `-j`  
    Enable projects for this repository.
  - `-w`  
    Enable wiki for this repository.
