Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D167099E2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Ab-0007iE-Bs; Fri, 19 May 2023 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01AX-0007gt-1J
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:33:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01AV-00007B-4Z
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:33:20 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN8RK4TxKz67R01;
 Fri, 19 May 2023 22:31:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 15:33:16 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric
 Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Subject: [PATCH v6 5/7] hw/cxl/events: Add injection of General Media Events
Date: Fri, 19 May 2023 15:30:41 +0100
Message-ID: <20230519143043.30191-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Ira Weiny <ira.weiny@intel.com>

To facilitate testing provide a QMP command to inject a general media
event.  The event can be added to the log specified.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  10 ++++
 include/hw/cxl/cxl_events.h |  20 +++++++
 qapi/cxl.json               |  50 ++++++++++++++++
 4 files changed, 191 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a51b32afe0..d5fd3ccbc1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1181,6 +1181,117 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
+static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                                    const QemuUUID *uuid, uint32_t flags,
+                                    uint8_t length, uint64_t timestamp)
+{
+    st24_le_p(&hdr->flags, flags);
+    hdr->length = length;
+    memcpy(&hdr->id, uuid, sizeof(hdr->id));
+    stq_le_p(&hdr->timestamp, timestamp);
+}
+
+static const QemuUUID gen_media_uuid = {
+    .data = UUID(0xfbcd0a77, 0xc260, 0x417f,
+                 0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+};
+
+#define CXL_GMER_VALID_CHANNEL                          BIT(0)
+#define CXL_GMER_VALID_RANK                             BIT(1)
+#define CXL_GMER_VALID_DEVICE                           BIT(2)
+#define CXL_GMER_VALID_COMPONENT                        BIT(3)
+
+static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
+{
+    switch (log) {
+    case CXL_EVENT_LOG_INFORMATIONAL:
+        return CXL_EVENT_TYPE_INFO;
+    case CXL_EVENT_LOG_WARNING:
+        return CXL_EVENT_TYPE_WARN;
+    case CXL_EVENT_LOG_FAILURE:
+        return CXL_EVENT_TYPE_FAIL;
+    case CXL_EVENT_LOG_FATAL:
+        return CXL_EVENT_TYPE_FATAL;
+/* DCD not yet supported */
+    default:
+        return -EINVAL;
+    }
+}
+/* Component ID is device specific.  Define this as a string. */
+void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
+                                    uint8_t flags, uint64_t physaddr,
+                                    uint8_t descriptor, uint8_t type,
+                                    uint8_t transaction_type,
+                                    bool has_channel, uint8_t channel,
+                                    bool has_rank, uint8_t rank,
+                                    bool has_device, uint32_t device,
+                                    const char *component_id,
+                                    Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventGenMedia gem;
+    CXLEventRecordHdr *hdr = &gem.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
+    uint16_t valid_flags = 0;
+    uint8_t enc_log;
+    int rc;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+        return;
+    }
+    ct3d = CXL_TYPE3(obj);
+    cxlds = &ct3d->cxl_dstate;
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    memset(&gem, 0, sizeof(gem));
+    cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+
+    stq_le_p(&gem.phys_addr, physaddr);
+    gem.descriptor = descriptor;
+    gem.type = type;
+    gem.transaction_type = transaction_type;
+
+    if (has_channel) {
+        gem.channel = channel;
+        valid_flags |= CXL_GMER_VALID_CHANNEL;
+    }
+
+    if (has_rank) {
+        gem.rank = rank;
+        valid_flags |= CXL_GMER_VALID_RANK;
+    }
+
+    if (has_device) {
+        st24_le_p(gem.device, device);
+        valid_flags |= CXL_GMER_VALID_DEVICE;
+    }
+
+    if (component_id) {
+        strncpy((char *)gem.component_id, component_id,
+                sizeof(gem.component_id) - 1);
+        valid_flags |= CXL_GMER_VALID_COMPONENT;
+    }
+
+    stw_le_p(&gem.validity_flags, valid_flags);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index fd1166a610..55d19b0e03 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -3,6 +3,16 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-cxl.h"
 
+void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
+                                    uint8_t flags, uint64_t physaddr,
+                                    uint8_t descriptor, uint8_t type,
+                                    uint8_t transaction_type,
+                                    bool has_channel, uint8_t channel,
+                                    bool has_rank, uint8_t rank,
+                                    bool has_device, uint32_t device,
+                                    const char *component_id,
+                                    Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4bf8b7aa08..b189193f4c 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -103,4 +103,24 @@ typedef struct CXLEventInterruptPolicy {
 /* DCD is optional but other fields are not */
 #define CXL_EVENT_INT_SETTING_MIN_LEN 4
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE  0x10
+#define CXL_EVENT_GEN_MED_RES_SIZE      0x2e
+typedef struct CXLEventGenMedia {
+    CXLEventRecordHdr hdr;
+    uint64_t phys_addr;
+    uint8_t descriptor;
+    uint8_t type;
+    uint8_t transaction_type;
+    uint16_t validity_flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t device[3];
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
+} QEMU_PACKED CXLEventGenMedia;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index dcf9e7b715..7e1e6257ce 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -5,6 +5,56 @@
 # = CXL devices
 ##
 
+##
+# @CxlEventLog:
+#
+# CXL has a number of separate event logs for different types of event.
+# Each such event log is handled and signaled independently.
+#
+# @informational: Information Event Log
+# @warning: Warning Event Log
+# @failure: Failure Event Log
+# @fatal: Fatal Event Log
+#
+# Since: 8.1
+##
+{ 'enum': 'CxlEventLog',
+  'data': ['informational',
+           'warning',
+           'failure',
+           'fatal'
+           ]
+ }
+
+##
+# @cxl-inject-gen-media-event:
+#
+# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.1.1)
+# This event type is reported via one of the event logs specified via
+# the log parameter.
+#
+# @path: CXL type 3 device canonical QOM path
+# @log: Event Log to add the event to
+# @flags: header flags
+# @physaddr: Physical Address
+# @descriptor: Descriptor
+# @type: Type
+# @transaction-type: Transaction Type
+# @channel: Channel
+# @rank: Rank
+# @device: Device
+# @component-id: Device specific string
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-gen-media-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'physaddr': 'uint64', 'descriptor': 'uint8',
+            'type': 'uint8', 'transaction-type': 'uint8',
+            '*channel': 'uint8', '*rank': 'uint8',
+            '*device': 'uint32', '*component-id': 'str'
+            }}
+
 ##
 # @cxl-inject-poison:
 #
-- 
2.39.2


