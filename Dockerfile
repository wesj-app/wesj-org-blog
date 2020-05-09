FROM klakegg/hugo:0.70.0-ext-pandoc-onbuild as hugo

FROM nginx
COPY --from=hugo /target /usr/share/nginx/html
