SUBDIRS = domain data presentation

define recursive_in_subs
	for dir in $(SUBDIRS); do $(MAKE) $(1) -C $$dir; done
endef

dependencies:
	$(call recursive_in_subs, dependencies)
clean:
	$(call recursive_in_subs, clean)

build-runner:
	$(call recursive_in_subs, build-runner)

analyze:
	$(call recursive_in_subs, analyze)

dart-fix-quietly:
	flutter pub global activate dartfix
	$(call recursive_in_subs, dart-fix-quietly)

setup: clean dependencies build-runner

build-android-dev:
	$(MAKE) build-android-dev -C presentation

build-android-prd:
	$(MAKE) build-android-prd -C presentation

run-prd:
	$(MAKE) run-prd -C presentation

run-dev:
	$(MAKE) run-prd -C presentation
