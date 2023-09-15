Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3439E7A2446
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCGx-0004Qh-7i; Fri, 15 Sep 2023 13:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCGv-0004Pr-IO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:06:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCGt-0001H2-66
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:06:25 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLC43RJpz6HJbW;
 Sat, 16 Sep 2023 01:04:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:06:21 +0100
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v2 4/4] hw/cxl: Line length reductions
Date: Fri, 15 Sep 2023 18:04:18 +0100
Message-ID: <20230915170418.21337-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Tsirkin observed that there were some unnecessarily
long lines in the CXL code in a recent review.
This patch is intended to rectify that where it does not
hurt readability.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h |  3 ++-
 include/hw/cxl/cxl_device.h    |  5 +++--
 include/hw/cxl/cxl_events.h    |  3 ++-
 hw/cxl/cxl-cdat.c              |  3 ++-
 hw/cxl/cxl-component-utils.c   | 10 ++++++----
 hw/cxl/cxl-events.c            |  9 ++++++---
 hw/cxl/cxl-mailbox-utils.c     | 21 ++++++++++++++-------
 hw/mem/cxl_type3.c             | 31 +++++++++++++++++++------------
 hw/mem/cxl_type3_stubs.c       |  5 +++--
 9 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 3c795a6278..e52dd8d2b9 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -175,7 +175,8 @@ HDM_DECODER_INIT(3);
     (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
 #define CXL_SNOOP_REGISTERS_SIZE   0x8
 
-QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
+QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
+                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
                    "No space for registers");
 
 typedef struct component_registers {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 51cd0d9ce3..007ddaf078 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -192,7 +192,7 @@ void cxl_device_register_init_common(CXLDeviceState *dev);
  * Documented as a 128 bit register, but 64 bit accesses and the second
  * 64 bits are currently reserved.
  */
-REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte accesses */
+REG64(CXL_DEV_CAP_ARRAY, 0)
     FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
     FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
     FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
@@ -361,7 +361,8 @@ struct CXLType3Class {
                         uint64_t offset);
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
-    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
+    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset,
+                          uint8_t *data);
 };
 
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 089ba2091f..d778487b7e 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -92,7 +92,8 @@ typedef enum CXLEventIntMode {
     CXL_INT_RES      = 0x03,
 } CXLEventIntMode;
 #define CXL_EVENT_INT_MODE_MASK 0x3
-#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
+#define CXL_EVENT_INT_SETTING(vector) \
+    ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
 typedef struct CXLEventInterruptPolicy {
     uint8_t info_settings;
     uint8_t warn_settings;
diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index d246d6885b..639a2db3e1 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -60,7 +60,8 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
         return;
     }
 
-    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf, cdat->private);
+    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
+                                                 cdat->private);
 
     if (!cdat->built_buf_len) {
         /* Build later as not all data available yet */
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index c8d632d540..915c208209 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -240,7 +240,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
+                     POISON_ON_ERR_CAP, 0);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
                      HDM_DECODER_ENABLE, 0);
     write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
@@ -263,13 +264,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
     }
 }
 
-void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk,
+void cxl_component_register_init_common(uint32_t *reg_state,
+                                        uint32_t *write_msk,
                                         enum reg_type type)
 {
     int caps = 0;
 
     /*
-     * In CXL 2.0 the capabilities required for each CXL component are such that,
+     * In CXL2.0 the capabilities required for each CXL component are such that,
      * with the ordering chosen here, a single number can be used to define
      * which capabilities should be provided.
      */
@@ -448,7 +450,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
         default: /* Registers are RO for other component types */
             break;
         }
-        /* There are rw1cs bits in the status register but never set currently */
+        /* There are rw1cs bits in the status register but never set */
         break;
     }
 
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d161d57456..10a4531904 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -170,8 +170,10 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
     if (log->overflow_err_count) {
         pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
         pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
-        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
-        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
+        pl->first_overflow_timestamp =
+            cpu_to_le64(log->first_overflow_timestamp);
+        pl->last_overflow_timestamp =
+            cpu_to_le64(log->last_overflow_timestamp);
     }
 
     pl->record_count = cpu_to_le16(nr);
@@ -180,7 +182,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
     return CXL_MBOX_SUCCESS;
 }
 
-CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
+CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
+                                   CXLClearEventPayload *pl)
 {
     CXLEventLog *log;
     uint8_t log_type;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 02f9b5a870..3977af23f1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -366,9 +366,12 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
-    stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
-    stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->total_capacity,
+             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->persistent_capacity,
+             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&id->volatile_capacity,
+             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
     /* 256 poison records */
     st24_le_p(id->poison_list_max_mer, 256);
@@ -396,13 +399,15 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    stq_le_p(&part_info->active_vmem, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&part_info->active_vmem,
+             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
     /*
      * When both next_vmem and next_pmem are 0, there is no pending change to
      * partitioning.
      */
     stq_le_p(&part_info->next_vmem, 0);
-    stq_le_p(&part_info->active_pmem, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
+    stq_le_p(&part_info->active_pmem,
+             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&part_info->next_pmem, 0);
 
     *len = sizeof(*part_info);
@@ -681,8 +686,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
-    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
-    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
+    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
+                         8, IMMEDIATE_POLICY_CHANGE },
+    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
+                              0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1658e0cc59..c5855d4e7d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -197,10 +197,9 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     }
 
     if (nonvolatile_mr) {
+        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
         rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true,
-                                           (volatile_mr ?
-                                            memory_region_size(volatile_mr) : 0));
+                                           nonvolatile_mr, true, base);
         if (rc < 0) {
             goto error_cleanup;
         }
@@ -503,7 +502,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
     case A_CXL_RAS_UNC_ERR_STATUS:
     {
         uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
-        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
+        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL,
+                                 FIRST_ERROR_POINTER);
         CXLError *cxl_err;
         uint32_t unc_err;
 
@@ -522,7 +522,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
                  * closest to behavior of hardware not capable of multiple
                  * header recording.
                  */
-                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cxl_next) {
+                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node,
+                                    cxl_next) {
                     if ((1 << cxl_err->type) & value) {
                         QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
                         g_free(cxl_err);
@@ -1061,7 +1062,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
         if (((start >= p->start) && (start < p->start + p->length)) ||
             ((start + length > p->start) &&
              (start + length <= p->start + p->length))) {
-            error_setg(errp, "Overlap with existing poisoned region not supported");
+            error_setg(errp,
+                       "Overlap with existing poisoned region not supported");
             return;
         }
     }
@@ -1074,7 +1076,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     p = g_new0(CXLPoison, 1);
     p->length = length;
     p->start = start;
-    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
+    /* Different from injected via the mbox */
+    p->type = CXL_POISON_TYPE_INTERNAL;
 
     QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
     ct3d->poison_list_cnt++;
@@ -1211,7 +1214,8 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
         return;
     }
     /* If the error is masked, nothting to do here */
-    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
+    if (!((1 << cxl_err_type) &
+          ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
         return;
     }
 
@@ -1361,7 +1365,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                bool has_bank, uint8_t bank,
                                bool has_row, uint32_t row,
                                bool has_column, uint16_t column,
-                               bool has_correction_mask, uint64List *correction_mask,
+                               bool has_correction_mask,
+                               uint64List *correction_mask,
                                Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1462,7 +1467,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         int16_t temperature,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
-                                        uint32_t corrected_persistent_error_count,
+                                        uint32_t corrected_persist_error_count,
                                         Error **errp)
 {
     Object *obj = object_resolve_path(path, NULL);
@@ -1502,8 +1507,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     module.life_used = life_used;
     stw_le_p(&module.temperature, temperature);
     stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
-    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
-    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
+    stl_le_p(&module.corrected_volatile_error_count,
+             corrected_volatile_error_count);
+    stl_le_p(&module.corrected_persistent_error_count,
+             corrected_persist_error_count);
 
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
         cxl_event_irq_assert(ct3d);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index f3e4a9fa72..56d60b4fd8 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -23,7 +23,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
                                bool has_bank, uint8_t bank,
                                bool has_row, uint32_t row,
                                bool has_column, uint16_t column,
-                               bool has_correction_mask, uint64List *correction_mask,
+                               bool has_correction_mask,
+                               uint64List *correction_mask,
                                Error **errp) {}
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
@@ -35,7 +36,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
                                         int16_t temperature,
                                         uint32_t dirty_shutdown_count,
                                         uint32_t corrected_volatile_error_count,
-                                        uint32_t corrected_persistent_error_count,
+                                        uint32_t corrected_persist_error_count,
                                         Error **errp) {}
 
 void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
-- 
2.39.2


