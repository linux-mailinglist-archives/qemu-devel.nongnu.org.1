Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A07D3BCF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxUU-0007e2-Me; Mon, 23 Oct 2023 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxUQ-0007UE-GS
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxUM-0001AZ-Nk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:09:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg5R2gjfz6JBBl;
 Tue, 24 Oct 2023 00:05:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:09:07 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 02/17] hw/cxl/mbox: Split mailbox command payload into
 separate input and output
Date: Mon, 23 Oct 2023 17:07:51 +0100
Message-ID: <20231023160806.13206-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

New CCI types that will be supported shortly do not have a single buffer
used in both directions. As such, split it up. To avoid the complexities
of implementing all commands to handle potential aliasing, take a copy of
the input before use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
- Drop Fan's RB as significant changes.
- Avoid passing aliased pointers to the various command handlers.
  It was a source of subtle bugs in the switch-cci so let us just make
  a copy and use that instead.
---
 include/hw/cxl/cxl_device.h |   7 +-
 hw/cxl/cxl-events.c         |   2 +-
 hw/cxl/cxl-mailbox-utils.c  | 230 +++++++++++++++++++++---------------
 3 files changed, 140 insertions(+), 99 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 556953469c..d7a2c4009e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -114,8 +114,9 @@ typedef enum {
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
-                                     uint8_t *payload,
-                                     CXLDeviceState *cxl_dstate, uint16_t *len);
+                                     uint8_t *payload_in, size_t len_in,
+                                     uint8_t *payload_out, size_t *len_out,
+                                     CXLDeviceState *cxl_dstate);
 struct cxl_cmd {
     const char *name;
     opcode_handler handler;
@@ -390,7 +391,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
                       CXLEventRecordRaw *event);
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
-                                 uint16_t *len);
+                                 size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
 
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index e2172b94b9..bee6dfaf14 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -143,7 +143,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
 
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
-                                 uint16_t *len)
+                                 size_t *len)
 {
     CXLEventLog *log;
     CXLEvent *entry;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c02de06943..e5ddce37c7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -71,9 +71,9 @@ enum {
 
 
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxlds,
-                                         uint16_t *len)
+                                         uint8_t *payload_in, size_t len_in,
+                                         uint8_t *payload_out, size_t *len_out,
+                                         CXLDeviceState *cxlds)
 {
     CXLGetEventPayload *pl;
     uint8_t log_type;
@@ -83,9 +83,9 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    log_type = payload[0];
+    log_type = payload_in[0];
 
-    pl = (CXLGetEventPayload *)payload;
+    pl = (CXLGetEventPayload *)payload_out;
     memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
@@ -94,30 +94,34 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
         max_recs = 0xFFFF;
     }
 
-    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
+    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len_out);
 }
 
 static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
-                                           uint8_t *payload,
-                                           CXLDeviceState *cxlds,
-                                           uint16_t *len)
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLDeviceState *cxlds)
 {
     CXLClearEventPayload *pl;
 
-    pl = (CXLClearEventPayload *)payload;
-    *len = 0;
+    pl = (CXLClearEventPayload *)payload_in;
+    *len_out = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
 
 static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
-                                                  uint8_t *payload,
-                                                  CXLDeviceState *cxlds,
-                                                  uint16_t *len)
+                                                  uint8_t *payload_in,
+                                                  size_t len_in,
+                                                  uint8_t *payload_out,
+                                                  size_t *len_out,
+                                                  CXLDeviceState *cxlds)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    policy = (CXLEventInterruptPolicy *)payload;
+    policy = (CXLEventInterruptPolicy *)payload_out;
     memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
@@ -146,23 +150,25 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
         policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
     }
 
-    *len = sizeof(*policy);
+    *len_out = sizeof(*policy);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
-                                                  uint8_t *payload,
-                                                  CXLDeviceState *cxlds,
-                                                  uint16_t *len)
+                                                  uint8_t *payload_in,
+                                                  size_t len_in,
+                                                  uint8_t *payload_out,
+                                                  size_t *len_out,
+                                                  CXLDeviceState *cxlds)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
+    if (len_in < CXL_EVENT_INT_SETTING_MIN_LEN) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    policy = (CXLEventInterruptPolicy *)payload;
+    policy = (CXLEventInterruptPolicy *)payload_in;
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
@@ -181,7 +187,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
                         CXL_INT_MSI_MSIX;
 
     /* DCD is optional */
-    if (*len < sizeof(*policy)) {
+    if (len_in < sizeof(*policy)) {
         return CXL_MBOX_SUCCESS;
     }
 
@@ -189,15 +195,17 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
     log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
                         CXL_INT_MSI_MSIX;
 
-    *len = sizeof(*policy);
+    *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
-                                               uint8_t *payload,
-                                               CXLDeviceState *cxl_dstate,
-                                               uint16_t *len)
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLDeviceState *cxl_dstate)
 {
     struct {
         uint8_t slots_supported;
@@ -216,7 +224,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    fw_info = (void *)payload;
+    fw_info = (void *)payload_out;
     memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
@@ -224,36 +232,40 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info->caps = 0;
     pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
 
-    *len = sizeof(*fw_info);
+    *len_out = sizeof(*fw_info);
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.1 */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
-                                    uint8_t *payload,
-                                    CXLDeviceState *cxl_dstate,
-                                    uint16_t *len)
+                                    uint8_t *payload_in,
+                                    size_t len_in,
+                                    uint8_t *payload_out,
+                                    size_t *len_out,
+                                    CXLDeviceState *cxl_dstate)
 {
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    stq_le_p(payload, final_time);
-    *len = 8;
+    stq_le_p(payload_out, final_time);
+    *len_out = 8;
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.2 */
 static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
-                                    uint8_t *payload,
-                                    CXLDeviceState *cxl_dstate,
-                                    uint16_t *len)
+                                    uint8_t *payload_in,
+                                    size_t len_in,
+                                    uint8_t *payload_out,
+                                    size_t *len_out,
+                                    CXLDeviceState *cxl_dstate)
 {
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload);
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload_in);
 
-    *len = 0;
+    *len_out = 0;
     return CXL_MBOX_SUCCESS;
 }
 
@@ -265,9 +277,11 @@ static const QemuUUID cel_uuid = {
 
 /* 8.2.9.4.1 */
 static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxl_dstate,
-                                         uint16_t *len)
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLDeviceState *cxl_dstate)
 {
     struct {
         uint16_t entries;
@@ -276,22 +290,24 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
             QemuUUID uuid;
             uint32_t size;
         } log_entries[1];
-    } QEMU_PACKED *supported_logs = (void *)payload;
+    } QEMU_PACKED *supported_logs = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
 
     supported_logs->entries = 1;
     supported_logs->log_entries[0].uuid = cel_uuid;
     supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
 
-    *len = sizeof(*supported_logs);
+    *len_out = sizeof(*supported_logs);
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.4.2 */
 static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct {
         QemuUUID uuid;
@@ -299,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
         uint32_t length;
     } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
 
-    get_log = (void *)payload;
+    get_log = (void *)payload_in;
 
     /*
      * 8.2.9.4.2
@@ -323,19 +339,21 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     }
 
     /* Store off everything to local variables so we can wipe out the payload */
-    *len = get_log->length;
+    *len_out = get_log->length;
 
-    memmove(payload, cxl_dstate->cel_log + get_log->offset,
-           get_log->length);
+    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
+            get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.5.1.1 */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
-                                             uint8_t *payload,
-                                             CXLDeviceState *cxl_dstate,
-                                             uint16_t *len)
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLDeviceState *cxl_dstate)
 {
     struct {
         char fw_revision[0x10];
@@ -363,7 +381,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    id = (void *)payload;
+    id = (void *)payload_out;
     memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
@@ -380,21 +398,23 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
 
-    *len = sizeof(*id);
+    *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
-                                              uint8_t *payload,
-                                              CXLDeviceState *cxl_dstate,
-                                              uint16_t *len)
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLDeviceState *cxl_dstate)
 {
     struct {
         uint64_t active_vmem;
         uint64_t active_pmem;
         uint64_t next_vmem;
         uint64_t next_pmem;
-    } QEMU_PACKED *part_info = (void *)payload;
+    } QEMU_PACKED *part_info = (void *)payload_out;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
@@ -413,14 +433,16 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&part_info->next_pmem, 0);
 
-    *len = sizeof(*part_info);
+    *len_out = sizeof(*part_info);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct {
         uint32_t offset;
@@ -430,46 +452,47 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
-    get_lsa = (void *)payload;
+    get_lsa = (void *)payload_in;
     offset = get_lsa->offset;
     length = get_lsa->length;
 
     if (offset + length > cvc->get_lsa_size(ct3d)) {
-        *len = 0;
+        *len_out = 0;
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    *len = cvc->get_lsa(ct3d, get_lsa, length, offset);
+    *len_out = cvc->get_lsa(ct3d, payload_out, length, offset);
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
-                                   uint8_t *payload,
-                                   CXLDeviceState *cxl_dstate,
-                                   uint16_t *len)
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLDeviceState *cxl_dstate)
 {
     struct set_lsa_pl {
         uint32_t offset;
         uint32_t rsvd;
         uint8_t data[];
     } QEMU_PACKED;
-    struct set_lsa_pl *set_lsa_payload = (void *)payload;
+    struct set_lsa_pl *set_lsa_payload = (void *)payload_in;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
-    uint16_t plen = *len;
 
-    *len = 0;
-    if (!plen) {
+    *len_out = 0;
+    if (!len_in) {
         return CXL_MBOX_SUCCESS;
     }
 
-    if (set_lsa_payload->offset + plen > cvc->get_lsa_size(ct3d) + hdr_len) {
+    if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
         return CXL_MBOX_INVALID_INPUT;
     }
-    plen -= hdr_len;
+    len_in -= hdr_len;
 
-    cvc->set_lsa(ct3d, set_lsa_payload->data, plen, set_lsa_payload->offset);
+    cvc->set_lsa(ct3d, set_lsa_payload->data, len_in, set_lsa_payload->offset);
     return CXL_MBOX_SUCCESS;
 }
 
@@ -480,9 +503,11 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
  * testing that kernel functionality.
  */
 static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
-                                            uint8_t *payload,
-                                            CXLDeviceState *cxl_dstate,
-                                            uint16_t *len)
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLDeviceState *cxl_dstate)
 {
     struct get_poison_list_pl {
         uint64_t pa;
@@ -502,8 +527,8 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         } QEMU_PACKED records[];
     } QEMU_PACKED;
 
-    struct get_poison_list_pl *in = (void *)payload;
-    struct get_poison_list_out_pl *out = (void *)payload;
+    struct get_poison_list_pl *in = (void *)payload_in;
+    struct get_poison_list_out_pl *out = (void *)payload_out;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
@@ -552,14 +577,16 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
         stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
     }
     stw_le_p(&out->count, record_count);
-    *len = out_pl_len;
+    *len_out = out_pl_len;
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
-                                          uint8_t *payload,
-                                          CXLDeviceState *cxl_dstate,
-                                          uint16_t *len_unused)
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLDeviceState *cxl_dstate)
 {
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -567,7 +594,7 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
     struct inject_poison_pl {
         uint64_t dpa;
     };
-    struct inject_poison_pl *in = (void *)payload;
+    struct inject_poison_pl *in = (void *)payload_in;
     uint64_t dpa = ldq_le_p(&in->dpa);
     CXLPoison *p;
 
@@ -592,14 +619,17 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
      */
     QLIST_INSERT_HEAD(poison_list, p, node);
     ct3d->poison_list_cnt++;
+    *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
-                                         uint8_t *payload,
-                                         CXLDeviceState *cxl_dstate,
-                                         uint16_t *len_unused)
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLDeviceState *cxl_dstate)
 {
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -611,7 +641,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     CXLPoison *ent;
     uint64_t dpa;
 
-    struct clear_poison_pl *in = (void *)payload;
+    struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
     if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
@@ -672,6 +702,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     }
     /* Any fragments have been added, free original entry */
     g_free(ent);
+    *len_out = 0;
 
     return CXL_MBOX_SUCCESS;
 }
@@ -724,15 +755,24 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
-    uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
     uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+    /*
+     * Copy taken to avoid need for individual command handlers to care
+     * about aliasing.
+     */
+    g_autofree uint8_t *pl_in_copy = NULL;
+    size_t len_out = 0;
 
+    pl_in_copy = g_memdup2(pl, len_in);
+    /* Avoid stale data - including from earlier commands */
+    memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
     cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
-        if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, cxl_dstate, &len);
-            assert(len <= cxl_dstate->payload_size);
+        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
+            ret = (*h)(cxl_cmd, pl_in_copy, len_in, pl, &len_out, cxl_dstate);
+            assert(len_out <= cxl_dstate->payload_size);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
@@ -748,7 +788,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     /* Set the return length */
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len);
+    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
 
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-- 
2.39.2


