Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A6BDE412
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 13:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zbz-00005O-RJ; Wed, 15 Oct 2025 07:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbw-0008VF-VW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8zbm-0003Dl-Mw
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760527431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caWGUGGM/k4ZIcTosCRU7rf8W+938SnhmMAenF+SXSI=;
 b=B2PYUozcfixyk6/nxq/8zf4MHPMSi2lldYFoUV9NpitsIZQWq5sORLJEpJVDN/0Z2CT2Ml
 Tn4nV/d3NI5wllmm+FeTBlnzjN6RSc6pr6gmOh5VWkyvRLBTyAey3aCTFqv0khFibVs2Vo
 hAR2b1z464t+8UK9dCVv+GVbCDD0fK0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-FeA9kQQEPwCstWkvEK23dw-1; Wed,
 15 Oct 2025 07:23:49 -0400
X-MC-Unique: FeA9kQQEPwCstWkvEK23dw-1
X-Mimecast-MFC-AGG-ID: FeA9kQQEPwCstWkvEK23dw_1760527428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD60119560A2; Wed, 15 Oct 2025 11:23:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91FD41800446; Wed, 15 Oct 2025 11:23:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF041180099A; Wed, 15 Oct 2025 13:23:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 2/5] igvm: add support for igvm memory map parameter in
 native mode
Date: Wed, 15 Oct 2025 13:23:39 +0200
Message-ID: <20251015112342.1672955-3-kraxel@redhat.com>
In-Reply-To: <20251015112342.1672955-1-kraxel@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Add and wire up qigvm_x86_get_mem_map_entry function which converts the
e820 table into an igvm memory map parameter.  This makes igvm files for
the native (non-confidential) platform with memory map parameter work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm.h   |  5 +++++
 backends/igvm.c         | 18 ++++++++++++----
 stubs/igvm.c            | 21 +++++++++++++++++++
 target/i386/igvm.c      | 46 +++++++++++++++++++++++++++++++++++++++++
 stubs/meson.build       |  1 +
 target/i386/meson.build |  3 +++
 6 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 stubs/igvm.c
 create mode 100644 target/i386/igvm.c

diff --git a/include/system/igvm.h b/include/system/igvm.h
index a4abab043a1f..3f72a40b8897 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -19,4 +19,9 @@
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
                       bool onlyVpContext, Error **errp);
 
+/* x86 native */
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp);
+
 #endif
diff --git a/backends/igvm.c b/backends/igvm.c
index 723d45b755a0..e949c81abb9a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
@@ -543,6 +544,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                                       Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp) = NULL;
     QIgvmParameterData *param_entry;
     int max_entry_count;
     int entry = 0;
@@ -550,7 +553,15 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     ConfidentialGuestMemoryMapEntry cgmm_entry;
     int retval = 0;
 
-    if (!ctx->cgs) {
+    if (ctx->cgs && ctx->cgsc->get_mem_map_entry) {
+        get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
+    }
+
+    if (!get_mem_map_entry && target_arch() == SYS_EMU_TARGET_X86_64) {
+        get_mem_map_entry = qigvm_x86_get_mem_map_entry;
+    }
+
+    if (!get_mem_map_entry) {
         error_setg(errp,
                    "IGVM file contains a memory map but this is not supported "
                    "by the current system.");
@@ -565,7 +576,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                 param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
             mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
 
-            retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
+            retval = get_mem_map_entry(entry, &cgmm_entry, errp);
             while (retval == 0) {
                 if (entry > max_entry_count) {
                     error_setg(
@@ -598,8 +609,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
                         IGVM_MEMORY_MAP_ENTRY_TYPE_PLATFORM_RESERVED;
                     break;
                 }
-                retval =
-                    ctx->cgsc->get_mem_map_entry(++entry, &cgmm_entry, errp);
+                retval = get_mem_map_entry(++entry, &cgmm_entry, errp);
             }
             if (retval < 0) {
                 return retval;
diff --git a/stubs/igvm.c b/stubs/igvm.c
new file mode 100644
index 000000000000..c32058eb2a6e
--- /dev/null
+++ b/stubs/igvm.c
@@ -0,0 +1,21 @@
+/*
+ * QEMU IGVM, stubs
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "system/igvm.h"
+
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
new file mode 100644
index 000000000000..2ed6cd052c79
--- /dev/null
+++ b/target/i386/igvm.c
@@ -0,0 +1,46 @@
+/*
+ * QEMU IGVM, support for native x86 guests
+ *
+ * Copyright (C) 2026 Red Hat
+ *
+ * Authors:
+ *  Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/i386/e820_memory_layout.h"
+#include "system/igvm.h"
+
+/*
+ * convert e820 table into igvm memory map
+ */
+int qigvm_x86_get_mem_map_entry(int index,
+                                ConfidentialGuestMemoryMapEntry *entry,
+                                Error **errp)
+{
+    struct e820_entry *table;
+    int num_entries;
+
+    num_entries = e820_get_table(&table);
+    if ((index < 0) || (index >= num_entries)) {
+        return 1;
+    }
+    entry->gpa = table[index].address;
+    entry->size = table[index].length;
+    switch (table[index].type) {
+    case E820_RAM:
+        entry->type = CGS_MEM_RAM;
+        break;
+    case E820_RESERVED:
+        entry->type = CGS_MEM_RESERVED;
+        break;
+    default:
+        /* should not happen */
+        error_setg(errp, "unknown e820 type");
+        return -1;
+    }
+    return 0;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 5d577467bfdd..27be2dec9f9e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,6 +74,7 @@ if have_system
   stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
+  stub_ss.add(files('igvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 89ba4912aaeb..d385eafdf7e1 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -26,6 +26,9 @@ i386_system_ss.add(files(
 ))
 i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'),
                                        if_false: files('sev-system-stub.c'))
+if igvm.found()
+  i386_system_ss.add(files('igvm.c'))
+endif
 
 i386_user_ss = ss.source_set()
 
-- 
2.51.0


