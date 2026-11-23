URLS := $(shell jq -r '.[][]' manifest.json)
.PHONY: fetch_release_scripts vendor_cdn

fetch_release_scripts:
	@$(foreach url,$(URLS),wget -q -O www/$(patsubst install-%,%,$(notdir $(url))) $(url) &&) true

vendor_cdn:
	@mkdir www/js
	@mkdir www/css
	@curl -fsSL -o www/js/highlight.min.js https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js
	@curl -fsSL -o www/css/github-dark.min.css https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css
	@curl -fsSL -o www/js/bootstrap.bundle.min.js https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js
	@curl -fsSL -o www/css/bootstrap.min.css https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css

dev:
	@python3 -m http.server -d www