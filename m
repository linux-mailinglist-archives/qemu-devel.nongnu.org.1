Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E9F7099E6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01BZ-0000j5-1P; Fri, 19 May 2023 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01BX-0000ib-D5
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:34:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q01BU-0000Mb-AN
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:34:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN8Pd6Lpvz6J7HT;
 Fri, 19 May 2023 22:29:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 15:34:17 +0100
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
Subject: [PATCH v6 7/7] hw/cxl/events: Add injection of Memory Module Events
Date: Fri, 19 May 2023 15:30:43 +0100
Message-ID: <20230519143043.30191-8-Jonathan.Cameron@huawei.com>
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

These events include a copy of the device health information at the
time of the event. Actually using the emulated device health would
require a lot of controls to manipulate that state.  Given the aim
of this injection code is to just test the flows when events occur,
inject the contents of the device health state as well.

Future work may add more sophisticate device health emulation
including direct generation of these records when events occur
(such as a temperature threshold being crossed).  That does not
reduce the usefulness of this more basic generation of the events.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

 hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    | 12 +++++++
 include/hw/cxl/cxl_events.h | 19 ++++++++++++
 qapi/cxl.json               | 35 +++++++++++++++++++++
 4 files changed, 128 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0353425b17..34eac58b48 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1201,6 +1201,11 @@ static const QemuUUID dram_uuid = {
                  0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
 };
 
+static const QemuUUID memory_module_uuid = {
+    .data = UUID(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86,
+                 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+};
+
 #define CXL_GMER_VALID_CHANNEL                          BIT(0)
 #define CXL_GMER_VALID_RANK                             BIT(1)
 #define CXL_GMER_VALID_DEVICE                           BIT(2)
@@ -1408,6 +1413,63 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     return;
 }
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventMemoryModule module;
+    CXLEventRecordHdr *hdr = &module.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *ct3d;
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
+    memset(&module, 0, sizeof(module));
+    cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+
+    module.type = type;
+    module.health_status = health_status;
+    module.media_status = media_status;
+    module.additional_status = additional_status;
+    module.life_used = life_used;
+    stw_le_p(&module.temperature, temperature);
+    stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
+    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
+    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
+
+    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 235c171264..2196bd841c 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -26,6 +26,18 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                bool has_correction_mask, uint64List *correction_mask,
                                Error **errp) {}
 
+void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
+                                        uint8_t flags, uint8_t type,
+                                        uint8_t health_status,
+                                        uint8_t media_status,
+                                        uint8_t additional_status,
+                                        uint8_t life_used,
+                                        int16_t temperature,
+                                        uint32_t dirty_shutdown_count,
+                                        uint32_t corrected_volatile_error_count,
+                                        uint32_t corrected_persistent_error_count,
+                                        Error **errp) {}
+
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
                            Error **errp)
 {
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index a39e30d973..089ba2091f 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -146,4 +146,23 @@ typedef struct CXLEventDram {
     uint8_t reserved[0x17];
 } QEMU_PACKED CXLEventDram;
 
+/*
+ * Memory Module Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.3: Table 8-45
+ * All fields little endian.
+ */
+typedef struct CXLEventMemoryModule {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t health_status;
+    uint8_t media_status;
+    uint8_t additional_status;
+    uint8_t life_used;
+    int16_t temperature;
+    uint32_t dirty_shutdown_count;
+    uint32_t corrected_volatile_error_count;
+    uint32_t corrected_persistent_error_count;
+    uint8_t reserved[0x3d];
+} QEMU_PACKED CXLEventMemoryModule;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 5e82097e76..0636f34d56 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -90,6 +90,41 @@
             '*column': 'uint16', '*correction-mask': [ 'uint64' ]
            }}
 
+##
+# @cxl-inject-memory-module-event:
+#
+# Inject an event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3)
+# This event includes a copy of the Device Health info at the time of
+# the event.
+#
+# @path: CXL type 3 device canonical QOM path
+# @log: Event Log to add the event to
+# @flags: header flags
+# @type: Device Event Type (see spec for permitted values)
+# @health-status: Overall health summary bitmap (see spec for permitted bits)
+# @media-status: Overall media health summary (see spec for permitted values)
+# @additional-status: Complex field (see spec for meaning)
+# @life-used: Percentage (0-100) of factory expected life span
+# @temperature: Device temperature in degrees Celsius
+# @dirty-shutdown-count: Counter incremented whenever device is unable
+#                        to determine if data loss may have occurred.
+# @corrected-volatile-error-count: Total number of correctable errors in
+#                                  volatile memory
+# @corrected-persistent-error-count: Total number correctable errors in
+#                                    persistent memory
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-memory-module-event',
+  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
+            'type': 'uint8', 'health-status': 'uint8',
+            'media-status': 'uint8', 'additional-status': 'uint8',
+            'life-used': 'uint8', 'temperature' : 'int16',
+            'dirty-shutdown-count': 'uint32',
+            'corrected-volatile-error-count': 'uint32',
+            'corrected-persistent-error-count': 'uint32'
+            }}
+
 ##
 # @cxl-inject-poison:
 #
-- 
2.39.2


