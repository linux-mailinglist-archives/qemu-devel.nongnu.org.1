Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646CB03D26
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 13:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7l-0000mN-Qj; Mon, 14 Jul 2025 07:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGze-0000sh-Gt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGza-0001qA-Dt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVSDzAtwaFD9fiToH2+ocY4Vipill1SaMZ1A9opcZdk=;
 b=HtCGzqtwQ/CXFYNUA2xa5z6LconCwXrsIQtL+EFnoJG11BHapnV/O6/wjUQe8v+hiIZEas
 8YLdjif3niMmR4SIoKJ5s9c4/IaXb9WzdETtGxDTri6eLqSg2pAzTQnzP74IQPGqSQ+4dt
 3RBX8ueEuCfK3bbN6YrxbrMmwbal3uY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-MBIEOwLPM1CoGF2tx6uINw-1; Mon, 14 Jul 2025 07:05:04 -0400
X-MC-Unique: MBIEOwLPM1CoGF2tx6uINw-1
X-Mimecast-MFC-AGG-ID: MBIEOwLPM1CoGF2tx6uINw_1752491103
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so22098885e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491102; x=1753095902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVSDzAtwaFD9fiToH2+ocY4Vipill1SaMZ1A9opcZdk=;
 b=qlvEBx/l4iUpngFGrHau16uO1MaZvM1h/sPTj+4FkPGb9ErDaGJwaUiTNBRz3qPhHU
 b8Y4WvBxNHsxqcXH6laD/kyzgRI0u+AV9RIMyNt0+nGCD7UmudZ30LnpkiYHy0CD7HcI
 Tobw80L5xEBaUSseyFWBcpH8K+mIKLTHpKeNNgb0s1AgIautPwP2KINagA8r2QpBmGha
 cXbE8icaocM3v5Tp5Sp7E9a0txJaLh0QlrxGsxlDqcrA9KOxAbz0h61XfiuyYLZ4/M3h
 YLec5qjQFm6KOHRahweCJ9KBglnbYb8qCSnpF8z+ahEjoLuqIAGtYdfZxLI+Ze5mH5dH
 jIZQ==
X-Gm-Message-State: AOJu0YxMNkAhqrwjk34IN5qfW7AHRX5ERJRwqC6JpZzcLvjelA/M7iwt
 XJvb6UFKZX0U+q9Mowgbg91Alo5uMamq02AsYdCMMgOlLq5IeeomQFRW57Sz0uQe//YRmOvWBkV
 35H19/VJ9FkeMLAszPltcNuH/OYUgqHUSwr5gijvAIWRw5LpoY847xOjjttALGm1Y9ZjGtiSaEY
 SRjo4JF1vyiGcz0GjxlCvwPeM1qDdfmrfoV6HSIZBF
X-Gm-Gg: ASbGncu2yIoLdWoJSMbsAMBGoMiODoYKHXqa2K+RGhFF2YRzYmOKDUC/bsKapol6XHY
 qqye3V2HCQIYraC5cnV0+m+bt4L9mdMtz4zhY+JGG1e2yEDNHufirgR/mUu0fFh4i4ZbyjQJndx
 jIyYUTNWC8no8P6KjqeLBStubI4Xt90bbCJH/oUeADQuZdYuDY8QIVTrII0l1SZ2pfBZsr2biu3
 J2IDRSb7Iff5KUjuHVycdIipL69lg8QxAUZE/PSegB/DHbSCKooysVfBjaOkHee1CrZr+grvrCJ
 M5u4nTRURCS5pEwKm022TJZbCLR9D51dkaMNHhnkgug=
X-Received: by 2002:a05:600c:34d1:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-4561d61b16amr21038445e9.30.1752491101236; 
 Mon, 14 Jul 2025 04:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbWP3GpQ39d7rZiFAE0vqkieHgWItnvyhDL6KcBE+b/uxwV9RS7CCxtAZSnhQdyRIYJ7DauA==
X-Received: by 2002:a05:600c:34d1:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-4561d61b16amr21037915e9.30.1752491100473; 
 Mon, 14 Jul 2025 04:05:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e211dcsm11838403f8f.84.2025.07.14.04.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 19/77] backends/igvm: Add IGVM loader and configuration
Date: Mon, 14 Jul 2025 13:03:08 +0200
Message-ID: <20250714110406.117772-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

Adds an IGVM loader to QEMU which processes a given IGVM file and
applies the directives within the file to the current guest
configuration.

The IGVM loader can be used to configure both confidential and
non-confidential guests. For confidential guests, the
ConfidentialGuestSupport object for the system is used to encrypt
memory, apply the initial CPU state and perform other confidential guest
operations.

The loader is configured via a new IgvmCfg QOM object which allows the
user to provide a path to the IGVM file to process.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/ae3a07d8f514d93845a9c16bb155c847cb567b0d.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json             |  17 +
 backends/igvm.h           |  22 ++
 include/system/igvm-cfg.h |  46 +++
 backends/igvm-cfg.c       |  51 +++
 backends/igvm.c           | 807 ++++++++++++++++++++++++++++++++++++++
 backends/meson.build      |   2 +
 6 files changed, 945 insertions(+)
 create mode 100644 backends/igvm.h
 create mode 100644 include/system/igvm-cfg.h
 create mode 100644 backends/igvm-cfg.c
 create mode 100644 backends/igvm.c

diff --git a/qapi/qom.json b/qapi/qom.json
index b133b064471..bbdb56dced6 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -932,6 +932,19 @@
   'data': { '*filename': 'str' },
   'if': 'CONFIG_POSIX' }
 
+##
+# @IgvmCfgProperties:
+#
+# Properties common to objects that handle IGVM files.
+#
+# @file: IGVM file to use to configure guest
+#
+# Since: 10.1
+##
+{ 'struct': 'IgvmCfgProperties',
+  'if': 'CONFIG_IGVM',
+  'data': { 'file': 'str' } }
+
 ##
 # @SevCommonProperties:
 #
@@ -1142,6 +1155,8 @@
     'filter-redirector',
     'filter-replay',
     'filter-rewriter',
+    { 'name': 'igvm-cfg',
+      'if': 'CONFIG_IGVM' },
     'input-barrier',
     { 'name': 'input-linux',
       'if': 'CONFIG_LINUX' },
@@ -1218,6 +1233,8 @@
       'filter-redirector':          'FilterRedirectorProperties',
       'filter-replay':              'NetfilterProperties',
       'filter-rewriter':            'FilterRewriterProperties',
+      'igvm-cfg':                   { 'type': 'IgvmCfgProperties',
+                                      'if': 'CONFIG_IGVM' },
       'input-barrier':              'InputBarrierProperties',
       'input-linux':                { 'type': 'InputLinuxProperties',
                                       'if': 'CONFIG_LINUX' },
diff --git a/backends/igvm.h b/backends/igvm.h
new file mode 100644
index 00000000000..db02ea91651
--- /dev/null
+++ b/backends/igvm.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU IGVM configuration backend for Confidential Guests
+ *
+ * Copyright (C) 2023-2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@randomman.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BACKENDS_IGVM_H
+#define BACKENDS_IGVM_H
+
+#include "system/confidential-guest-support.h"
+#include "system/igvm-cfg.h"
+#include "qapi/error.h"
+
+int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
+                      Error **errp);
+
+#endif
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
new file mode 100644
index 00000000000..321b3196f09
--- /dev/null
+++ b/include/system/igvm-cfg.h
@@ -0,0 +1,46 @@
+/*
+ * QEMU IGVM interface
+ *
+ * Copyright (C) 2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@randomman.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_IGVM_CFG_H
+#define QEMU_IGVM_CFG_H
+
+#include "qom/object.h"
+
+typedef struct IgvmCfg {
+    ObjectClass parent_class;
+
+    /*
+     * filename: Filename that specifies a file that contains the configuration
+     *           of the guest in Independent Guest Virtual Machine (IGVM)
+     *           format.
+     */
+    char *filename;
+} IgvmCfg;
+
+typedef struct IgvmCfgClass {
+    ObjectClass parent_class;
+
+    /*
+     * If an IGVM filename has been specified then process the IGVM file.
+     * Performs a no-op if no filename has been specified.
+     *
+     * Returns 0 for ok and -1 on error.
+     */
+    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+                   Error **errp);
+
+} IgvmCfgClass;
+
+#define TYPE_IGVM_CFG "igvm-cfg"
+
+OBJECT_DECLARE_TYPE(IgvmCfg, IgvmCfgClass, IGVM_CFG)
+
+#endif
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
new file mode 100644
index 00000000000..45df63e06c1
--- /dev/null
+++ b/backends/igvm-cfg.c
@@ -0,0 +1,51 @@
+/*
+ * QEMU IGVM interface
+ *
+ * Copyright (C) 2023-2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@randomman.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "system/igvm-cfg.h"
+#include "igvm.h"
+#include "qom/object_interfaces.h"
+
+static char *get_igvm(Object *obj, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return g_strdup(igvm->filename);
+}
+
+static void set_igvm(Object *obj, const char *value, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    g_free(igvm->filename);
+    igvm->filename = g_strdup(value);
+}
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
+                                   { TYPE_USER_CREATABLE }, { NULL })
+
+static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
+{
+    IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
+
+    object_class_property_add_str(oc, "file", get_igvm, set_igvm);
+    object_class_property_set_description(oc, "file",
+                                          "Set the IGVM filename to use");
+
+    igvmc->process = qigvm_process_file;
+}
+
+static void igvm_cfg_init(Object *obj)
+{
+}
+
+static void igvm_cfg_finalize(Object *obj)
+{
+}
diff --git a/backends/igvm.c b/backends/igvm.c
new file mode 100644
index 00000000000..2a31021d449
--- /dev/null
+++ b/backends/igvm.c
@@ -0,0 +1,807 @@
+/*
+ * QEMU IGVM configuration backend for guests
+ *
+ * Copyright (C) 2023-2024 SUSE
+ *
+ * Authors:
+ *  Roy Hopkins <roy.hopkins@randomman.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "igvm.h"
+#include "qapi/error.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
+#include "hw/core/cpu.h"
+
+#include <igvm/igvm.h>
+#include <igvm/igvm_defs.h>
+
+typedef struct QIgvmParameterData {
+    QTAILQ_ENTRY(QIgvmParameterData) next;
+    uint8_t *data;
+    uint32_t size;
+    uint32_t index;
+} QIgvmParameterData;
+
+/*
+ * QIgvm contains the information required during processing
+ * of a single IGVM file.
+ */
+typedef struct QIgvm {
+    IgvmHandle file;
+    ConfidentialGuestSupport *cgs;
+    ConfidentialGuestSupportClass *cgsc;
+    uint32_t compatibility_mask;
+    unsigned current_header_index;
+    QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+
+    /* These variables keep track of contiguous page regions */
+    IGVM_VHS_PAGE_DATA region_prev_page_data;
+    uint64_t region_start;
+    unsigned region_start_index;
+    unsigned region_last_index;
+    unsigned region_page_count;
+} QIgvm;
+
+static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
+                                     Error **errp);
+static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp);
+static int qigvm_directive_parameter_area(QIgvm *ctx,
+                                          const uint8_t *header_data,
+                                          Error **errp);
+static int qigvm_directive_parameter_insert(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp);
+static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp);
+static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
+                                    Error **errp);
+static int qigvm_directive_environment_info(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp);
+static int qigvm_directive_required_memory(QIgvm *ctx,
+                                           const uint8_t *header_data,
+                                           Error **errp);
+
+struct QIGVMHandler {
+    uint32_t type;
+    uint32_t section;
+    int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+};
+
+static struct QIGVMHandler handlers[] = {
+    { IGVM_VHT_PAGE_DATA, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_page_data },
+    { IGVM_VHT_VP_CONTEXT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_vp_context },
+    { IGVM_VHT_PARAMETER_AREA, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_parameter_area },
+    { IGVM_VHT_PARAMETER_INSERT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_parameter_insert },
+    { IGVM_VHT_MEMORY_MAP, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_memory_map },
+    { IGVM_VHT_VP_COUNT_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_vp_count },
+    { IGVM_VHT_ENVIRONMENT_INFO_PARAMETER, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_environment_info },
+    { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_required_memory },
+};
+
+static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
+{
+    size_t handler;
+    IgvmHandle header_handle;
+    const uint8_t *header_data;
+    int result;
+
+    for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
+        if (handlers[handler].type != type) {
+            continue;
+        }
+        header_handle = igvm_get_header(ctx->file, handlers[handler].section,
+                                        ctx->current_header_index);
+        if (header_handle < 0) {
+            error_setg(
+                errp,
+                "IGVM file is invalid: Failed to read directive header (code: %d)",
+                (int)header_handle);
+            return -1;
+        }
+        header_data = igvm_get_buffer(ctx->file, header_handle) +
+                      sizeof(IGVM_VHS_VARIABLE_HEADER);
+        result = handlers[handler].handler(ctx, header_data, errp);
+        igvm_free_buffer(ctx->file, header_handle);
+        return result;
+    }
+    error_setg(errp,
+               "IGVM: Unknown header type encountered when processing file: "
+               "(type 0x%X)",
+               type);
+    return -1;
+}
+
+static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
+                                  int region_identifier, Error **errp)
+{
+    ERRP_GUARD();
+    MemoryRegion *igvm_pages = NULL;
+    Int128 gpa_region_size;
+    MemoryRegionSection mrs =
+        memory_region_find(get_system_memory(), addr, size);
+    if (mrs.mr) {
+        if (!memory_region_is_ram(mrs.mr)) {
+            memory_region_unref(mrs.mr);
+            error_setg(
+                errp,
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX due to existing non-RAM region",
+                addr);
+            return NULL;
+        }
+
+        gpa_region_size = int128_make64(size);
+        if (int128_lt(mrs.size, gpa_region_size)) {
+            memory_region_unref(mrs.mr);
+            error_setg(
+                errp,
+                "Processing of IGVM file failed: Could not prepare memory "
+                "at address 0x%lX: region size exceeded",
+                addr);
+            return NULL;
+        }
+        return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+    } else {
+        /*
+         * The region_identifier is the is the index of the IGVM directive that
+         * contains the page with the lowest GPA in the region. This will
+         * generate a unique region name.
+         */
+        g_autofree char *region_name =
+            g_strdup_printf("igvm.%X", region_identifier);
+        igvm_pages = g_new0(MemoryRegion, 1);
+        if (ctx->cgs && ctx->cgs->require_guest_memfd) {
+            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+                                                    region_name, size, errp)) {
+                return NULL;
+            }
+        } else {
+            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+                                        errp)) {
+                return NULL;
+            }
+        }
+        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
+        return memory_region_get_ram_ptr(igvm_pages);
+    }
+}
+
+static int qigvm_type_to_cgs_type(IgvmPageDataType memory_type, bool unmeasured,
+                                  bool zero)
+{
+    switch (memory_type) {
+    case IGVM_PAGE_DATA_TYPE_NORMAL: {
+        if (unmeasured) {
+            return CGS_PAGE_TYPE_UNMEASURED;
+        } else {
+            return zero ? CGS_PAGE_TYPE_ZERO : CGS_PAGE_TYPE_NORMAL;
+        }
+    }
+    case IGVM_PAGE_DATA_TYPE_SECRETS:
+        return CGS_PAGE_TYPE_SECRETS;
+    case IGVM_PAGE_DATA_TYPE_CPUID_DATA:
+        return CGS_PAGE_TYPE_CPUID;
+    case IGVM_PAGE_DATA_TYPE_CPUID_XF:
+        return CGS_PAGE_TYPE_CPUID;
+    default:
+        return -1;
+    }
+}
+
+static bool qigvm_page_attrs_equal(IgvmHandle igvm, unsigned header_index,
+                                   const IGVM_VHS_PAGE_DATA *page_1,
+                                   const IGVM_VHS_PAGE_DATA *page_2)
+{
+    IgvmHandle data_handle1, data_handle2;
+
+    /*
+     * If one page has data and the other doesn't then this results in different
+     * page types: NORMAL vs ZERO.
+     */
+    data_handle1 = igvm_get_header_data(igvm, IGVM_HEADER_SECTION_DIRECTIVE,
+                                        header_index - 1);
+    data_handle2 =
+        igvm_get_header_data(igvm, IGVM_HEADER_SECTION_DIRECTIVE, header_index);
+    if ((data_handle1 == IGVMAPI_NO_DATA ||
+         data_handle2 == IGVMAPI_NO_DATA) &&
+         data_handle1 != data_handle2) {
+        return false;
+    }
+    return ((*(const uint32_t *)&page_1->flags ==
+             *(const uint32_t *)&page_2->flags) &&
+            (page_1->data_type == page_2->data_type) &&
+            (page_1->compatibility_mask == page_2->compatibility_mask));
+}
+
+static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
+                                    uint64_t gpa_start, unsigned page_count,
+                                    const IgvmPageDataFlags *flags,
+                                    const IgvmPageDataType page_type,
+                                    Error **errp)
+{
+    uint8_t *region;
+    IgvmHandle data_handle;
+    const void *data;
+    uint32_t data_size;
+    unsigned page_index;
+    bool zero = true;
+    const uint64_t page_size = flags->is_2mb_page ? 0x200000 : 0x1000;
+    int result;
+    int cgs_page_type;
+
+    region = qigvm_prepare_memory(ctx, gpa_start, page_count * page_size,
+                                  start_index, errp);
+    if (!region) {
+        return -1;
+    }
+
+    for (page_index = 0; page_index < page_count; page_index++) {
+        data_handle = igvm_get_header_data(
+            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + start_index);
+        if (data_handle == IGVMAPI_NO_DATA) {
+            /* No data indicates a zero page */
+            memset(&region[page_index * page_size], 0, page_size);
+        } else if (data_handle < 0) {
+            error_setg(
+                errp,
+                "IGVM file contains invalid page data for directive with "
+                "index %d",
+                page_index + start_index);
+            return -1;
+        } else {
+            zero = false;
+            data_size = igvm_get_buffer_size(ctx->file, data_handle);
+            if (data_size < page_size) {
+                memset(&region[page_index * page_size], 0, page_size);
+            } else if (data_size > page_size) {
+                error_setg(errp,
+                           "IGVM file contains page data with invalid size for "
+                           "directive with index %d",
+                           page_index + start_index);
+                return -1;
+            }
+            data = igvm_get_buffer(ctx->file, data_handle);
+            memcpy(&region[page_index * page_size], data, data_size);
+            igvm_free_buffer(ctx->file, data_handle);
+        }
+    }
+
+    /*
+     * If a confidential guest support object is provided then use it to set the
+     * guest state.
+     */
+    if (ctx->cgs) {
+        cgs_page_type =
+            qigvm_type_to_cgs_type(page_type, flags->unmeasured, zero);
+        if (cgs_page_type < 0) {
+            error_setg(errp,
+                       "Invalid page type in IGVM file. Directives: %d to %d, "
+                       "page type: %d",
+                       start_index, start_index + page_count, page_type);
+            return -1;
+        }
+
+        result = ctx->cgsc->set_guest_state(
+            gpa_start, region, page_size * page_count, cgs_page_type, 0, errp);
+        if (result < 0) {
+            return result;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_process_mem_page(QIgvm *ctx,
+                                  const IGVM_VHS_PAGE_DATA *page_data,
+                                  Error **errp)
+{
+    if (page_data) {
+        if (ctx->region_page_count == 0) {
+            ctx->region_start = page_data->gpa;
+            ctx->region_start_index = ctx->current_header_index;
+        } else {
+            if (!qigvm_page_attrs_equal(ctx->file, ctx->current_header_index,
+                                        page_data,
+                                        &ctx->region_prev_page_data) ||
+                ((ctx->region_prev_page_data.gpa +
+                  (ctx->region_prev_page_data.flags.is_2mb_page ? 0x200000 :
+                                                                  0x1000)) !=
+                 page_data->gpa) ||
+                (ctx->region_last_index != (ctx->current_header_index - 1))) {
+                /* End of current region */
+                if (qigvm_process_mem_region(
+                        ctx, ctx->region_start_index, ctx->region_start,
+                        ctx->region_page_count,
+                        &ctx->region_prev_page_data.flags,
+                        ctx->region_prev_page_data.data_type, errp) < 0) {
+                    return -1;
+                }
+                ctx->region_page_count = 0;
+                ctx->region_start = page_data->gpa;
+                ctx->region_start_index = ctx->current_header_index;
+            }
+        }
+        memcpy(&ctx->region_prev_page_data, page_data,
+               sizeof(ctx->region_prev_page_data));
+        ctx->region_last_index = ctx->current_header_index;
+        ctx->region_page_count++;
+    } else {
+        if (ctx->region_page_count > 0) {
+            if (qigvm_process_mem_region(
+                    ctx, ctx->region_start_index, ctx->region_start,
+                    ctx->region_page_count, &ctx->region_prev_page_data.flags,
+                    ctx->region_prev_page_data.data_type, errp) < 0) {
+                return -1;
+            }
+            ctx->region_page_count = 0;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
+                                     Error **errp)
+{
+    const IGVM_VHS_PAGE_DATA *page_data =
+        (const IGVM_VHS_PAGE_DATA *)header_data;
+    if (page_data->compatibility_mask & ctx->compatibility_mask) {
+        return qigvm_process_mem_page(ctx, page_data, errp);
+    }
+    return 0;
+}
+
+static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp)
+{
+    const IGVM_VHS_VP_CONTEXT *vp_context =
+        (const IGVM_VHS_VP_CONTEXT *)header_data;
+    IgvmHandle data_handle;
+    uint8_t *data;
+    int result;
+
+    if (!(vp_context->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    /*
+     * A confidential guest support object must be provided for setting
+     * a VP context.
+     */
+    if (!ctx->cgs) {
+        error_setg(
+            errp,
+            "A VP context is present in the IGVM file but is not supported "
+            "by the current system.");
+        return -1;
+    }
+
+    data_handle = igvm_get_header_data(ctx->file, IGVM_HEADER_SECTION_DIRECTIVE,
+                                       ctx->current_header_index);
+    if (data_handle < 0) {
+        error_setg(errp, "Invalid VP context in IGVM file. Error code: %X",
+                   data_handle);
+        return -1;
+    }
+
+    data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
+    result = ctx->cgsc->set_guest_state(
+        vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
+        CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
+    igvm_free_buffer(ctx->file, data_handle);
+    if (result < 0) {
+        return result;
+    }
+    return 0;
+}
+
+static int qigvm_directive_parameter_area(QIgvm *ctx,
+                                          const uint8_t *header_data,
+                                          Error **errp)
+{
+    const IGVM_VHS_PARAMETER_AREA *param_area =
+        (const IGVM_VHS_PARAMETER_AREA *)header_data;
+    QIgvmParameterData *param_entry;
+
+    param_entry = g_new0(QIgvmParameterData, 1);
+    param_entry->size = param_area->number_of_bytes;
+    param_entry->index = param_area->parameter_area_index;
+    param_entry->data = g_malloc0(param_entry->size);
+
+    QTAILQ_INSERT_TAIL(&ctx->parameter_data, param_entry, next);
+    return 0;
+}
+
+static int qigvm_directive_parameter_insert(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp)
+{
+    const IGVM_VHS_PARAMETER_INSERT *param =
+        (const IGVM_VHS_PARAMETER_INSERT *)header_data;
+    QIgvmParameterData *param_entry;
+    int result;
+    void *region;
+
+    if (!(param->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
+                                          ctx->current_header_index, errp);
+            if (!region) {
+                return -1;
+            }
+            memcpy(region, param_entry->data, param_entry->size);
+            g_free(param_entry->data);
+            param_entry->data = NULL;
+
+            /*
+             * If a confidential guest support object is provided then use it to
+             * set the guest state.
+             */
+            if (ctx->cgs) {
+                result = ctx->cgsc->set_guest_state(param->gpa, region,
+                                                    param_entry->size,
+                                                    CGS_PAGE_TYPE_UNMEASURED, 0,
+                                                    errp);
+                if (result < 0) {
+                    return -1;
+                }
+            }
+        }
+    }
+    return 0;
+}
+
+static int qigvm_cmp_mm_entry(const void *a, const void *b)
+{
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_a =
+        (const IGVM_VHS_MEMORY_MAP_ENTRY *)a;
+    const IGVM_VHS_MEMORY_MAP_ENTRY *entry_b =
+        (const IGVM_VHS_MEMORY_MAP_ENTRY *)b;
+    if (entry_a->starting_gpa_page_number < entry_b->starting_gpa_page_number) {
+        return -1;
+    } else if (entry_a->starting_gpa_page_number >
+               entry_b->starting_gpa_page_number) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
+                                      Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    int max_entry_count;
+    int entry = 0;
+    IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
+    ConfidentialGuestMemoryMapEntry cgmm_entry;
+    int retval = 0;
+
+    if (!ctx->cgs) {
+        error_setg(errp,
+                   "IGVM file contains a memory map but this is not supported "
+                   "by the current system.");
+        return -1;
+    }
+
+    /* Find the parameter area that should hold the memory map */
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            max_entry_count =
+                param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+            mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+
+            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
+            while (retval == 0) {
+                if (entry > max_entry_count) {
+                    error_setg(
+                        errp,
+                        "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
+                    return -1;
+                }
+                mm_entry[entry].starting_gpa_page_number = cgmm_entry.gpa >> 12;
+                mm_entry[entry].number_of_pages = cgmm_entry.size >> 12;
+
+                switch (cgmm_entry.type) {
+                case CGS_MEM_RAM:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_MEMORY;
+                    break;
+                case CGS_MEM_RESERVED:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_ACPI:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                case CGS_MEM_NVS:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PERSISTENT;
+                    break;
+                case CGS_MEM_UNUSABLE:
+                    mm_entry[entry].entry_type =
+                        IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
+                    break;
+                }
+                retval =
+                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
+            }
+            if (retval < 0) {
+                return retval;
+            }
+            /* The entries need to be sorted */
+            qsort(mm_entry, entry, sizeof(IGVM_VHS_MEMORY_MAP_ENTRY),
+                  qigvm_cmp_mm_entry);
+
+            break;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
+                                    Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    uint32_t *vp_count;
+    CPUState *cpu;
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
+            *vp_count = 0;
+            CPU_FOREACH(cpu)
+            {
+                (*vp_count)++;
+            }
+            break;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_environment_info(QIgvm *ctx,
+                                            const uint8_t *header_data,
+                                            Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    IgvmEnvironmentInfo *environmental_state;
+
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+            environmental_state =
+                (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+            environmental_state->memory_is_shared = 1;
+            break;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_directive_required_memory(QIgvm *ctx,
+                                           const uint8_t *header_data,
+                                           Error **errp)
+{
+    const IGVM_VHS_REQUIRED_MEMORY *mem =
+        (const IGVM_VHS_REQUIRED_MEMORY *)header_data;
+    uint8_t *region;
+    int result;
+
+    if (!(mem->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    region = qigvm_prepare_memory(ctx, mem->gpa, mem->number_of_bytes,
+                                  ctx->current_header_index, errp);
+    if (!region) {
+        return -1;
+    }
+    if (ctx->cgs) {
+        result =
+            ctx->cgsc->set_guest_state(mem->gpa, region, mem->number_of_bytes,
+                                       CGS_PAGE_TYPE_REQUIRED_MEMORY, 0, errp);
+        if (result < 0) {
+            return result;
+        }
+    }
+    return 0;
+}
+
+static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
+{
+    int32_t header_count;
+    unsigned header_index;
+    IgvmHandle header_handle;
+    IGVM_VHS_SUPPORTED_PLATFORM *platform;
+    uint32_t compatibility_mask_sev = 0;
+    uint32_t compatibility_mask_sev_es = 0;
+    uint32_t compatibility_mask_sev_snp = 0;
+    uint32_t compatibility_mask = 0;
+
+    header_count = igvm_header_count(ctx->file, IGVM_HEADER_SECTION_PLATFORM);
+    if (header_count < 0) {
+        error_setg(errp,
+                   "Invalid platform header count in IGVM file. Error code: %X",
+                   header_count);
+        return -1;
+    }
+
+    for (header_index = 0; header_index < (unsigned)header_count;
+         header_index++) {
+        IgvmVariableHeaderType typ = igvm_get_header_type(
+            ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
+            header_handle = igvm_get_header(
+                ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+            if (header_handle < 0) {
+                error_setg(errp,
+                           "Invalid platform header in IGVM file. "
+                           "Index: %d, Error code: %X",
+                           header_index, header_handle);
+                return -1;
+            }
+            platform =
+                (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
+                                                                header_handle) +
+                                                sizeof(
+                                                    IGVM_VHS_VARIABLE_HEADER));
+            if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
+                ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV_ES, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev_es = platform->compatibility_mask;
+                }
+            } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
+                       ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev = platform->compatibility_mask;
+                }
+            } else if ((platform->platform_type ==
+                        IGVM_PLATFORM_TYPE_SEV_SNP) &&
+                       ctx->cgs) {
+                if (ctx->cgsc->check_support(
+                        CGS_PLATFORM_SEV_SNP, platform->platform_version,
+                        platform->highest_vtl, platform->shared_gpa_boundary)) {
+                    compatibility_mask_sev_snp = platform->compatibility_mask;
+                }
+            } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
+                compatibility_mask = platform->compatibility_mask;
+            }
+            igvm_free_buffer(ctx->file, header_handle);
+        }
+    }
+    /* Choose the strongest supported isolation technology */
+    if (compatibility_mask_sev_snp != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev_snp;
+    } else if (compatibility_mask_sev_es != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev_es;
+    } else if (compatibility_mask_sev != 0) {
+        ctx->compatibility_mask = compatibility_mask_sev;
+    } else if (compatibility_mask != 0) {
+        ctx->compatibility_mask = compatibility_mask;
+    } else {
+        error_setg(
+            errp,
+            "IGVM file does not describe a compatible supported platform");
+        return -1;
+    }
+    return 0;
+}
+
+static IgvmHandle qigvm_file_init(char *filename, Error **errp)
+{
+    IgvmHandle igvm;
+    g_autofree uint8_t *buf = NULL;
+    unsigned long len;
+    g_autoptr(GError) gerr = NULL;
+
+    if (!g_file_get_contents(filename, (gchar **)&buf, &len, &gerr)) {
+        error_setg(errp, "Unable to load %s: %s", filename, gerr->message);
+        return -1;
+    }
+
+    igvm = igvm_new_from_binary(buf, len);
+    if (igvm < 0) {
+        error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
+        return -1;
+    }
+    return igvm;
+}
+
+int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+                       Error **errp)
+{
+    int32_t header_count;
+    QIgvmParameterData *parameter;
+    int retval = -1;
+    QIgvm ctx;
+
+    memset(&ctx, 0, sizeof(ctx));
+    ctx.file = qigvm_file_init(cfg->filename, errp);
+    if (ctx.file < 0) {
+        return -1;
+    }
+
+    /*
+     * The ConfidentialGuestSupport object is optional and allows a confidential
+     * guest platform to perform extra processing, such as page measurement, on
+     * IGVM directives.
+     */
+    ctx.cgs = cgs;
+    ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
+
+    /*
+     * Check that the IGVM file provides configuration for the current
+     * platform
+     */
+    if (qigvm_supported_platform_compat_mask(&ctx, errp) < 0) {
+        goto cleanup;
+    }
+
+    header_count = igvm_header_count(ctx.file, IGVM_HEADER_SECTION_DIRECTIVE);
+    if (header_count <= 0) {
+        error_setg(
+            errp, "Invalid directive header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup;
+    }
+
+    QTAILQ_INIT(&ctx.parameter_data);
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type = igvm_get_header_type(
+            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup_parameters;
+        }
+    }
+
+    /*
+     * Contiguous pages of data with compatible flags are grouped together in
+     * order to reduce the number of memory regions we create. Make sure the
+     * last group is processed with this call.
+     */
+    retval = qigvm_process_mem_page(&ctx, NULL, errp);
+
+cleanup_parameters:
+    QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
+    {
+        g_free(parameter->data);
+        parameter->data = NULL;
+    }
+
+cleanup:
+    igvm_free(ctx.file);
+
+    return retval;
+}
diff --git a/backends/meson.build b/backends/meson.build
index ac0fac78458..60021f45d12 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -36,6 +36,8 @@ system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 if igvm.found()
   system_ss.add(igvm)
+  system_ss.add(files('igvm-cfg.c'), igvm)
+  system_ss.add(files('igvm.c'), igvm)
 endif
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
-- 
2.50.0


