Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A4BE876B
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 13:53:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9iyl-0002KO-DM; Fri, 17 Oct 2025 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v9iyj-0002K8-92
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v9iyT-00083G-PF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 07:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760701813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYOmRh2ROhzTS8H4L2zP8hXLuDXYcX/0dVeN/Hriucc=;
 b=hhv4Q4wW3VIPsLsUcUpY8JF4Gmiraln4x/Xjcu6yS9zPqzXjRotWl2yhpxVmikSIHmVuWj
 gE/ejC2m46HU8amCNoxmAj0KvjRzNcrnx+gCB7ImZDOfHMPKBt8C1vsNKqLLPIcX0fwrW/
 tg6KOtRulrTWpBHgN3fRonTVzZvHwkU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-EqStJ8DQOJmby2zarA9-6w-1; Fri,
 17 Oct 2025 07:50:11 -0400
X-MC-Unique: EqStJ8DQOJmby2zarA9-6w-1
X-Mimecast-MFC-AGG-ID: EqStJ8DQOJmby2zarA9-6w_1760701810
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E19A1800365; Fri, 17 Oct 2025 11:50:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D9B730001BC; Fri, 17 Oct 2025 11:50:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 308FF18000B5; Fri, 17 Oct 2025 13:50:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v6 1/3] hw/uefi: add query-firmware-log monitor command
Date: Fri, 17 Oct 2025 13:50:03 +0200
Message-ID: <20251017115006.2696991-2-kraxel@redhat.com>
In-Reply-To: <20251017115006.2696991-1-kraxel@redhat.com>
References: <20251017115006.2696991-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
optional support for logging to a memory buffer.  There is guest side
support -- for example in linux kernels v6.17+ -- to read that buffer.
But that might not helpful if your guest stops booting early enough that
guest tooling can not be used yet.  So host side support to read that
log buffer is a useful thing to have.

This patch implements the query-firmware-log qmp monitor command to
read the firmware log.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/ovmf-log.c         | 233 +++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |   2 +
 hw/uefi/meson.build        |   2 +-
 qapi/machine.json          |  24 ++++
 4 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/ovmf-log.c

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
new file mode 100644
index 000000000000..0d4bd503a06a
--- /dev/null
+++ b/hw/uefi/ovmf-log.c
@@ -0,0 +1,233 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * print ovmf debug log
+ *
+ * see OvmfPkg/Library/MemDebugLogLib/ in edk2
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/target-info-qapi.h"
+#include "hw/boards.h"
+#include "hw/i386/x86.h"
+#include "hw/arm/virt.h"
+#include "system/dma.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
+#include "qapi/type-helpers.h"
+#include "qapi/qapi-commands-machine.h"
+
+
+/* ----------------------------------------------------------------------- */
+/* copy from edk2                                                          */
+
+#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  /* "ovmfmdg1" */
+#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  /* "ovmfmdg2" */
+
+/*
+ * Mem Debug Log buffer header.
+ * The Log buffer is circular. Only the most
+ * recent messages are retained. Older messages
+ * will be discarded if the buffer overflows.
+ * The Debug Log starts just after the header.
+ */
+typedef struct {
+    /*
+     * Magic values
+     * These fields are used by tools to locate the buffer in
+     * memory. These MUST be the first two fields of the structure.
+     * Use a 128 bit Magic to vastly reduce the possibility of
+     * a collision with random data in memory.
+     */
+    uint64_t             Magic1;
+    uint64_t             Magic2;
+    /*
+     * Header Size
+     * This MUST be the third field of the structure
+     */
+    uint64_t             HeaderSize;
+    /*
+     * Debug log size (minus header)
+     */
+    uint64_t             DebugLogSize;
+    /*
+     * edk2 uses this for locking access.
+     */
+    uint64_t             MemDebugLogLock;
+    /*
+     * Debug log head offset
+     */
+    uint64_t             DebugLogHeadOffset;
+    /*
+     *  Debug log tail offset
+     */
+    uint64_t             DebugLogTailOffset;
+    /*
+     * Flag to indicate if the buffer wrapped and was thus truncated.
+     */
+    uint64_t             Truncated;
+    /*
+     * Firmware Build Version (PcdFirmwareVersionString)
+     */
+    char                 FirmwareVersion[128];
+} MEM_DEBUG_LOG_HDR;
+
+
+/* ----------------------------------------------------------------------- */
+/* qemu monitor command                                                    */
+
+typedef struct {
+    uint64_t             magic1;
+    uint64_t             magic2;
+} MemDebugLogMagic;
+
+/* find log buffer in guest memory by searching for the magic cookie */
+static dma_addr_t find_ovmf_log_range(dma_addr_t start, dma_addr_t end)
+{
+    static const MemDebugLogMagic magic = {
+        .magic1 = MEM_DEBUG_LOG_MAGIC1,
+        .magic2 = MEM_DEBUG_LOG_MAGIC2,
+    };
+    MemDebugLogMagic check;
+    dma_addr_t step = 4 * KiB;
+    dma_addr_t offset;
+
+    for (offset = start; offset < end; offset += step) {
+        if (dma_memory_read(&address_space_memory, offset,
+                            &check, sizeof(check),
+                            MEMTXATTRS_UNSPECIFIED)) {
+            /* dma error -> stop searching */
+            break;
+        }
+        if (memcmp(&magic, &check, sizeof(check)) == 0) {
+            return offset;
+        }
+    }
+    return (dma_addr_t)-1;
+}
+
+static dma_addr_t find_ovmf_log(void)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    dma_addr_t start, end, offset;
+
+    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
+        X86MachineState *x86ms = X86_MACHINE(ms);
+
+        /* early log buffer, static allocation in memfd, sec + early pei */
+        offset = find_ovmf_log_range(0x800000, 0x900000);
+        if (offset != -1) {
+            return offset;
+        }
+
+        /*
+         * normal log buffer, dynamically allocated close to end of low memory,
+         * late pei + dxe phase
+         */
+        end = x86ms->below_4g_mem_size;
+        start = end - MIN(end, 128 * MiB);
+        return find_ovmf_log_range(start, end);
+    }
+
+    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
+        object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
+        VirtMachineState *vms = VIRT_MACHINE(ms);
+
+        /* edk2 ArmVirt firmware allocations are in the first 128 MB */
+        start = vms->memmap[VIRT_MEM].base;
+        end = start + 128 * MiB;
+        return find_ovmf_log_range(start, end);
+    }
+
+    return (dma_addr_t)-1;
+}
+
+static void handle_ovmf_log_range(GString *out,
+                                  dma_addr_t start,
+                                  dma_addr_t end,
+                                  Error **errp)
+{
+    if (start > end) {
+        return;
+    }
+
+    size_t len = end - start;
+    g_string_set_size(out, out->len + len);
+    if (dma_memory_read(&address_space_memory, start,
+                        out->str + (out->len - len),
+                        len, MEMTXATTRS_UNSPECIFIED)) {
+        error_setg(errp, "can not read firmware log buffer contents");
+        return;
+    }
+}
+
+FirmwareLog *qmp_query_firmware_log(Error **errp)
+{
+    MEM_DEBUG_LOG_HDR header;
+    dma_addr_t offset, base;
+    FirmwareLog *ret;
+    g_autoptr(GString) log = g_string_new("");
+
+    offset = find_ovmf_log();
+    if (offset == -1) {
+        error_setg(errp, "firmware log buffer not found");
+        return NULL;
+    }
+
+    if (dma_memory_read(&address_space_memory, offset,
+                        &header, sizeof(header),
+                        MEMTXATTRS_UNSPECIFIED)) {
+        error_setg(errp, "can not read firmware log buffer header");
+        return NULL;
+    }
+
+    if (header.DebugLogSize > MiB) {
+        /* default size is 128k (32 pages), allow up to 1M */
+        error_setg(errp, "firmware log: log buffer is too big");
+        return NULL;
+    }
+
+    if (header.DebugLogHeadOffset > header.DebugLogSize ||
+        header.DebugLogTailOffset > header.DebugLogSize) {
+        error_setg(errp, "firmware log buffer header is invalid");
+        return NULL;
+    }
+
+    base = offset + header.HeaderSize;
+    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
+        /* wrap around */
+        handle_ovmf_log_range(log,
+                              base + header.DebugLogHeadOffset,
+                              base + header.DebugLogSize,
+                              errp);
+        if (*errp) {
+            return NULL;
+        }
+        handle_ovmf_log_range(log,
+                              base + 0,
+                              base + header.DebugLogTailOffset,
+                              errp);
+        if (*errp) {
+            return NULL;
+        }
+    } else {
+        handle_ovmf_log_range(log,
+                              base + header.DebugLogHeadOffset,
+                              base + header.DebugLogTailOffset,
+                              errp);
+        if (*errp) {
+            return NULL;
+        }
+    }
+
+    ret = g_new0(FirmwareLog, 1);
+    if (header.FirmwareVersion[0] != '\0') {
+        ret->version = g_strndup(header.FirmwareVersion,
+                                 sizeof(header.FirmwareVersion));
+    }
+    ret->log = g_base64_encode((const guchar *)log->str, log->len);
+    return ret;
+}
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index cf718761861d..279a8f5614e9 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -52,6 +52,8 @@ static int query_error_class(const char *cmd)
         /* Only valid with accel=tcg */
         { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
         { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
+        /* requires firmware with memory buffer logging support */
+        { "query-firmware-log", ERROR_CLASS_GENERIC_ERROR },
         { NULL, -1 }
     };
     int i;
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index 91eb95f89e6d..c8f38dfae247 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -1,4 +1,4 @@
-system_ss.add(files('hardware-info.c'))
+system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
 
 uefi_vars_ss = ss.source_set()
 if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
diff --git a/qapi/machine.json b/qapi/machine.json
index 038eab281c78..96133e5c71cf 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1839,6 +1839,30 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
 
+##
+# @FirmwareLog:
+#
+# @version: Firmware version.
+#
+# @log: Firmware debug log, in base64 encoding.  First and last log
+#       line might be incomplete.
+#
+# Since: 10.2
+##
+{ 'struct': 'FirmwareLog',
+  'data': { '*version': 'str',
+            'log': 'str' } }
+
+##
+# @query-firmware-log:
+#
+# Find firmware memory log buffer in guest memory, return content.
+#
+# Since: 10.2
+##
+{ 'command': 'query-firmware-log',
+  'returns': 'FirmwareLog' }
+
 ##
 # @dump-skeys:
 #
-- 
2.51.0


