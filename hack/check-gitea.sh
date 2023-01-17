#!/usr/bin/env bash

set -euxo pipefail

kubectl rollout status statefulsets.apps gitea --timeout=60s || printf "I expected an gitea statefulset"  

kubectl get svc gitea-http  || printf "I expected an gitea-http deployment"  

kubectl wait --for=condition=complete --timeout=120s -n drone job/workshop-setup

mapfile -t git_remotes < <(git remote --no-verbose)

printf "\n The '%s' has remotes '%s' \n" "${DRAG_HOME}" "${git_remotes[*]}"

i=0
for r in "${git_remotes[@]}"
do
  # echo "$r"
	if [ "$r" == "origin" ]  || [ "$r" == "upstream" ] ;
	then
    ((i=i+1))
    # echo "$i"
	  continue
	fi
done

[[ i -eq 2 ]] || printf "either origin or upstream not found in git remotes"

ORIGIN_URL=$(git remote get-url --push origin)

if [ "$ORIGIN_URL" != "${GITEA_GITOPS_CORE_REPO}" ];
then
  printf "\gitea repository has wrong origin %s instead of %s\n" "${ORIGIN_URL}"  "${GITEA_GITOPS_CORE_REPO}"
fi