FROM gitpod/workspace-full

USER gitpod

RUN npm add -g pnpm && pnpm add -g purescript spago purs-tidy