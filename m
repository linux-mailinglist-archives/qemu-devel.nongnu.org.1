Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25077A243E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCG2-0002bH-Gh; Fri, 15 Sep 2023 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCFx-0002Uy-IW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:05:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCFu-0000uS-KF
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:05:24 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnL6Y6ZGpz67ZCl;
 Sat, 16 Sep 2023 01:00:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:05:20 +0100
To: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v2 2/4] hw/cxl: Use switch statements for read and write of
 cachemem registers
Date: Fri, 15 Sep 2023 18:04:16 +0100
Message-ID: <20230915170418.21337-3-Jonathan.Cameron@huawei.com>
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

Establishing that only register accesses of size 4 and 8 can occur
using these functions requires looking at their callers. Make it
easier to see that by using switch statements.
Assertions are used to enforce that the register storage is of the
matching size, allowing fixed values to be used for divisors of
the array indices.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Use switch statements. Note we coudl have renamed registers to make
    the sizes visible as is true of some other cases, but that felt odd
    as this is the only size these registers can be, so why call it out.
    The asserts do the same job.
 hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd13..7ef3ef2bd6 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     CXLComponentState *cxl_cstate = opaque;
     ComponentRegisters *cregs = &cxl_cstate->crb;
 
-    if (size == 8) {
+    switch (size) {
+    case 4:
+        if (cregs->special_ops && cregs->special_ops->read) {
+            return cregs->special_ops->read(cxl_cstate, offset, 4);
+        } else {
+            static_assert(sizeof(*cregs->cache_mem_registers) == 4);
+            return cregs->cache_mem_registers[offset / 4];
+        }
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return 0;
-    }
-
-    if (cregs->special_ops && cregs->special_ops->read) {
-        return cregs->special_ops->read(cxl_cstate, offset, size);
-    } else {
-        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
@@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     ComponentRegisters *cregs = &cxl_cstate->crb;
     uint32_t mask;
 
-    if (size == 8) {
+    switch (size) {
+    case 4:
+        static_assert(sizeof(*cregs->cache_mem_regs_write_mask) == 4);
+        static_assert(sizeof(*cregs->cache_mem_registers) == 4);
+        mask = cregs->cache_mem_regs_write_mask[offset / 4];
+        value &= mask;
+        /* RO bits should remain constant. Done by reading existing value */
+        value |= ~mask & cregs->cache_mem_registers[offset / 4];
+        if (cregs->special_ops && cregs->special_ops->write) {
+            cregs->special_ops->write(cxl_cstate, offset, value, size);
+            return;
+        }
+
+        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
+            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
+            dumb_hdm_handler(cxl_cstate, offset, value);
+        } else {
+            cregs->cache_mem_registers[offset / 4] = value;
+        }
+        return;
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return;
-    }
-    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
-    value &= mask;
-    /* RO bits should remain constant. Done by reading existing value */
-    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
-    if (cregs->special_ops && cregs->special_ops->write) {
-        cregs->special_ops->write(cxl_cstate, offset, value, size);
-        return;
-    }
-
-    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
-        dumb_hdm_handler(cxl_cstate, offset, value);
-    } else {
-        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
-- 
2.39.2


