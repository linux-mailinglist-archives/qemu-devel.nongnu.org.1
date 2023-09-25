Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92907ADCEF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:19:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoIi-0005Zk-8G; Mon, 25 Sep 2023 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoIa-0005Tx-M6
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:19:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkoIY-0001Un-Mm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:19:04 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvShY6SFyz6K7VL;
 Tue, 26 Sep 2023 00:17:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:19:00 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Gregory Price <gregory.price@memverge.com>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, Klaus Jensen
 <k.jensen@samsung.com>
Subject: [PATCH 15/19] hw/cxl/mbox: Wire up interrupts for background
 completion
Date: Mon, 25 Sep 2023 17:11:20 +0100
Message-ID: <20230925161124.18940-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
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

Notify when the background operation is done. Note that for now background
commands are only supported on the main Type 3 mailbox.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-device-utils.c   | 10 +++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 31 ++++++++++++++-----------------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a99a7e6274..b7fa57fd14 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -193,6 +193,7 @@ typedef struct cxl_device_state {
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
+        uint8_t mbox_msi_n;
         union {
             uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 88f0256c79..41763688ce 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -345,10 +345,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt */
+    const uint8_t msi_n = 9;
+
+    /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
+    /* irq support */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     BG_INT_CAP, 1);
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MSI_N, msi_n);
+    cxl_dstate->mbox_msi_n = msi_n;
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 63acbc1214..3db86b4da7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -8,6 +8,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
@@ -1092,28 +1094,16 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t bg_status_reg = 0;
     uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
 
     assert(cci->bg.runtime > 0);
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               OP, cci->bg.opcode);
 
     if (now >= total_time) { /* we are done */
-        uint64_t status_reg;
         uint16_t ret = CXL_MBOX_SUCCESS;
 
         cci->bg.complete_pct = 100;
-        /* Clear bg */
-        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
-        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-
-        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                                   RET_CODE, ret);
-
-        /* TODO add ad-hoc cmd succesful completion handling */
+        cci->bg.ret_code = ret;
 
         qemu_log("Background command %04xh finished: %s\n",
                  cci->bg.opcode,
@@ -1124,14 +1114,21 @@ static void bg_timercb(void *opaque)
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               PERCENTAGE_COMP, cci->bg.complete_pct);
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
-
     if (cci->bg.complete_pct == 100) {
+        /* TODO: generalize to switch CCI */
+        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+        PCIDevice *pdev = PCI_DEVICE(cci->d);
+
         cci->bg.starttime = 0;
         /* registers are updated, allow new bg-capable cmds */
         cci->bg.runtime = 0;
+
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, cxl_dstate->mbox_msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, cxl_dstate->mbox_msi_n);
+        }
     }
 }
 
-- 
2.39.2


