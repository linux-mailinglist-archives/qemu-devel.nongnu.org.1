Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3279EC1D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:07:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRRp-0000st-BU; Wed, 13 Sep 2023 11:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgRRm-0000jE-NN
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:06:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgRRi-00050h-Rh
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:06:30 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm3ZJ2DLfz6J6kS;
 Wed, 13 Sep 2023 23:01:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 16:06:23 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 2/4] hw/cxl: Use available size parameter to index into
 register arrays.
Date: Wed, 13 Sep 2023 16:05:19 +0100
Message-ID: <20230913150521.30035-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
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

Indexing has to be done into an array with the right size elements.
As such, the size parameter always matches the array element size
and can be used in place of the longer sizeof(*array)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd13..089e10b232 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -76,7 +76,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     if (cregs->special_ops && cregs->special_ops->read) {
         return cregs->special_ops->read(cxl_cstate, offset, size);
     } else {
-        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
+        return cregs->cache_mem_registers[offset / size];
     }
 }
 
@@ -122,10 +122,10 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
                       "CXL 8 byte cache mem registers not implemented\n");
         return;
     }
-    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
+    mask = cregs->cache_mem_regs_write_mask[offset / size];
     value &= mask;
     /* RO bits should remain constant. Done by reading existing value */
-    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
+    value |= ~mask & cregs->cache_mem_registers[offset / size];
     if (cregs->special_ops && cregs->special_ops->write) {
         cregs->special_ops->write(cxl_cstate, offset, value, size);
         return;
@@ -135,7 +135,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
         offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
         dumb_hdm_handler(cxl_cstate, offset, value);
     } else {
-        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
+        cregs->cache_mem_registers[offset / size] = value;
     }
 }
 
-- 
2.39.2


