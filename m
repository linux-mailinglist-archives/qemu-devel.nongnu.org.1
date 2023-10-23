Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34F7D3BF1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:13:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxYs-0003Ll-Bo; Mon, 23 Oct 2023 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxYn-00038U-SR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:13:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxYl-0002FX-SC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:13:45 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgG65PQPz6K9DT;
 Tue, 24 Oct 2023 00:13:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:13:41 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 11/17] hw/cxl/mbox: Add support for background operations
Date: Mon, 23 Oct 2023 17:08:00 +0100
Message-ID: <20231023160806.13206-12-Jonathan.Cameron@huawei.com>
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

From: Davidlohr Bueso <dave@stgolabs.net>

Support background commands in the mailbox, and update
cmd_infostat_bg_op_sts() accordingly. This patch does not implement mbox
interrupts upon completion, so the kernel driver must rely on polling to
know when the operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2 of CCI rework series containing this.
 - Recover aspects that accidentally ended up in earlier patches.
---
 include/hw/cxl/cxl_device.h | 10 ++++
 hw/cxl/cxl-device-utils.c   | 24 ++++++++--
 hw/cxl/cxl-mailbox-utils.c  | 92 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fa73ed03e5..124ff969ec 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -149,6 +149,16 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
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
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index f8938678c7..51466a626b 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -82,6 +82,25 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
     case 4:
         return cxl_dstate->mbox_reg_state32[offset / size];
     case 8:
+        if (offset == A_CXL_DEV_BG_CMD_STS) {
+            uint64_t bg_status_reg;
+            bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP,
+                                       cci->bg.opcode);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       PERCENTAGE_COMP, cci->bg.complete_pct);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       RET_CODE, cci->bg.ret_code);
+            /* endian? */
+            cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg;
+        }
+        if (offset == A_CXL_DEV_MAILBOX_STS) {
+            uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
+            if (cci->bg.complete_pct) {
+                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
+                                        0);
+                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
+            }
+        }
         return cxl_dstate->mbox_reg_state64[offset / size];
     default:
         g_assert_not_reached();
@@ -114,8 +133,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
     case A_CXL_DEV_MAILBOX_CMD:
         break;
     case A_CXL_DEV_BG_CMD_STS:
-        /* BG not supported */
-        /* fallthrough */
+        break;
     case A_CXL_DEV_MAILBOX_STS:
         /* Read only register, will get updated by the state machine */
         return;
@@ -339,7 +357,7 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt or background support */
+    /* 2048 payload size, with no interrupt */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index de63fc1a28..f1226f8f39 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -963,6 +963,8 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
+#define SECURITY_STATE_CHANGE (1 << 5)
+#define BACKGROUND_OPERATION (1 << 6)
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
@@ -1011,10 +1013,19 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_get_physical_port_state, ~0, 0 },
 };
 
+/*
+ * While the command is executing in the background, the device should
+ * update the percentage complete in the Background Command Status Register
+ * at least once per second.
+ */
+
+#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
+
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in, size_t *len_out,
                             uint8_t *pl_out, bool *bg_started)
 {
+    int ret;
     const struct cxl_cmd *cxl_cmd;
     opcode_handler h;
 
@@ -1031,7 +1042,81 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
+    /* Only one bg command at a time */
+    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+        cci->bg.runtime > 0) {
+        return CXL_MBOX_BUSY;
+    }
+
+    ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
+    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+        ret == CXL_MBOX_BG_STARTED) {
+        *bg_started = true;
+    } else {
+        *bg_started = false;
+    }
+
+    /* Set bg and the return code */
+    if (*bg_started) {
+        uint64_t now;
+
+        cci->bg.opcode = (set << 8) | cmd;
+
+        cci->bg.complete_pct = 0;
+        cci->bg.ret_code = 0;
+
+        now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+        cci->bg.starttime = now;
+        timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
+    return ret;
+}
+
+static void bg_timercb(void *opaque)
+{
+    CXLCCI *cci = opaque;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    uint64_t bg_status_reg = 0;
+    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
+
+    assert(cci->bg.runtime > 0);
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                               OP, cci->bg.opcode);
+
+    if (now >= total_time) { /* we are done */
+        uint64_t status_reg;
+        uint16_t ret = CXL_MBOX_SUCCESS;
+
+        cci->bg.complete_pct = 100;
+        /* Clear bg */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+
+        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                   RET_CODE, ret);
+
+        /* TODO add ad-hoc cmd succesful completion handling */
+
+        qemu_log("Background command %04xh finished: %s\n",
+                 cci->bg.opcode,
+                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
+    } else {
+        /* estimate only */
+        cci->bg.complete_pct = 100 * now / total_time;
+        timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                               PERCENTAGE_COMP, cci->bg.complete_pct);
+    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
+
+    if (cci->bg.complete_pct == 100) {
+        cci->bg.starttime = 0;
+        /* registers are updated, allow new bg-capable cmds */
+        cci->bg.runtime = 0;
+    }
 }
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
@@ -1050,6 +1135,11 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+    cci->bg.complete_pct = 0;
+    cci->bg.starttime = 0;
+    cci->bg.runtime = 0;
+    cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                 bg_timercb, cci);
 }
 
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
-- 
2.39.2


