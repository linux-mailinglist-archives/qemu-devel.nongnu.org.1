Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1489F2851
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 02:59:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0LV-0006I6-Bf; Sun, 15 Dec 2024 20:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0LL-0006G5-Cr
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0LI-0007lk-FE
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:19 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeC9iF9nfEBXAA--.18573S3;
 Mon, 16 Dec 2024 09:56:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S4;
 Mon, 16 Dec 2024 09:56:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 02/18] include: Move struct LoongArchPCHPIC to
 loongarch_pic_common header file
Date: Mon, 16 Dec 2024 09:55:51 +0800
Message-Id: <20241216015607.1795880-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Move structure LoongArchPCHPIC from header file loongarch_pch_pic.h
to file loongarch_pic_common.h, and rename structure name with
LoongArchPICCommonState.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongarch_pch_pic.h    | 27 +------------------------
 include/hw/intc/loongarch_pic_common.h | 28 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 861b32313b..381accbf2b 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -10,34 +10,9 @@
 
 #include "hw/intc/loongarch_pic_common.h"
 
+#define LoongArchPCHPIC LoongArchPICCommonState
 #define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
 #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
 
-struct LoongArchPCHPIC {
-    SysBusDevice parent_obj;
-    qemu_irq parent_irq[64];
-    uint64_t int_mask; /*0x020 interrupt mask register*/
-    uint64_t htmsi_en; /*0x040 1=msi*/
-    uint64_t intedge; /*0x060 edge=1 level  =0*/
-    uint64_t intclr; /*0x080 for clean edge int,set 1 clean,set 0 is noused*/
-    uint64_t auto_crtl0; /*0x0c0*/
-    uint64_t auto_crtl1; /*0x0e0*/
-    uint64_t last_intirr;    /* edge detection */
-    uint64_t intirr; /* 0x380 interrupt request register */
-    uint64_t intisr; /* 0x3a0 interrupt service register */
-    /*
-     * 0x3e0 interrupt level polarity selection
-     * register 0 for high level trigger
-     */
-    uint64_t int_polarity;
-
-    uint8_t route_entry[64]; /*0x100 - 0x138*/
-    uint8_t htmsi_vector[64]; /*0x200 - 0x238*/
-
-    MemoryRegion iomem32_low;
-    MemoryRegion iomem32_high;
-    MemoryRegion iomem8;
-    unsigned int irq_num;
-};
 #endif /* HW_LOONGARCH_PCH_PIC_H */
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index 6d0e33e1ac..124bb7d226 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -39,4 +39,32 @@
 #define STATUS_HI_START                 0x4
 #define POL_LO_START                    0x40
 #define POL_HI_START                    0x44
+
+struct LoongArchPICCommonState {
+    SysBusDevice parent_obj;
+
+    qemu_irq parent_irq[64];
+    uint64_t int_mask;        /* 0x020 interrupt mask register */
+    uint64_t htmsi_en;        /* 0x040 1=msi */
+    uint64_t intedge;         /* 0x060 edge=1 level=0 */
+    uint64_t intclr;          /* 0x080 clean edge int, set 1 clean, 0 noused */
+    uint64_t auto_crtl0;      /* 0x0c0 */
+    uint64_t auto_crtl1;      /* 0x0e0 */
+    uint64_t last_intirr;     /* edge detection */
+    uint64_t intirr;          /* 0x380 interrupt request register */
+    uint64_t intisr;          /* 0x3a0 interrupt service register */
+    /*
+     * 0x3e0 interrupt level polarity selection
+     * register 0 for high level trigger
+     */
+    uint64_t int_polarity;
+
+    uint8_t route_entry[64];  /* 0x100 - 0x138 */
+    uint8_t htmsi_vector[64]; /* 0x200 - 0x238 */
+
+    MemoryRegion iomem32_low;
+    MemoryRegion iomem32_high;
+    MemoryRegion iomem8;
+    unsigned int irq_num;
+};
 #endif  /* HW_LOONGARCH_PIC_COMMON_H */
-- 
2.43.5


