#docker run --rm -t -i --name gitlab-runner -v /srv/gitlab-runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock fluxter/gitlab-runner
docker stop gitlab-runner
docker rm gitlab-runner
docker run --restart always -d -t -i --name gitlab-runner -v /srv/gitlab-runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock fluxter/gitlab-runner
