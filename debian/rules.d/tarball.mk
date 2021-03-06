unpack: $(stamp)unpack
$(stamp)unpack: $(DEB_TARBALL) $(patsubst %,$(stamp)%,$(GLIBC_OVERLAYS))
	touch $(stamp)unpack

# FIXME: Support gzip as well!
$(DEB_TARBALL): $(stamp)$(DEB_TARBALL)
$(stamp)$(DEB_TARBALL):
	mkdir -p $(build-tree)
	cd $(build-tree) && tar -xjf $(CURDIR)/$(DEB_TARBALL)
	touch $@

$(patsubst %,$(stamp)%,$(GLIBC_OVERLAYS)): $(stamp)$(DEB_TARBALL)
	cd $(DEB_SRCDIR) && tar -xjf $(CURDIR)/$(notdir $@)
	a=`echo $(notdir $@) | sed -e 's/^glibc-//' -e 's/-[^-]*$$//'`; \
	d=`echo $(notdir $@) | sed -e 's/\.tar\.bz2$$//'`; \
	if test -d $(DEB_SRCDIR)/$$d; then \
	  cd $(DEB_SRCDIR) && mv $$d $$a; \
	fi
	touch $@


