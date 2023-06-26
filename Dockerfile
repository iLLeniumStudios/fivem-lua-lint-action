FROM ghcr.io/illeniumstudios/luacheck:v1.1.1-fivem-lua-v1.3.1

RUN mkdir -p /luacheck-fivem
ADD . /luacheck-fivem/
RUN apk add --no-cache yarn nodejs && \
    cd /luacheck-fivem/ && \
    yarn --prod --frozen-lockfile && yarn build && \
    chmod +x /luacheck-fivem/.docker/entrypoint.sh 
ENTRYPOINT ["/luacheck-fivem/.docker/entrypoint.sh"]
