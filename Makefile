DOCUMENTATION_PATH?=./docs
TARGET=MultipartFormData
HOSTING_PATH=swift-multipart-formdata

all: generate-documentation

generate-documentation:
	swift package \
		--allow-writing-to-directory $(DOCUMENTATION_PATH) \
		generate-documentation \
		--target $(TARGET) \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(HOSTING_PATH) \
		--output-path $(DOCUMENTATION_PATH)
