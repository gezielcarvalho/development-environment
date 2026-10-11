# Scope and roadmap

## Current scope

- Docker Compose templates for local development services and sample runtimes.
- Ubuntu/WSL2-first guidance, with documented MacOS considerations.
- Local volumes and developer administration tools.

## Out of scope

- Production hosting, shared databases, remote deployment, or a managed secret store.
- Treating examples in the README or `.env.example` as deployable credentials.
- Running initialization, cleanup, or volume-removal commands without an explicit local decision and backup plan.

## Review points

Revalidate images and instructions before a demo; add a dedicated security and operations decision before any shared environment; scope individual service changes through issues and pull requests.
