Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0AA4F9E8
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 10:25:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl0W-0000A9-21; Wed, 05 Mar 2025 04:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl0U-00009k-5g
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:25:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpl0R-000141-Aa
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:25:37 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Y22f1zz6K9Qt;
 Wed,  5 Mar 2025 17:23:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 525D1140A08;
 Wed,  5 Mar 2025 17:25:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:25:32 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
 <vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
 <ajay.opensrc@micron.com>
Subject: [PATCH qemu 1/8] hw/cxl: Support aborting background commands
Date: Wed, 5 Mar 2025 09:24:52 +0000
Message-ID: <20250305092501.191929-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

As of 3.1 spec, background commands can be canceled with a new
abort command. Implement the support, which is advertised in
the CEL. No ad-hoc context undoing is necessary as all the
command logic of the running bg command is done upon completion.
Arbitrarily, the on-going background cmd will not be aborted if
already at least 85% done;

A mutex is introduced to stabilize mbox request cancel command vs
the timer callback being fired scenarios (as well as reading the
mbox registers). While some operations under critical regions
may be unnecessary (irq notifying, cmd callbacks), this is not
a path where performance is important, so simplicity is preferred.

Tested-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Ajay Joshi <ajay.opensrc@micron.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Modified with changes Davidlohr posted on list.
---
 include/hw/cxl/cxl_device.h  |  4 ++
 include/hw/cxl/cxl_mailbox.h |  1 +
 hw/cxl/cxl-device-utils.c    | 14 ++++---
 hw/cxl/cxl-mailbox-utils.c   | 72 ++++++++++++++++++++++++++++++++----
 hw/mem/cxl_type3.c           |  8 +++-
 5 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3a0ee7e8e7..d21695507f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -176,10 +176,12 @@ typedef struct CXLCCI {
         uint16_t opcode;
         uint16_t complete_pct;
         uint16_t ret_code; /* Current value of retcode */
+        bool aborted;
         uint64_t starttime;
         /* set by each bg cmd, cleared by the bg_timer when complete */
         uint64_t runtime;
         QEMUTimer *timer;
+        QemuMutex lock; /* serializes mbox abort vs timer cb */
     } bg;
 
     /* firmware update */
@@ -201,6 +203,7 @@ typedef struct CXLCCI {
     DeviceState *d;
     /* Pointer to the device hosting the protocol conversion */
     DeviceState *intf;
+    bool initialized;
 } CXLCCI;
 
 typedef struct cxl_device_state {
@@ -316,6 +319,7 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_destroy_cci(CXLCCI *cci);
 void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
                           size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index beb048052e..9008402d1c 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -14,5 +14,6 @@
 #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
 
 #endif
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 52ad1e4c3f..e150d74457 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -95,11 +95,15 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
         }
         if (offset == A_CXL_DEV_MAILBOX_STS) {
             uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
-            if (cci->bg.complete_pct) {
-                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
-                                        0);
-                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
-            }
+            int bgop;
+
+            qemu_mutex_lock(&cci->bg.lock);
+            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
+
+            status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
+                                    bgop);
+            cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
+            qemu_mutex_unlock(&cci->bg.lock);
         }
         return cxl_dstate->mbox_reg_state64[offset / size];
     default:
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 516c01d840..4401f446d9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -56,6 +56,7 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define BACKGROUND_OPERATION_ABORT     0x5
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -636,6 +637,41 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 Section 8.2.9.1.5:
+ * Request Abort Background Operation (Opcode 0005h)
+ */
+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    int bg_set = cci->bg.opcode >> 8;
+    int bg_cmd = cci->bg.opcode & 0xff;
+    const struct cxl_cmd *bg_c = &cci->cxl_cmd_set[bg_set][bg_cmd];
+
+    if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
+    }
+
+    qemu_mutex_lock(&cci->bg.lock);
+    if (cci->bg.runtime) {
+        /* operation is near complete, let it finish */
+        if (cci->bg.complete_pct < 85) {
+            timer_del(cci->bg.timer);
+            cci->bg.ret_code = CXL_MBOX_ABORTED;
+            cci->bg.starttime = 0;
+            cci->bg.runtime = 0;
+            cci->bg.aborted = true;
+        }
+    }
+    qemu_mutex_unlock(&cci->bg.lock);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define CXL_FW_SLOTS 2
 #define CXL_FW_SIZE  0x02000000 /* 32 mb */
 
@@ -2715,6 +2751,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 }
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -2727,9 +2765,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
-        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_firmware_update_transfer, ~0,
+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
     [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
-        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_firmware_update_activate, 2,
+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2758,7 +2798,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
-         CXL_MBOX_BACKGROUND_OPERATION)},
+         CXL_MBOX_BACKGROUND_OPERATION |
+         CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2771,7 +2812,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17,
+        (CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
@@ -2795,6 +2837,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
         cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
                          CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2881,6 +2925,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         cci->bg.opcode = (set << 8) | cmd;
 
         cci->bg.complete_pct = 0;
+        cci->bg.aborted = false;
         cci->bg.ret_code = 0;
 
         now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -2894,10 +2939,12 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
-    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
-    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
+    uint64_t now, total_time;
+
+    qemu_mutex_lock(&cci->bg.lock);
 
-    assert(cci->bg.runtime > 0);
+    now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    total_time = cci->bg.starttime + cci->bg.runtime;
 
     if (now >= total_time) { /* we are done */
         uint16_t ret = CXL_MBOX_SUCCESS;
@@ -2950,6 +2997,8 @@ static void bg_timercb(void *opaque)
             msi_notify(pdev, cxl_dstate->mbox_msi_n);
         }
     }
+
+    qemu_mutex_unlock(&cci->bg.lock);
 }
 
 static void cxl_rebuild_cel(CXLCCI *cci)
@@ -2978,12 +3027,21 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
+    cci->bg.aborted = false;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+    qemu_mutex_init(&cci->bg.lock);
 
     memset(&cci->fw, 0, sizeof(cci->fw));
     cci->fw.active_slot = 1;
     cci->fw.slot[cci->fw.active_slot - 1] = true;
+    cci->initialized = true;
+}
+
+void cxl_destroy_cci(CXLCCI *cci)
+{
+    qemu_mutex_destroy(&cci->bg.lock);
+    cci->initialized = false;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6fffa21ead..be670ae3f3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -970,6 +970,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
+    cxl_destroy_cci(&ct3d->cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1225,12 +1226,17 @@ static void ct3d_reset(DeviceState *dev)
      * Bring up an endpoint to target with MCTP over VDM.
      * This device is emulating an MLD with single LD for now.
      */
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
     cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
                                           DEVICE(ct3d), DEVICE(ct3d),
                                           512); /* Max payload made up */
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
-
 }
 
 static const Property ct3_props[] = {
-- 
2.43.0


