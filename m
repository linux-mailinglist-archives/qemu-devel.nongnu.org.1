Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F207971D7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDJi-0000Op-GO; Thu, 07 Sep 2023 07:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qeDJa-0000Gd-8G
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:36:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qeDJX-0002We-OK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:36:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RhHGv4l1Bz6HJlG;
 Thu,  7 Sep 2023 19:35:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 12:36:44 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>
Subject: [PATCH v2 2/3] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Date: Thu, 7 Sep 2023 12:35:42 +0100
Message-ID: <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

As an encoded version of these key configuration parameters is available
in a register, provide functions to extract it again so as to avoid
the need for duplicating the storage.

Whilst here update the _enc() function to include additional values
as defined in the CXL 3.0 specification. Whilst they are not
currently used in the emulation, they may be in future and it is
easier to compare with the specification if all values are covered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Thanks to Philippe Mathieu-Daudé
 - Expand both enc() and dec() functions to include full set of values
   defined in CXL r3.0
 - Pushed implementation down into the .c file.
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 59 ++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index bdb3881a6b..ef9e033919 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -226,8 +226,10 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
 int cxl_decoder_count_enc(int count);
+int cxl_decoder_count_dec(int enc_cnt);
 
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
 hwaddr cxl_decode_ig(int ig);
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index ea2d4770ec..352d0dace2 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,15 +13,45 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+/* CXL r3.0 Section 8.2.4.19.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
 {
     switch (count) {
-    case 1: return 0;
-    case 2: return 1;
-    case 4: return 2;
-    case 6: return 3;
-    case 8: return 4;
-    case 10: return 5;
+    case 1: return 0x0;
+    case 2: return 0x1;
+    case 4: return 0x2;
+    case 6: return 0x3;
+    case 8: return 0x4;
+    case 10: return 0x5;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 12: return 0x6;
+    case 14: return 0x7;
+    case 16: return 0x8;
+    case 20: return 0x9;
+    case 24: return 0xa;
+    case 28: return 0xb;
+    case 32: return 0xc;
+    }
+    return 0;
+}
+
+int cxl_decoder_count_dec(int enc_cnt)
+{
+    switch (enc_cnt) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 6;
+    case 0x4: return 8;
+    case 0x5: return 10;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 0x6: return 12;
+    case 0x7: return 14;
+    case 0x8: return 16;
+    case 0x9: return 20;
+    case 0xa: return 24;
+    case 0xb: return 28;
+    case 0xc: return 32;
     }
     return 0;
 }
@@ -410,6 +440,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
     }
 }
 
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
+{
+    switch (iw_enc) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 8;
+    case 0x4: return 16;
+    case 0x8: return 3;
+    case 0x9: return 6;
+    case 0xa: return 12;
+    default:
+        error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
+        return 0;
+    }
+}
+
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
 {
     switch (gran) {
-- 
2.39.2


