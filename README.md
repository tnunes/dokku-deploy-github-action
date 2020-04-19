# dokku-deploy-github-action

This action automates deployment to a dokku server.

## Inputs

### ssh-private-key

The private ssh key used for Dokku deployments. Never use as plain text! Configure it as a secret in your repository by navigating to https://github.com/USERNAME/REPO/settings/secrets

**Required**

### dokku-user

The user to use for ssh. If not specified, "dokku" user will be used.

### dokku-hostname

The Dokku host hostname name to deploy to.

### dokku-hostport

The Dokku host port to deploy to. If not specified, `22` is the default.

### app-name

The Dokku app name to be deployed.

### remote-branch

The branch to push on the remote repository. If not specified, `master` will be used.

### git-push-flags

You may set additional flags that will be passed to the `git push` command. You might want to set this parameter to `--force` if you're pushing to Dokku from other places and encounter the following error:
```
error: failed to push some refs to 'dokku@mydokkuhost.com:mydokkurepo'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

## Example

Note: `actions/checkout` must preceed this action in order for the repository data to be exposed for the action.
It is recommended to pass `actions/checkout` the `fetch-depth: 0` parameter to avoid errors such as `shallow update not allowed`

```
steps:
  - uses: actions/checkout@v2
    with:
        fetch-depth: 0
  - id: deploy
    name: Deploy to dokku
    uses: tnunes/dokku-deploy-github-action@v1
    with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
        dokku-hostname: ${{ secrets.DOKKU_HOST_NAME }}
        dokku-hostport: ${{ secrets.DOKKU_HOST_PORT }}
        app-name: ${{ secrets.DOKKU_APP }}
```
