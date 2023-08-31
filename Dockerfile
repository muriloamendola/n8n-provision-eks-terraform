FROM hashicorp/terraform:latest

RUN apk add --no-cache curl

# add kube configs and crts
#ADD .kube /root/.kube

# add terrafrom modules
RUN mkdir /app
COPY terraform-manifests/*.tf /app/.
ADD entrypoint.sh /app/entrypoint.sh

# terraform state directory
RUN mkdir /app/.state
VOLUME .state

WORKDIR /app

ENTRYPOINT ["./entrypoint.sh"]