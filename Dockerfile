FROM klakegg/hugo:0.68.3-pandoc-onbuild AS hugo

FROM nginx
# Clean out example content
RUN rm -rf /usr/share/nginx/html
COPY --from=hugo /target /usr/share/nginx/html
