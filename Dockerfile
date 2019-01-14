# From Defines are parent container. You will notice that I specifically use
# a specific version tag, docker supports using :latest as a tag - which will
# automatically use the latest available. This is considered an anti-pattern
# Discuss ?
FROM nginx:1.15.8

# Copy will send the content of a local directory into the container. 
# In this example we just want to copy static content into the container
COPY html /usr/share/nginx/html

# The EXPOSE instruction indicates the ports on which a container listens for 
# connections. Consequently, you should use the common, traditional port for 
# your application.
EXPOSE 80
