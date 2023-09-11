Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B679A7AB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffKZ-0005rh-Db; Mon, 11 Sep 2023 07:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qffKW-0005rQ-Uz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:43:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qffKU-000210-PB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:43:48 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RklDw00Vkz67FSP;
 Mon, 11 Sep 2023 19:42:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 12:43:44 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <linux-cxl@vger.kernel.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH v3 1/4] hw/cxl: Push cxl_decoder_count_enc() and
 cxl_decode_ig() into .c
Date: Mon, 11 Sep 2023 12:43:10 +0100
Message-ID: <20230911114313.6144-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

There is no strong justification for keeping these in the header
so push them down into the associated cxl-component-utils.c file.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 18 ++----------------
 hw/cxl/cxl-component-utils.c   | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 42c7e581a7..bdb3881a6b 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -225,26 +225,12 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 enum reg_type cxl_dev_type, uint16_t length,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
-static inline int cxl_decoder_count_enc(int count)
-{
-    switch (count) {
-    case 1: return 0;
-    case 2: return 1;
-    case 4: return 2;
-    case 6: return 3;
-    case 8: return 4;
-    case 10: return 5;
-    }
-    return 0;
-}
+int cxl_decoder_count_enc(int count);
 
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
-static inline hwaddr cxl_decode_ig(int ig)
-{
-    return 1ULL << (ig + 8);
-}
+hwaddr cxl_decode_ig(int ig);
 
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
 bool cxl_get_hb_passthrough(PCIHostState *hb);
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 378f1082ce..ea2d4770ec 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,6 +13,24 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+int cxl_decoder_count_enc(int count)
+{
+    switch (count) {
+    case 1: return 0;
+    case 2: return 1;
+    case 4: return 2;
+    case 6: return 3;
+    case 8: return 4;
+    case 10: return 5;
+    }
+    return 0;
+}
+
+hwaddr cxl_decode_ig(int ig)
+{
+    return 1ULL << (ig + 8);
+}
+
 static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
                                        unsigned size)
 {
-- 
2.39.2


