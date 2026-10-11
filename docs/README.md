# Project documentation

This is the current-state entry point for the Docker Development Environment Multi-Tool. The detailed [README](../README.md) remains the guide for services, setup, platform notes, and troubleshooting.

| Document | Purpose |
| --- | --- |
| [Charter](charter.md) | Purpose, audience, and success measures. |
| [Scope and roadmap](scope-and-roadmap.md) | Supported local scope and review points. |
| [Architecture](architecture.md) | Container groups and configuration boundaries. |
| [Delivery and quality](delivery-and-quality.md) | Change and validation expectations. |
| [Operations](operations.md) | Local operations, data, and credential safety. |
| [Risks and decisions](risks-and-decisions.md) | Active risks and decision log. |
| [ADRs](adr/README.md) | Durable-decision process. |

`docker-compose.example.yaml` and `.env.example` are templates, not approved shared-environment configuration. The initializer can overwrite local `.env` and Compose files; back up intentional local changes before choosing to run it.
