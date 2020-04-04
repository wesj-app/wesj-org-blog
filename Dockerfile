FROM klakegg/hugo:0.68.3-pandoc-onbuild AS hugo

FROM nginx
COPY --from=hugo /target /usr/share/nginx/html