# Delivery and quality

Use an issue with acceptance criteria, validation, risks, rollback, and human gates. Use a pull request for reviewable changes.

For configuration changes, review Compose syntax, image sources, exposed ports, volume behaviour, and template/documentation consistency. Run affected local validation only under a separately approved task. Documentation-only changes require link and tree review.

Never treat successful local startup as production approval. A pull request must state its validation evidence and whether it changes data, credentials, ports, images, or developer-machine behaviour.
