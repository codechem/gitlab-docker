
# CC Gitlab Setup

---

## First run configuration
Change `external_url` to `http` in `docker-compose.yml` for the initial run.

```bash
docker-compose up
```

Wait for it to start and move on to:

### Fetching the Let's Encrypt certificates:

Get into the container's shell:

```bash
docker exec -it gitlab bash
```

Retrieve the certificates using certbot:

```bash
certbot certonly --webroot --webroot-path=/var/www/letsencrypt -d git.codechem.com
```

Fill in the necessary information or try the non-interactive version (untested, but should work):

```bash
certbot certonly --webroot --webroot-path=/var/www/letsencrypt -d git.codechem.com -n --agree-tos -m someone@mail.com
```


### Change the configuration for SSL:

Change `external_url` back to `https` in `docker-compose.yml`, and re-create the container by running:

```bash
docker-compose up
```

### Importing the repositories
[Up to date link](https://docs.gitlab.com/ce/raketasks/import.html)

### Move the repositories

You can put the bare repositories in the `data/git-data/repositories` folder.

The folders underneath this folder will be the define the name of the new groups, you can group multiple repositories in subfolders and they will be imported with ownership belonging to the groups.

### Update ownership and run the import

Navigate to the repositories folder and run the following command to set the ownership appropriately for the repositories to be imported:

```bash
chown -R git:git
gitlab-rake gitlab:import:repos
```

### That's it

Enjoy your newly created GitLab instance