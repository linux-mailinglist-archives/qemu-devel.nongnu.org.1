Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F234070C217
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17DO-0000if-33; Mon, 22 May 2023 11:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q17DD-0000gw-7L
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:12:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q17Cy-0005IS-Hm
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:12:38 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ1601Wm6z6J6y2;
 Mon, 22 May 2023 23:07:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:12:19 +0100
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
Subject: [PATCH v7 5/7] hw/cxl/events: Add injection of General Media Events
Date: Mon, 22 May 2023 16:09:45 +0100
Message-ID: <20230522150947.11546-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
v7: Various docs updates and field renames including a lot more
    specification references.
---
 qapi/cxl.json               |  79 +++++++++++++++++++++++++
 include/hw/cxl/cxl_events.h |  20 +++++++
 hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  10 ++++
 4 files changed, 220 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 4849fca776..7700e26a0d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -5,6 +5,85 @@
 # = CXL devices
 ##
 
+##
+# @CxlEventLog:
+#
+# CXL has a number of separate event logs for different types of
+# events. Each such event log is handled and signaled independently.
+#
+# @informational: Information Event Log
+#
+# @warning: Warning Event Log
+#
+# @failure: Failure Event Log
+#
+# @fatal: Fatal Event Log
+#
+# Since: 8.1
+##
+{ 'enum': 'CxlEventLog',
+  'data': ['informational',
+           'warning',
+           'failure',
+           'fatal']
+ }
+
+##
+# @cxl-inject-general-media-event:
+#
+# Inject an event record for a General Media Event (CXL r3.0
+# 8.2.9.2.1.1) This event type is reported via one of the event logs
+# specified via the log parameter.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @log: event log to add the event to
+#
+# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
+#         Record Format, Event Record Flags for subfield definitions.
+#
+# @dpa: Device Physical Address (relative to @path device). Note lower
+#       bits include some flags. See CXL r3.0 Table 8-43 General Media
+#       Event Record, Physical Address.
+#
+# @descriptor: Memory Event Descriptor with additional memory
+#              event information. See CXL r3.0 Table 8-43 General
+#              Media Event Record, Memory Event Descriptor for bit
+#              definitions.
+#
+# @type: Type of memory event that occurred. See CXL r3.0 Table 8-43
+#        General Media Event Record, Memory Event Type for possible
+#        values.
+#
+# @transaction-type: Type of first transaction that caused the event
+#                    to occur. See CXL r3.0 Table 8-43 General Media
+#                    Event Record, Transaction Type for possible
+#                    values.
+#
+# @channel: The channel of the memory event location. A channel is
+#           an interface that can be independently accessed for a
+#           transaction.
+#
+# @rank: The rank of the memory event location. A rank is a set of
+#        memory devices on a channel that together execute a
+#        transaction.
+#
+# @device: Bitmask that represents all devices in the rank associated
+#          with the memory event location.
+#
+# @component-id: Device specific component identifier for the event.
+#                May describe a field replaceable sub-component of
+#                the device.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-general-media-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'dpa': 'uint64', 'descriptor': 'uint8',
+            'type': 'uint8', 'transaction-type': 'uint8',
+            '*channel': 'uint8', '*rank': 'uint8',
+            '*device': 'uint32', '*component-id': 'str' } }
+
 ##
 # @cxl-inject-poison:
 #
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
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c9e347f42b..b1618779d2 100644
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
+void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t descriptor, uint8_t type,
+                                        uint8_t transaction_type,
+                                        bool has_channel, uint8_t channel,
+                                        bool has_rank, uint8_t rank,
+                                        bool has_device, uint32_t device,
+                                        const char *component_id,
+                                        Error **errp)
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
+    stq_le_p(&gem.phys_addr, dpa);
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
index fd1166a610..4dfbdf9268 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -3,6 +3,16 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-cxl.h"
 
+void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t descriptor, uint8_t type,
+                                        uint8_t transaction_type,
+                                        bool has_channel, uint8_t channel,
+                                        bool has_rank, uint8_t rank,
+                                        bool has_device, uint32_t device,
+                                        const char *component_id,
+                                        Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
-- 
2.39.2


