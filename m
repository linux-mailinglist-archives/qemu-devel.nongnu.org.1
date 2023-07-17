Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA0756A00
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRr8-0005u5-LO; Mon, 17 Jul 2023 13:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRr5-0005tZ-6c
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:17:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRr2-00042M-FV
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:17:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TH92rFwz67g19;
 Tue, 18 Jul 2023 01:15:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:17:44 +0100
To: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Viacheslav Dubeyko <slava@dubeyko.com>, Shesha
 Bhushan Sreenivasamurthy <sheshas@marvell.com>, Fan Ni <fan.ni@samsung.com>,
 Michael Tsirkin <mst@redhat.com>, Jonathan Zhang <jonzhang@meta.com>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 02/17] hw/cxl/mailbox: Enable mulitple mailbox command sets
Date: Mon, 17 Jul 2023 18:16:31 +0100
Message-ID: <20230717171646.8972-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
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

Until now, we have supported only a single set of comamnds.
To allow introduction of switch CCI functions, we need to
be able to pick between different sets for a given mailbox
instance.  This patch should make not functional changes, but
enable them in the following patches.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 12 ++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 17 ++++-------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 887a38bdbc..2c239fca47 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -134,6 +134,17 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+struct cxl_cmd;
+typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
+                                     CXLDeviceState *cxl_dstate, uint16_t *len);
+struct cxl_cmd {
+    const char *name;
+    opcode_handler handler;
+    ssize_t in;
+    uint16_t effect; /* Reported in CEL */
+    uint8_t *payload;
+};
+
 typedef struct CXLEvent {
     CXLEventRecordRaw data;
     QSIMPLEQ_ENTRY(CXLEvent) node;
@@ -202,6 +213,7 @@ typedef struct cxl_device_state {
     uint64_t pmem_size;
     uint64_t vmem_size;
 
+    struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1e0d96f64f..c8feeffbeb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,16 +70,6 @@ enum {
         #define CLEAR_POISON           0x2
 };
 
-struct cxl_cmd;
-typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
-                                   CXLDeviceState *cxl_dstate, uint16_t *len);
-struct cxl_cmd {
-    const char *name;
-    opcode_handler handler;
-    ssize_t in;
-    uint16_t effect; /* Reported in CEL */
-    uint8_t *payload;
-};
 
 static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
                                          CXLDeviceState *cxlds,
@@ -711,7 +701,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
     uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    cxl_cmd = &cxl_cmd_set[set][cmd];
+    cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
@@ -746,10 +736,11 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
 {
+    cxl_dstate->cxl_cmd_set = cxl_cmd_set;
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
-            if (cxl_cmd_set[set][cmd].handler) {
-                struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
+                struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
                     &cxl_dstate->cel_log[cxl_dstate->cel_size];
 
-- 
2.39.2


