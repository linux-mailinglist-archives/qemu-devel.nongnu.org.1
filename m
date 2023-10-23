Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941F7D3BD2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:10:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVT-0001LW-Kc; Mon, 23 Oct 2023 12:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxVM-00011G-D5
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxVK-0001ej-AR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:12 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg6c1B4lz6JB9n;
 Tue, 24 Oct 2023 00:06:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:10:08 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 04/17] hw/cxl/mbox: Generalize the CCI command processing
Date: Mon, 23 Oct 2023 17:07:53 +0100
Message-ID: <20231023160806.13206-5-Jonathan.Cameron@huawei.com>
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

By moving the parts of the mailbox command handling that are CCI type
specific out to the caller, make the main handling code generic. Rename it
to cxl_process_cci_message() to reflect this new generality.

Change the type3 mailbox handling (reused shortly for the switch
mailbox CCI) to take a snapshot of the mailbox input data rather
than operating on it in place.  This reduces the chance of bugs
due to aliasing going forwars.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
Drop Fan RB as significant changes as follow on from the aliasing
avoidance change.
Also cleared out some bg operation stuff that was here as result of
a misshandled patch reorder.
---
 include/hw/cxl/cxl_device.h |  5 +++-
 hw/cxl/cxl-device-utils.c   | 44 +++++++++++++++++++++++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 51 ++++++++-----------------------------
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 779ca85319..6f8040b5ff 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -260,7 +260,10 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
-void cxl_process_mailbox(CXLCCI *cci);
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in,
+                            size_t *len_out, uint8_t *pl_out,
+                            bool *bg_started);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 327949a805..eb86634250 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -157,7 +157,49 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                          DOORBELL)) {
-        cxl_process_mailbox(cci);
+        uint64_t command_reg =
+            cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
+        uint8_t cmd_set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                     COMMAND_SET);
+        uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
+        size_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+        uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+        /*
+         * Copy taken to avoid need for individual command handlers to care
+         * about aliasing.
+         */
+        g_autofree uint8_t *pl_in_copy = NULL;
+        size_t len_out = 0;
+        uint64_t status_reg;
+        bool bg_started = false;
+        int rc;
+
+        pl_in_copy = g_memdup2(pl, len_in);
+        if (len_in == 0 || pl_in_copy) {
+            /* Avoid stale data  - including from earlier cmds */
+            memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+            rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl_in_copy,
+                                         &len_out, pl, &bg_started);
+        } else {
+            rc = CXL_MBOX_INTERNAL_ERROR;
+        }
+
+        /* Set bg and the return code */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP,
+                                bg_started ? 1 : 0);
+        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, rc);
+        /* Set the return length */
+        command_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_CMD, COMMAND_SET, cmd_set);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                 COMMAND, cmd);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
+                                 LENGTH, len_out);
+
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+        /* Tell the host we're done */
+        ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
+                         DOORBELL, 0);
     }
 }
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5484dfbbf1..239acc659d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -754,58 +754,27 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
-void cxl_process_mailbox(CXLCCI *cci)
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in, size_t *len_out,
+                            uint8_t *pl_out, bool *bg_started)
 {
-    uint16_t ret = CXL_MBOX_SUCCESS;
     const struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg = 0;
     opcode_handler h;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
-
-    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
-    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
-    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
-    /*
-     * Copy taken to avoid need for individual command handlers to care
-     * about aliasing.
-     */
-    g_autofree uint8_t *pl_in_copy = NULL;
-    size_t len_out = 0;
 
-    pl_in_copy = g_memdup2(pl, len_in);
-    /* Avoid stale data - including from earlier commands */
-    memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+    *len_out = 0;
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
-    if (h) {
-        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
-            assert(len_out <= cci->payload_max);
-        } else {
-            ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-    } else {
+    if (!h) {
         qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
                       set << 8 | cmd);
-        ret = CXL_MBOX_UNSUPPORTED;
+        return CXL_MBOX_UNSUPPORTED;
     }
 
-    /* Set the return code */
-    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
-
-    /* Set the return length */
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
-
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+    if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
 
-    /* Tell the host we're done */
-    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
-                     DOORBELL, 0);
+    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
 }
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
-- 
2.39.2


