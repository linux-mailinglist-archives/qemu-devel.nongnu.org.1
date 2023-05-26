Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00055712B86
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2b0X-0001x3-W5; Fri, 26 May 2023 13:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2b0W-0001ws-7d
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:13:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2b0U-00064V-2Z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:13:39 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWgV6TBWz687m3;
 Sat, 27 May 2023 01:12:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:13:34 +0100
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
Subject: [PATCH v8 1/7] hw/cxl/events: Add event status register
Date: Fri, 26 May 2023 18:12:58 +0100
Message-ID: <20230526171304.1613-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
References: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The device status register block was defined.  However, there were no
individual registers nor any data wired up.

Define the event status register [CXL 3.0; 8.2.8.3.1] as part of the
device status register block.  Wire up the register and initialize the
event status for each log.

To support CXL 3.0 the version of the device status register block needs
to be 2.  Change the macro to allow for setting the version.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 23 +++++++++++++++++---
 include/hw/cxl/cxl_events.h | 28 ++++++++++++++++++++++++
 hw/cxl/cxl-device-utils.c   | 43 ++++++++++++++++++++++++++++++++-----
 3 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 73328a52cf..16993f7098 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -13,6 +13,7 @@
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
 #include "hw/register.h"
+#include "hw/cxl/cxl_events.h"
 
 /*
  * The following is how a CXL device's Memory Device registers are laid out.
@@ -86,7 +87,16 @@ typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
     /* mmio for device capabilities array - 8.2.8.2 */
-    MemoryRegion device;
+    struct {
+        MemoryRegion device;
+        union {
+            uint8_t dev_reg_state[CXL_DEVICE_STATUS_REGISTERS_LENGTH];
+            uint16_t dev_reg_state16[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 2];
+            uint32_t dev_reg_state32[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 4];
+            uint64_t dev_reg_state64[CXL_DEVICE_STATUS_REGISTERS_LENGTH / 8];
+        };
+        uint64_t event_status;
+    };
     MemoryRegion memory_device;
     struct {
         MemoryRegion caps;
@@ -141,6 +151,9 @@ REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte access
     FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
     FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
 
+void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
+                          bool available);
+
 /*
  * Helper macro to initialize capability headers for CXL devices.
  *
@@ -175,7 +188,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
 
-#define cxl_device_cap_init(dstate, reg, cap_id)                           \
+#define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
         uint32_t *cap_hdrs = dstate->caps_reg_state32;                     \
         int which = R_CXL_DEV_##reg##_CAP_HDR0;                            \
@@ -183,7 +196,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
             FIELD_DP32(cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0,          \
                        CAP_ID, cap_id);                                    \
         cap_hdrs[which] = FIELD_DP32(                                      \
-            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, 1);    \
+            cap_hdrs[which], CXL_DEV_##reg##_CAP_HDR0, CAP_VERSION, ver);  \
         cap_hdrs[which + 1] =                                              \
             FIELD_DP32(cap_hdrs[which + 1], CXL_DEV_##reg##_CAP_HDR1,      \
                        CAP_OFFSET, CXL_##reg##_REGISTERS_OFFSET);          \
@@ -192,6 +205,10 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
                        CAP_LENGTH, CXL_##reg##_REGISTERS_LENGTH);          \
     } while (0)
 
+/* CXL 3.0 8.2.8.3.1 Event Status Register */
+REG64(CXL_DEV_EVENT_STATUS, 0)
+    FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
+
 /* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
new file mode 100644
index 0000000000..aeb3b0590e
--- /dev/null
+++ b/include/hw/cxl/cxl_events.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU CXL Events
+ *
+ * Copyright (c) 2022 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_EVENTS_H
+#define CXL_EVENTS_H
+
+/*
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ *
+ * Define these as the bit position for the event status register for ease of
+ * setting the status.
+ */
+typedef enum CXLEventLogType {
+    CXL_EVENT_TYPE_INFO          = 0,
+    CXL_EVENT_TYPE_WARN          = 1,
+    CXL_EVENT_TYPE_FAIL          = 2,
+    CXL_EVENT_TYPE_FATAL         = 3,
+    CXL_EVENT_TYPE_DYNAMIC_CAP   = 4,
+    CXL_EVENT_TYPE_MAX
+} CXLEventLogType;
+
+#endif /* CXL_EVENTS_H */
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 86e1cea8ce..517f06d869 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -41,7 +41,20 @@ static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
 
 static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    return 0;
+    CXLDeviceState *cxl_dstate = opaque;
+
+    switch (size) {
+    case 1:
+        return cxl_dstate->dev_reg_state[offset];
+    case 2:
+        return cxl_dstate->dev_reg_state16[offset / size];
+    case 4:
+        return cxl_dstate->dev_reg_state32[offset / size];
+    case 8:
+        return cxl_dstate->dev_reg_state64[offset / size];
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
@@ -236,7 +249,27 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                                 &cxl_dstate->memory_device);
 }
 
-static void device_reg_init_common(CXLDeviceState *cxl_dstate) { }
+void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
+                          bool available)
+{
+    if (available) {
+        cxl_dstate->event_status |= (1 << log_type);
+    } else {
+        cxl_dstate->event_status &= ~(1 << log_type);
+    }
+
+    ARRAY_FIELD_DP64(cxl_dstate->dev_reg_state64, CXL_DEV_EVENT_STATUS,
+                     EVENT_STATUS, cxl_dstate->event_status);
+}
+
+static void device_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    CXLEventLogType log;
+
+    for (log = 0; log < CXL_EVENT_TYPE_MAX; log++) {
+        cxl_event_set_status(cxl_dstate, log, false);
+    }
+}
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
@@ -258,13 +291,13 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
     ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
 
-    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1);
+    cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
     device_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MAILBOX, 2);
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
     mailbox_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
+    cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
     cxl_initialize_mailbox(cxl_dstate);
-- 
2.39.2


