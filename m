Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA327EB4F7
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:34:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wLL-0003gg-6l; Tue, 14 Nov 2023 11:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKl-0003E6-Mg
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wKi-0006cB-1F
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:32:15 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso13721660a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979530; x=1700584330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4vt0ZlqdP4cApbIjAIfqTCMR9wYqBXojziD0Op/yXU=;
 b=dVXWc61I87TakISPrCWrtg4XMAUdRMdznUCvEbmUOYxzQYrzz0QcstCcx8UgUxo61s
 MovOaAPqBWheGgxN0KwIMXfjFsuvjeTyEwI3/rfkF4+jTp2Rzgm6pJlZw+lSx/GgFiKd
 92rX+EB+f/5Amu6BQw/ebJMcW1Y9pl5L0OVOvo5CgFq+y/rNw9WQmP+RB9ihgprEDHHE
 W3Zk2UCnE4YIFgiDc39LWaeaGvRuCZggXgvzX/RvX4JIIGudE/qCYt1a4GpeaPOVGi7A
 gxI6SY8f3LWNhfJAoHbJ61IHnd0bfBsURFzCNq0SC5nVrf58gYAQA2dMDfF/pEQ4o/KO
 fiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979530; x=1700584330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4vt0ZlqdP4cApbIjAIfqTCMR9wYqBXojziD0Op/yXU=;
 b=EVYqDmLBCzrJ+l4Qb0548ueKfDsadi9F1nPLRXo7ig7u6vxfGpLIgAGiTBJtU4Lt1k
 M1iaJs3tC4s83C+nLH2MH64bBmcBNDZ7ugU/61xRWGTXCKTvDSarAcC0Vy1CZg9CW32T
 12+sUTRh4blRJh5GDaxdL7OaYn5b1ow+kFPBKDMYjxDChNjrn440Veo1V+rbHwvoUbP8
 Wn0x7ZsgErFGhBwHY7KwkTGmwjhkO8RllBVJgOx6I3wvD4Ewi0/69+8eX5gBxw4DV977
 T7dOfTHUdZOHg9LMFWPRF//MXx/2Fklb4MGehJIgiqzmNgCPIcx0eVafXDMU8FsE9LZt
 dqXg==
X-Gm-Message-State: AOJu0YyfUflydDDvdQk8sS23nAaL4IqZp7JmxFYO/j+1bm5ctSZ3HYxI
 IXFTXbi92UHxMOticuUOp98mfDbFwCDn2ISb6GI=
X-Google-Smtp-Source: AGHT+IELT61PbPjwVXxuH+TJlXpsuDAjuE2mWwi9Afbapfuv6KVhTt3679yscvvJRLV4fCglxsflqg==
X-Received: by 2002:a17:906:4fc8:b0:9a2:295a:9bbc with SMTP id
 i8-20020a1709064fc800b009a2295a9bbcmr3242168ejw.37.1699979530242; 
 Tue, 14 Nov 2023 08:32:10 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 k15-20020a17090646cf00b009932337747esm5670007ejs.86.2023.11.14.08.32.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:32:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.0 7/9] hw/xen/hvm: Extract common code to
 xen-hvm-common.c
Date: Tue, 14 Nov 2023 17:31:21 +0100
Message-ID: <20231114163123.74888-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114163123.74888-1-philmd@linaro.org>
References: <20231114163123.74888-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Extract non-x86 specific code out of xen-hvm.c,
to xen-hvm-common.c. For now this new file is
only build for x86 targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/xen/xen-hvm-common.c | 473 +++++++++++++++++++++++++++++++++++
 hw/i386/xen/xen-hvm.c        | 459 ---------------------------------
 hw/i386/xen/meson.build      |   1 +
 3 files changed, 474 insertions(+), 459 deletions(-)
 create mode 100644 hw/i386/xen/xen-hvm-common.c

diff --git a/hw/i386/xen/xen-hvm-common.c b/hw/i386/xen/xen-hvm-common.c
new file mode 100644
index 0000000000..e8ef0e0c94
--- /dev/null
+++ b/hw/i386/xen/xen-hvm-common.c
@@ -0,0 +1,473 @@
+/*
+ * Copyright (C) 2010       Citrix Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "qapi/qapi-commands-migration.h"
+#include "exec/target_page.h"
+#include "hw/xen/xen-hvm-common.h"
+#include "trace.h"
+
+static MemoryRegion *framebuffer;
+static bool xen_in_migration;
+
+static QLIST_HEAD(, XenPhysmap) xen_physmap;
+static const XenPhysmap *log_for_dirtybit;
+/* Buffer used by xen_sync_dirty_bitmap */
+static unsigned long *dirty_bitmap;
+
+static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
+                                   int page_mask)
+{
+    XenPhysmap *physmap = NULL;
+
+    start_addr &= -page_mask;
+
+    QLIST_FOREACH(physmap, &xen_physmap, list) {
+        if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
+            return physmap;
+        }
+    }
+    return NULL;
+}
+
+static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
+                                       int page_mask)
+{
+    hwaddr addr = phys_offset & -page_mask;
+    XenPhysmap *physmap = NULL;
+
+    QLIST_FOREACH(physmap, &xen_physmap, list) {
+        if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) {
+            return physmap->start_addr + (phys_offset - physmap->phys_offset);
+        }
+    }
+
+    return phys_offset;
+}
+
+#ifdef XEN_COMPAT_PHYSMAP
+static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
+{
+    char path[80], value[17];
+
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
+            xen_domid, (uint64_t)physmap->phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->start_addr);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
+            xen_domid, (uint64_t)physmap->phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->size);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    if (physmap->name) {
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
+                xen_domid, (uint64_t)physmap->phys_offset);
+        if (!xs_write(state->xenstore, 0, path,
+                      physmap->name, strlen(physmap->name))) {
+            return -1;
+        }
+    }
+    return 0;
+}
+#else
+static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
+{
+    return 0;
+}
+#endif
+
+static int xen_add_to_physmap(XenIOState *state,
+                              hwaddr start_addr,
+                              ram_addr_t size,
+                              MemoryRegion *mr,
+                              hwaddr offset_within_region)
+{
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    unsigned long nr_pages;
+    int rc = 0;
+    XenPhysmap *physmap = NULL;
+    hwaddr pfn, start_gpfn;
+    hwaddr phys_offset = memory_region_get_ram_addr(mr);
+    const char *mr_name;
+
+    if (get_physmapping(start_addr, size, page_mask)) {
+        return 0;
+    }
+    if (size <= 0) {
+        return -1;
+    }
+
+    /* Xen can only handle a single dirty log region for now and we want
+     * the linear framebuffer to be that region.
+     * Avoid tracking any regions that is not videoram and avoid tracking
+     * the legacy vga region. */
+    if (mr == framebuffer && start_addr > 0xbffff) {
+        goto go_physmap;
+    }
+    return -1;
+
+go_physmap:
+    DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
+            start_addr, start_addr + size);
+
+    mr_name = memory_region_name(mr);
+
+    physmap = g_new(XenPhysmap, 1);
+
+    physmap->start_addr = start_addr;
+    physmap->size = size;
+    physmap->name = mr_name;
+    physmap->phys_offset = phys_offset;
+
+    QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /* Now when we have a physmap entry we can replace a dummy mapping with
+         * a real one of guest foreign memory. */
+        uint8_t *p = xen_replace_cache_entry(phys_offset, start_addr, size);
+        assert(p && p == memory_region_get_ram_ptr(mr));
+
+        return 0;
+    }
+
+    pfn = phys_offset >> target_page_bits;
+    start_gpfn = start_addr >> target_page_bits;
+    nr_pages = size >> target_page_bits;
+    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
+                                        start_gpfn);
+    if (rc) {
+        int saved_errno = errno;
+
+        error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
+                     " to GFN %"HWADDR_PRIx" failed: %s",
+                     nr_pages, pfn, start_gpfn, strerror(saved_errno));
+        errno = saved_errno;
+        return -1;
+    }
+
+    rc = xendevicemodel_pin_memory_cacheattr(xen_dmod, xen_domid,
+                                   start_addr >> target_page_bits,
+                                   (start_addr + size - 1) >> target_page_bits,
+                                   XEN_DOMCTL_MEM_CACHEATTR_WB);
+    if (rc) {
+        error_report("pin_memory_cacheattr failed: %s", strerror(errno));
+    }
+    return xen_save_physmap(state, physmap);
+}
+
+static int xen_remove_from_physmap(XenIOState *state,
+                                   hwaddr start_addr,
+                                   ram_addr_t size)
+{
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    int rc = 0;
+    XenPhysmap *physmap = NULL;
+    hwaddr phys_offset = 0;
+
+    physmap = get_physmapping(start_addr, size, page_mask);
+    if (physmap == NULL) {
+        return -1;
+    }
+
+    phys_offset = physmap->phys_offset;
+    size = physmap->size;
+
+    DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
+            "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset);
+
+    size >>= target_page_bits;
+    start_addr >>= target_page_bits;
+    phys_offset >>= target_page_bits;
+    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, size, start_addr,
+                                        phys_offset);
+    if (rc) {
+        int saved_errno = errno;
+
+        error_report("relocate_memory "RAM_ADDR_FMT" pages"
+                     " from GFN %"HWADDR_PRIx
+                     " to GFN %"HWADDR_PRIx" failed: %s",
+                     size, start_addr, phys_offset, strerror(saved_errno));
+        errno = saved_errno;
+        return -1;
+    }
+
+    QLIST_REMOVE(physmap, list);
+    if (log_for_dirtybit == physmap) {
+        log_for_dirtybit = NULL;
+        g_free(dirty_bitmap);
+        dirty_bitmap = NULL;
+    }
+    g_free(physmap);
+
+    return 0;
+}
+
+static void xen_sync_dirty_bitmap(XenIOState *state,
+                                  hwaddr start_addr,
+                                  ram_addr_t size)
+{
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    hwaddr npages = size >> target_page_bits;
+    const int width = sizeof(unsigned long) * 8;
+    size_t bitmap_size = DIV_ROUND_UP(npages, width);
+    int rc, i, j;
+    const XenPhysmap *physmap = NULL;
+
+    physmap = get_physmapping(start_addr, size, page_mask);
+    if (physmap == NULL) {
+        /* not handled */
+        return;
+    }
+
+    if (log_for_dirtybit == NULL) {
+        log_for_dirtybit = physmap;
+        dirty_bitmap = g_new(unsigned long, bitmap_size);
+    } else if (log_for_dirtybit != physmap) {
+        /* Only one range for dirty bitmap can be tracked. */
+        return;
+    }
+
+    rc = xen_track_dirty_vram(xen_domid, start_addr >> target_page_bits,
+                              npages, dirty_bitmap);
+    if (rc < 0) {
+#ifndef ENODATA
+#define ENODATA  ENOENT
+#endif
+        if (errno == ENODATA) {
+            memory_region_set_dirty(framebuffer, 0, size);
+            DPRINTF("xen: track_dirty_vram failed (0x" HWADDR_FMT_plx
+                    ", 0x" HWADDR_FMT_plx "): %s\n",
+                    start_addr, start_addr + size, strerror(errno));
+        }
+        return;
+    }
+
+    for (i = 0; i < bitmap_size; i++) {
+        unsigned long map = dirty_bitmap[i];
+        while (map != 0) {
+            j = ctzl(map);
+            map &= ~(1ul << j);
+            memory_region_set_dirty(framebuffer,
+                                    (i * width + j) * page_size,
+                                    page_size);
+        };
+    }
+}
+
+static void xen_log_start(MemoryListener *listener,
+                          MemoryRegionSection *section,
+                          int old, int new)
+{
+    XenIOState *state = container_of(listener, XenIOState, memory_listener);
+
+    if (new & ~old & (1 << DIRTY_MEMORY_VGA)) {
+        xen_sync_dirty_bitmap(state, section->offset_within_address_space,
+                              int128_get64(section->size));
+    }
+}
+
+static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
+                         int old, int new)
+{
+    if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
+        log_for_dirtybit = NULL;
+        g_free(dirty_bitmap);
+        dirty_bitmap = NULL;
+        /* Disable dirty bit tracking */
+        xen_track_dirty_vram(xen_domid, 0, 0, NULL);
+    }
+}
+
+static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
+{
+    XenIOState *state = container_of(listener, XenIOState, memory_listener);
+
+    xen_sync_dirty_bitmap(state, section->offset_within_address_space,
+                          int128_get64(section->size));
+}
+
+static void xen_log_global_start(MemoryListener *listener)
+{
+    if (xen_enabled()) {
+        xen_in_migration = true;
+    }
+}
+
+static void xen_log_global_stop(MemoryListener *listener)
+{
+    xen_in_migration = false;
+}
+
+const MemoryListener xen_memory_listener = {
+    .name = "xen-memory",
+    .region_add = xen_region_add,
+    .region_del = xen_region_del,
+    .log_start = xen_log_start,
+    .log_stop = xen_log_stop,
+    .log_sync = xen_log_sync,
+    .log_global_start = xen_log_global_start,
+    .log_global_stop = xen_log_global_stop,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+};
+
+#ifdef XEN_COMPAT_PHYSMAP
+void xen_read_physmap(XenIOState *state)
+{
+    XenPhysmap *physmap = NULL;
+    unsigned int len, num, i;
+    char path[80], *value = NULL;
+    char **entries = NULL;
+
+    QLIST_INIT(&xen_physmap);
+
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap", xen_domid);
+    entries = xs_directory(state->xenstore, 0, path, &num);
+    if (entries == NULL)
+        return;
+
+    for (i = 0; i < num; i++) {
+        physmap = g_new(XenPhysmap, 1);
+        physmap->phys_offset = strtoull(entries[i], NULL, 16);
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
+                xen_domid, entries[i]);
+        value = xs_read(state->xenstore, 0, path, &len);
+        if (value == NULL) {
+            g_free(physmap);
+            continue;
+        }
+        physmap->start_addr = strtoull(value, NULL, 16);
+        free(value);
+
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/size",
+                xen_domid, entries[i]);
+        value = xs_read(state->xenstore, 0, path, &len);
+        if (value == NULL) {
+            g_free(physmap);
+            continue;
+        }
+        physmap->size = strtoull(value, NULL, 16);
+        free(value);
+
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/name",
+                xen_domid, entries[i]);
+        physmap->name = xs_read(state->xenstore, 0, path, &len);
+
+        QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
+    }
+    free(entries);
+}
+#else
+void xen_read_physmap(XenIOState *state)
+{
+    QLIST_INIT(&xen_physmap);
+}
+#endif
+
+void xen_register_framebuffer(MemoryRegion *mr)
+{
+    framebuffer = mr;
+}
+
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+
+    if (unlikely(xen_in_migration)) {
+        int rc;
+        ram_addr_t start_pfn, nb_pages;
+
+        start = xen_phys_offset_to_gaddr(start, length, page_mask);
+
+        if (length == 0) {
+            length = page_size;
+        }
+        start_pfn = start >> target_page_bits;
+        nb_pages = ((start + length + page_size - 1) >> target_page_bits)
+            - start_pfn;
+        rc = xen_modified_memory(xen_domid, start_pfn, nb_pages);
+        if (rc) {
+            fprintf(stderr,
+                    "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
+                    __func__, start, nb_pages, errno, strerror(errno));
+        }
+    }
+}
+
+void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
+{
+    if (enable) {
+        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
+    } else {
+        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
+    }
+}
+
+void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
+                         bool add)
+{
+    unsigned target_page_bits = qemu_target_page_bits();
+    int page_size = qemu_target_page_size();
+    int page_mask = -page_size;
+    hwaddr start_addr = section->offset_within_address_space;
+    ram_addr_t size = int128_get64(section->size);
+    bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
+    hvmmem_type_t mem_type;
+
+    if (!memory_region_is_ram(section->mr)) {
+        return;
+    }
+
+    if (log_dirty != add) {
+        return;
+    }
+
+    trace_xen_client_set_memory(start_addr, size, log_dirty);
+
+    start_addr &= page_mask;
+    size = ROUND_UP(size, page_size);
+
+    if (add) {
+        if (!memory_region_is_rom(section->mr)) {
+            xen_add_to_physmap(state, start_addr, size,
+                               section->mr, section->offset_within_region);
+        } else {
+            mem_type = HVMMEM_ram_ro;
+            if (xen_set_mem_type(xen_domid, mem_type,
+                                 start_addr >> target_page_bits,
+                                 size >> target_page_bits)) {
+                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
+                        start_addr);
+            }
+        }
+    } else {
+        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
+            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
+        }
+    }
+}
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3b9c31c1c8..5657693e1b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -9,16 +9,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qapi/error.h"
-#include "qapi/qapi-commands-migration.h"
-#include "trace.h"
 
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen-x86.h"
-#include "qemu/range.h"
 
 #include "hw/xen/xen-hvm-common.h"
 #include <xen/hvm/e820.h>
@@ -26,8 +21,6 @@
 #include "cpu.h"
 
 static MemoryRegion ram_640k, ram_lo, ram_hi;
-static MemoryRegion *framebuffer;
-static bool xen_in_migration;
 
 /* Compatibility with older version */
 
@@ -56,10 +49,6 @@ typedef struct shared_vmport_iopage shared_vmport_iopage_t;
 
 static shared_vmport_iopage_t *shared_vmport_page;
 
-static QLIST_HEAD(, XenPhysmap) xen_physmap;
-static const XenPhysmap *log_for_dirtybit;
-/* Buffer used by xen_sync_dirty_bitmap */
-static unsigned long *dirty_bitmap;
 static Notifier suspend;
 static Notifier wakeup;
 
@@ -175,312 +164,6 @@ static void xen_ram_init(PCMachineState *pcms,
     }
 }
 
-static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
-                                   int page_mask)
-{
-    XenPhysmap *physmap = NULL;
-
-    start_addr &= page_mask;
-
-    QLIST_FOREACH(physmap, &xen_physmap, list) {
-        if (range_covers_byte(physmap->start_addr, physmap->size, start_addr)) {
-            return physmap;
-        }
-    }
-    return NULL;
-}
-
-static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
-                                       int page_mask)
-{
-    hwaddr addr = phys_offset & page_mask;
-    XenPhysmap *physmap = NULL;
-
-    QLIST_FOREACH(physmap, &xen_physmap, list) {
-        if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) {
-            return physmap->start_addr + (phys_offset - physmap->phys_offset);
-        }
-    }
-
-    return phys_offset;
-}
-
-#ifdef XEN_COMPAT_PHYSMAP
-static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
-{
-    char path[80], value[17];
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr",
-            xen_domid, (uint64_t)physmap->phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->start_addr);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
-            xen_domid, (uint64_t)physmap->phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)physmap->size);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    if (physmap->name) {
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
-                xen_domid, (uint64_t)physmap->phys_offset);
-        if (!xs_write(state->xenstore, 0, path,
-                      physmap->name, strlen(physmap->name))) {
-            return -1;
-        }
-    }
-    return 0;
-}
-#else
-static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
-{
-    return 0;
-}
-#endif
-
-static int xen_add_to_physmap(XenIOState *state,
-                              hwaddr start_addr,
-                              ram_addr_t size,
-                              MemoryRegion *mr,
-                              hwaddr offset_within_region)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-    unsigned long nr_pages;
-    int rc = 0;
-    XenPhysmap *physmap = NULL;
-    hwaddr pfn, start_gpfn;
-    hwaddr phys_offset = memory_region_get_ram_addr(mr);
-    const char *mr_name;
-
-    if (get_physmapping(start_addr, size, page_mask)) {
-        return 0;
-    }
-    if (size <= 0) {
-        return -1;
-    }
-
-    /* Xen can only handle a single dirty log region for now and we want
-     * the linear framebuffer to be that region.
-     * Avoid tracking any regions that is not videoram and avoid tracking
-     * the legacy vga region. */
-    if (mr == framebuffer && start_addr > 0xbffff) {
-        goto go_physmap;
-    }
-    return -1;
-
-go_physmap:
-    DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
-            start_addr, start_addr + size);
-
-    mr_name = memory_region_name(mr);
-
-    physmap = g_new(XenPhysmap, 1);
-
-    physmap->start_addr = start_addr;
-    physmap->size = size;
-    physmap->name = mr_name;
-    physmap->phys_offset = phys_offset;
-
-    QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
-
-    if (runstate_check(RUN_STATE_INMIGRATE)) {
-        /* Now when we have a physmap entry we can replace a dummy mapping with
-         * a real one of guest foreign memory. */
-        uint8_t *p = xen_replace_cache_entry(phys_offset, start_addr, size);
-        assert(p && p == memory_region_get_ram_ptr(mr));
-
-        return 0;
-    }
-
-    pfn = phys_offset >> target_page_bits;
-    start_gpfn = start_addr >> target_page_bits;
-    nr_pages = size >> target_page_bits;
-    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
-                                        start_gpfn);
-    if (rc) {
-        int saved_errno = errno;
-
-        error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
-                     " to GFN %"HWADDR_PRIx" failed: %s",
-                     nr_pages, pfn, start_gpfn, strerror(saved_errno));
-        errno = saved_errno;
-        return -1;
-    }
-
-    rc = xendevicemodel_pin_memory_cacheattr(xen_dmod, xen_domid,
-                                   start_addr >> target_page_bits,
-                                   (start_addr + size - 1) >> target_page_bits,
-                                   XEN_DOMCTL_MEM_CACHEATTR_WB);
-    if (rc) {
-        error_report("pin_memory_cacheattr failed: %s", strerror(errno));
-    }
-    return xen_save_physmap(state, physmap);
-}
-
-static int xen_remove_from_physmap(XenIOState *state,
-                                   hwaddr start_addr,
-                                   ram_addr_t size)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-    int rc = 0;
-    XenPhysmap *physmap = NULL;
-    hwaddr phys_offset = 0;
-
-    physmap = get_physmapping(start_addr, size, page_mask);
-    if (physmap == NULL) {
-        return -1;
-    }
-
-    phys_offset = physmap->phys_offset;
-    size = physmap->size;
-
-    DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
-            "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset);
-
-    size >>= target_page_bits;
-    start_addr >>= target_page_bits;
-    phys_offset >>= target_page_bits;
-    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, size, start_addr,
-                                        phys_offset);
-    if (rc) {
-        int saved_errno = errno;
-
-        error_report("relocate_memory "RAM_ADDR_FMT" pages"
-                     " from GFN %"HWADDR_PRIx
-                     " to GFN %"HWADDR_PRIx" failed: %s",
-                     size, start_addr, phys_offset, strerror(saved_errno));
-        errno = saved_errno;
-        return -1;
-    }
-
-    QLIST_REMOVE(physmap, list);
-    if (log_for_dirtybit == physmap) {
-        log_for_dirtybit = NULL;
-        g_free(dirty_bitmap);
-        dirty_bitmap = NULL;
-    }
-    g_free(physmap);
-
-    return 0;
-}
-
-static void xen_sync_dirty_bitmap(XenIOState *state,
-                                  hwaddr start_addr,
-                                  ram_addr_t size)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-    hwaddr npages = size >> target_page_bits;
-    const int width = sizeof(unsigned long) * 8;
-    size_t bitmap_size = DIV_ROUND_UP(npages, width);
-    int rc, i, j;
-    const XenPhysmap *physmap = NULL;
-
-    physmap = get_physmapping(start_addr, size, page_mask);
-    if (physmap == NULL) {
-        /* not handled */
-        return;
-    }
-
-    if (log_for_dirtybit == NULL) {
-        log_for_dirtybit = physmap;
-        dirty_bitmap = g_new(unsigned long, bitmap_size);
-    } else if (log_for_dirtybit != physmap) {
-        /* Only one range for dirty bitmap can be tracked. */
-        return;
-    }
-
-    rc = xen_track_dirty_vram(xen_domid, start_addr >> target_page_bits,
-                              npages, dirty_bitmap);
-    if (rc < 0) {
-#ifndef ENODATA
-#define ENODATA  ENOENT
-#endif
-        if (errno == ENODATA) {
-            memory_region_set_dirty(framebuffer, 0, size);
-            DPRINTF("xen: track_dirty_vram failed (0x" HWADDR_FMT_plx
-                    ", 0x" HWADDR_FMT_plx "): %s\n",
-                    start_addr, start_addr + size, strerror(errno));
-        }
-        return;
-    }
-
-    for (i = 0; i < bitmap_size; i++) {
-        unsigned long map = dirty_bitmap[i];
-        while (map != 0) {
-            j = ctzl(map);
-            map &= ~(1ul << j);
-            memory_region_set_dirty(framebuffer,
-                                    (i * width + j) * page_size, page_size);
-        };
-    }
-}
-
-static void xen_log_start(MemoryListener *listener,
-                          MemoryRegionSection *section,
-                          int old, int new)
-{
-    XenIOState *state = container_of(listener, XenIOState, memory_listener);
-
-    if (new & ~old & (1 << DIRTY_MEMORY_VGA)) {
-        xen_sync_dirty_bitmap(state, section->offset_within_address_space,
-                              int128_get64(section->size));
-    }
-}
-
-static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *section,
-                         int old, int new)
-{
-    if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
-        log_for_dirtybit = NULL;
-        g_free(dirty_bitmap);
-        dirty_bitmap = NULL;
-        /* Disable dirty bit tracking */
-        xen_track_dirty_vram(xen_domid, 0, 0, NULL);
-    }
-}
-
-static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
-{
-    XenIOState *state = container_of(listener, XenIOState, memory_listener);
-
-    xen_sync_dirty_bitmap(state, section->offset_within_address_space,
-                          int128_get64(section->size));
-}
-
-static void xen_log_global_start(MemoryListener *listener)
-{
-    if (xen_enabled()) {
-        xen_in_migration = true;
-    }
-}
-
-static void xen_log_global_stop(MemoryListener *listener)
-{
-    xen_in_migration = false;
-}
-
-const MemoryListener xen_memory_listener = {
-    .name = "xen-memory",
-    .region_add = xen_region_add,
-    .region_del = xen_region_del,
-    .log_start = xen_log_start,
-    .log_stop = xen_log_stop,
-    .log_sync = xen_log_sync,
-    .log_global_start = xen_log_global_start,
-    .log_global_stop = xen_log_global_stop,
-    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
-};
-
 static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
 {
     X86CPU *cpu;
@@ -524,63 +207,6 @@ static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
     current_cpu = NULL;
 }
 
-#ifdef XEN_COMPAT_PHYSMAP
-void xen_read_physmap(XenIOState *state)
-{
-    XenPhysmap *physmap = NULL;
-    unsigned int len, num, i;
-    char path[80], *value = NULL;
-    char **entries = NULL;
-
-    QLIST_INIT(&xen_physmap);
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap", xen_domid);
-    entries = xs_directory(state->xenstore, 0, path, &num);
-    if (entries == NULL)
-        return;
-
-    for (i = 0; i < num; i++) {
-        physmap = g_new(XenPhysmap, 1);
-        physmap->phys_offset = strtoull(entries[i], NULL, 16);
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
-                xen_domid, entries[i]);
-        value = xs_read(state->xenstore, 0, path, &len);
-        if (value == NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->start_addr = strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/size",
-                xen_domid, entries[i]);
-        value = xs_read(state->xenstore, 0, path, &len);
-        if (value == NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->size = strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/name",
-                xen_domid, entries[i]);
-        physmap->name = xs_read(state->xenstore, 0, path, &len);
-
-        QLIST_INSERT_HEAD(&xen_physmap, physmap, list);
-    }
-    free(entries);
-}
-#else
-void xen_read_physmap(XenIOState *state)
-{
-    QLIST_INIT(&xen_physmap);
-}
-#endif
-
 static void xen_wakeup_notifier(Notifier *notifier, void *data)
 {
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
@@ -635,91 +261,6 @@ err:
     exit(1);
 }
 
-void xen_register_framebuffer(MemoryRegion *mr)
-{
-    framebuffer = mr;
-}
-
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-
-    if (unlikely(xen_in_migration)) {
-        int rc;
-        ram_addr_t start_pfn, nb_pages;
-
-        start = xen_phys_offset_to_gaddr(start, length, page_mask);
-
-        if (length == 0) {
-            length = page_size;
-        }
-        start_pfn = start >> target_page_bits;
-        nb_pages = ((start + length + page_size - 1) >> target_page_bits)
-            - start_pfn;
-        rc = xen_modified_memory(xen_domid, start_pfn, nb_pages);
-        if (rc) {
-            fprintf(stderr,
-                    "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s\n",
-                    __func__, start, nb_pages, errno, strerror(errno));
-        }
-    }
-}
-
-void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
-{
-    if (enable) {
-        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
-    } else {
-        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
-    }
-}
-
-void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
-                         bool add)
-{
-    unsigned target_page_bits = qemu_target_page_bits();
-    int page_size = qemu_target_page_size();
-    int page_mask = -page_size;
-    hwaddr start_addr = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
-    hvmmem_type_t mem_type;
-
-    if (!memory_region_is_ram(section->mr)) {
-        return;
-    }
-
-    if (log_dirty != add) {
-        return;
-    }
-
-    trace_xen_client_set_memory(start_addr, size, log_dirty);
-
-    start_addr &= page_mask;
-    size = ROUND_UP(size, page_size);
-
-    if (add) {
-        if (!memory_region_is_rom(section->mr)) {
-            xen_add_to_physmap(state, start_addr, size,
-                               section->mr, section->offset_within_region);
-        } else {
-            mem_type = HVMMEM_ram_ro;
-            if (xen_set_mem_type(xen_domid, mem_type,
-                                 start_addr >> target_page_bits,
-                                 size >> target_page_bits)) {
-                DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
-                        start_addr);
-            }
-        }
-    } else {
-        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
-            DPRINTF("physmapping does not exist at "HWADDR_FMT_plx"\n", start_addr);
-        }
-    }
-}
-
 void xen_arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     switch (req->type) {
diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
index 3f0df8bc07..d38759cfe4 100644
--- a/hw/i386/xen/meson.build
+++ b/hw/i386/xen/meson.build
@@ -1,6 +1,7 @@
 i386_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen_apic.c',
   'xen_pvdevice.c',
+  'xen-hvm-common.c',
 ))
 i386_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-hvm.c',
-- 
2.41.0


