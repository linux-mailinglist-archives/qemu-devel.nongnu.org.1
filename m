Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A2756A04
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRsg-0008I7-2J; Mon, 17 Jul 2023 13:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRsZ-0008Ax-L4
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:19:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRsX-0004MZ-0A
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:19:23 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TJ21W9pz67ZCl;
 Tue, 18 Jul 2023 01:16:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:19:17 +0100
To: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Viacheslav Dubeyko <slava@dubeyko.com>, Shesha
 Bhushan Sreenivasamurthy <sheshas@marvell.com>, Fan Ni <fan.ni@samsung.com>,
 Michael Tsirkin <mst@redhat.com>, Jonathan Zhang <jonzhang@meta.com>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 05/17] cxl/mbox: Pull the CCI definition out of the
 CXLDeviceState
Date: Mon, 17 Jul 2023 18:16:34 +0100
Message-ID: <20230717171646.8972-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Enables having multiple CCIs per devices. Each CCI (mailbox)
has it's own state and command list, so they can't share
a single structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 48 ++++++++++++++-----
 hw/cxl/cxl-device-utils.c   | 31 +++++++++---
 hw/cxl/cxl-mailbox-utils.c  | 94 ++++++++++++++++++++++---------------
 hw/mem/cxl_type3.c          |  5 +-
 4 files changed, 120 insertions(+), 58 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fc15c2729d..813d4b926c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -134,11 +134,12 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+typedef struct CXLCCI CXLCCI;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
                                      uint8_t *payload_in, size_t len_in,
                                      uint8_t *payload_out, size_t *len_out,
-                                     CXLDeviceState *cxl_dstate);
+                                     CXLCCI *cci);
 struct cxl_cmd {
     const char *name;
     opcode_handler handler;
@@ -162,6 +163,31 @@ typedef struct CXLEventLog {
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
 
+typedef struct CXLCCI {
+    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cel_log {
+        uint16_t opcode;
+        uint16_t effect;
+    } cel_log[1 << 16];
+    size_t cel_size;
+
+    /* background command handling (times in ms) */
+    struct {
+        uint16_t opcode;
+        uint16_t complete_pct;
+        uint16_t ret_code; /* Current value of retcode */
+        uint64_t starttime;
+        /* set by each bg cmd, cleared by the bg_timer when complete */
+        uint64_t runtime;
+        QEMUTimer *timer;
+    } bg;
+    size_t payload_max;
+    /* Pointer to device hosting the CCI */
+    DeviceState *d;
+    /* Pointer to the device hosting the protocol conversion */
+    DeviceState *intf;
+} CXLCCI;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
@@ -196,11 +222,6 @@ typedef struct cxl_device_state {
             uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
             uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
         };
-        struct cel_log {
-            uint16_t opcode;
-            uint16_t effect;
-        } cel_log[1 << 16];
-        size_t cel_size;
     };
 
     struct {
@@ -214,16 +235,17 @@ typedef struct cxl_device_state {
     uint64_t pmem_size;
     uint64_t vmem_size;
 
-    const struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
-void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
+                                    CXLCCI *cci);
 
+typedef struct CXLType3Dev CXLType3Dev;
 /* Set up default values for the register block */
-void cxl_device_register_init_common(CXLDeviceState *dev);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d);
 
 /*
  * CXL 2.0 - 8.2.8.1 including errata F4
@@ -269,8 +291,9 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                       CXL_DEVICE_CAP_HDR1_OFFSET +
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
-void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
+void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_process_mailbox(CXLCCI *cci);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -371,7 +394,8 @@ struct CXLType3Dev {
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
-
+    CXLCCI cci;
+    
     /* DOE */
     DOECap doe_cdat;
     DOECap doe_comp;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 517f06d869..caf61ab1f5 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -59,7 +59,14 @@ static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
 
 static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    CXLDeviceState *cxl_dstate = opaque;
+    CXLDeviceState *cxl_dstate;
+    CXLCCI *cci = opaque;
+
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else {
+        return 0;
+    }
 
     switch (size) {
     case 1:
@@ -120,7 +127,14 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
 static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
-    CXLDeviceState *cxl_dstate = opaque;
+    CXLDeviceState *cxl_dstate;
+    CXLCCI *cci = opaque;
+
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else {
+        return;
+    }
 
     if (offset >= A_CXL_DEV_CMD_PAYLOAD) {
         memcpy(cxl_dstate->mbox_reg_state + offset, &value, size);
@@ -140,7 +154,7 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                          DOORBELL)) {
-        cxl_process_mailbox(cxl_dstate);
+        cxl_process_mailbox(cci);
     }
 }
 
@@ -220,7 +234,8 @@ static const MemoryRegionOps caps_ops = {
     },
 };
 
-void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate,
+                                    CXLCCI *cci)
 {
     /* This will be a BAR, so needs to be rounded up to pow2 for PCI spec */
     memory_region_init(&cxl_dstate->device_registers, obj, "device-registers",
@@ -230,7 +245,7 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                           "cap-array", CXL_CAPS_SIZE);
     memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
                           "device-status", CXL_DEVICE_STATUS_REGISTERS_LENGTH);
-    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_dstate,
+    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cci,
                           "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
     memory_region_init_io(&cxl_dstate->memory_device, obj, &mdev_ops,
                           cxl_dstate, "memory device caps",
@@ -281,8 +296,9 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
 
-void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
     const int cap_count = 3;
 
@@ -300,7 +316,8 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
-    cxl_initialize_mailbox(cxl_dstate);
+    cxl_initialize_mailbox_t3(&ct3d->cci, DEVICE(ct3d),
+                              CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 785c3fa7d0..399df6e3af 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -74,8 +74,9 @@ enum {
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
                                          uint8_t *payload_out, size_t *len_out,
-                                         CXLDeviceState *cxlds)
+                                         CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLGetEventPayload *pl;
     uint8_t log_type;
     int max_recs;
@@ -103,8 +104,9 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
                                            size_t len_in,
                                            uint8_t *payload_out,
                                            size_t *len_out,
-                                           CXLDeviceState *cxlds)
+                                           CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLClearEventPayload *pl;
 
     pl = (CXLClearEventPayload *)payload_in;
@@ -117,8 +119,9 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
                                                   size_t len_in,
                                                   uint8_t *payload_out,
                                                   size_t *len_out,
-                                                  CXLDeviceState *cxlds)
+                                                  CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
@@ -160,8 +163,9 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
                                                   size_t len_in,
                                                   uint8_t *payload_out,
                                                   size_t *len_out,
-                                                  CXLDeviceState *cxlds)
+                                                  CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
@@ -206,8 +210,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t len,
                                                uint8_t *payload_out,
                                                size_t *len_out,
-                                               CXLDeviceState *cxl_dstate)
+                                               CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -243,8 +248,9 @@ static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     size_t len_in,
                                     uint8_t *payload_out,
                                     size_t *len_out,
-                                    CXLDeviceState *cxl_dstate)
+                                    CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
     stq_le_p(payload_out, final_time);
@@ -259,8 +265,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
                                     size_t len_in,
                                     uint8_t *payload_out,
                                     size_t *len_out,
-                                    CXLDeviceState *cxl_dstate)
+                                    CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
@@ -282,7 +290,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
                                          size_t len_in,
                                          uint8_t *payload_out,
                                          size_t *len_out,
-                                         CXLDeviceState *cxl_dstate)
+                                         CXLCCI *cci)
 {
     struct {
         uint16_t entries;
@@ -296,7 +304,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
 
     supported_logs->entries = 1;
     supported_logs->log_entries[0].uuid = cel_uuid;
-    supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
+    supported_logs->log_entries[0].size = 4 * cci->cel_size;
 
     *len_out = sizeof(*supported_logs);
     return CXL_MBOX_SUCCESS;
@@ -308,7 +316,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct {
         QemuUUID uuid;
@@ -331,7 +339,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
      * the only possible failure would be if the mailbox itself isn't big
      * enough.
      */
-    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
+    if (get_log->offset + get_log->length > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -342,8 +350,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
-            get_log->length);
+    memmove(payload_out, cci->cel_log + get_log->offset, get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
@@ -354,7 +361,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              size_t len_in,
                                              uint8_t *payload_out,
                                              size_t *len_out,
-                                             CXLDeviceState *cxl_dstate)
+                                             CXLCCI *cci)
 {
     struct {
         char fw_revision[0x10];
@@ -373,9 +380,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint8_t qos_telemetry_caps;
     } QEMU_PACKED *id;
     QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
-
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
         (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
@@ -405,8 +412,9 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
                                               size_t len_in,
                                               uint8_t *payload_out,
                                               size_t *len_out,
-                                              CXLDeviceState *cxl_dstate)
+                                              CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     struct {
         uint64_t active_vmem;
         uint64_t active_pmem;
@@ -438,13 +446,13 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct {
         uint32_t offset;
         uint32_t length;
     } QEMU_PACKED *get_lsa;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
@@ -466,7 +474,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct set_lsa_pl {
         uint32_t offset;
@@ -474,7 +482,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
         uint8_t data[];
     } QEMU_PACKED;
     struct set_lsa_pl *set_lsa_payload = (void *)payload_in;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
 
@@ -503,7 +511,7 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
                                             size_t len_in,
                                             uint8_t *payload_out,
                                             size_t *len_out,
-                                            CXLDeviceState *cxl_dstate)
+                                            CXLCCI *cci)
 {
     struct get_poison_list_pl {
         uint64_t pa;
@@ -525,7 +533,7 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
 
     struct get_poison_list_pl *in = (void *)payload_in;
     struct get_poison_list_out_pl *out = (void *)payload_out;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -582,9 +590,9 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
                                           size_t len_in,
                                           uint8_t *payload_out,
                                           size_t *len_out,
-                                          CXLDeviceState *cxl_dstate)
+                                          CXLCCI *cci)
 {
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLPoisonList *poison_list = &ct3d->poison_list;
     CXLPoison *ent;
     struct inject_poison_pl {
@@ -625,9 +633,10 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
                                          size_t len_in,
                                          uint8_t *payload_out,
                                          size_t *len_out,
-                                         CXLDeviceState *cxl_dstate)
+                                         CXLCCI *cci)
 {
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     CXLPoisonList *poison_list = &ct3d->poison_list;
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     struct clear_poison_pl {
@@ -739,12 +748,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
-void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
+void cxl_process_mailbox(CXLCCI *cci)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
     const struct cxl_cmd *cxl_cmd;
     uint64_t status_reg = 0;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
@@ -753,12 +763,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
     size_t len_out = 0;
 
-    cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
+    cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cxl_dstate);
-            assert(len_out <= cxl_dstate->payload_size);
+            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
+            assert(len_out <= cci->payload_max);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
@@ -784,20 +794,30 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                      DOORBELL, 0);
 }
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
-    cxl_dstate->cxl_cmd_set = cxl_cmd_set;
+    cci->payload_max = payload_max;
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
-            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
-                const struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
+            if (cci->cxl_cmd_set[set][cmd].handler) {
+                const struct cxl_cmd *c = &cci->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
-                    &cxl_dstate->cel_log[cxl_dstate->cel_size];
+                    &cci->cel_log[cci->cel_size];
 
                 log->opcode = (set << 8) | cmd;
                 log->effect = c->effect;
-                cxl_dstate->cel_size++;
+                cci->cel_size++;
             }
         }
     }
 }
+
+void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set;
+    cci->d = d;
+ 
+    /* No separation for PCI MB as protocol handled in PCI device */
+    cci->intf = d;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ff52106f8d..f479dc67e8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -832,7 +832,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         pci_dev, CXL_COMPONENT_REG_BAR_IDX,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
 
-    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
+    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
+                                   &ct3d->cci);
     cxl_cpmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate, 0, 6);
     cxl_cpmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate, 1, 7);
     pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
@@ -1040,7 +1041,7 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_common(&ct3d->cxl_dstate);
+    cxl_device_register_init_t3(ct3d);
 }
 
 static Property ct3_props[] = {
-- 
2.39.2


