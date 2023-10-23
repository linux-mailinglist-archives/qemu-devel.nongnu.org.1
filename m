Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51C7D3C0E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxas-0005tJ-4A; Mon, 23 Oct 2023 12:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxam-0005Vv-JT
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1quxal-0002ge-41
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:15:48 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgG91WsYz6K6H6;
 Tue, 24 Oct 2023 00:13:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:15:43 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
 <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 15/17] hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in
 read/write functions
Date: Mon, 23 Oct 2023 17:08:04 +0100
Message-ID: <20231023160806.13206-16-Jonathan.Cameron@huawei.com>
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

From: Gregory Price <gourry.memverge@gmail.com>

Call CXL_TYPE3 once at top of function to avoid multiple invocations.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cc8220592f..a766c64575 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -888,17 +888,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
                            unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         qemu_guest_getrandom_nofail(data, size);
         return MEMTX_OK;
     }
@@ -909,17 +910,18 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
 MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
                             unsigned size, MemTxAttrs attrs)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
     uint64_t dpa_offset = 0;
     AddressSpace *as = NULL;
     int res;
 
-    res = cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
+    res = cxl_type3_hpa_to_as_and_dpa(ct3d, host_addr, size,
                                       &as, &dpa_offset);
     if (res) {
         return MEMTX_ERROR;
     }
 
-    if (sanitize_running(&CXL_TYPE3(d)->cci)) {
+    if (sanitize_running(&ct3d->cci)) {
         return MEMTX_OK;
     }
 
-- 
2.39.2


