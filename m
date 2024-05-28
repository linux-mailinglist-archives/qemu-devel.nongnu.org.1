Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9818D166A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 10:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsMO-0002iM-TS; Tue, 28 May 2024 04:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sBsMM-0002ho-Ly
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sBsMK-0004oW-Qf
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:06 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxOuolmFVmp5wAAA--.2500S3;
 Tue, 28 May 2024 16:39:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxosQfmFVmQcYLAA--.20131S4; 
 Tue, 28 May 2024 16:39:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] hw/loongarch/virt: Use MemTxAttrs interface for misc
 ops
Date: Tue, 28 May 2024 16:38:54 +0800
Message-Id: <20240528083855.1912757-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240528083855.1912757-1-gaosong@loongson.cn>
References: <20240528083855.1912757-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxosQfmFVmQcYLAA--.20131S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Use MemTxAttrs interface read_with_attrs/write_with_attrs
for virt_iocsr_misc_ops.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4db0d82dbd..a70eeda2fd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -899,37 +899,49 @@ static void virt_firmware_init(LoongArchVirtMachineState *lvms)
 }
 
 
-static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
-                                  uint64_t val, unsigned size)
+static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size,
+                                         MemTxAttrs attrs)
 {
+    return MEMTX_OK;
 }
 
-static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
+                                        uint64_t *data,
+                                        unsigned size, MemTxAttrs attrs)
 {
-    uint64_t ret;
+    uint64_t ret = 0;
 
     switch (addr) {
     case VERSION_REG:
-        return 0x11ULL;
+        ret = 0x11ULL;
+        break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
-        return ret;
+        break;
     case VENDOR_REG:
-        return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        ret = 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        break;
     case CPUNAME_REG:
-        return 0x303030354133ULL;     /* "3A5000" */
+        ret = 0x303030354133ULL;     /* "3A5000" */
+        break;
     case MISC_FUNC_REG:
-        return BIT_ULL(IOCSRM_EXTIOI_EN);
+        ret = BIT_ULL(IOCSRM_EXTIOI_EN);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    return 0ULL;
+
+    *data = ret;
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps virt_iocsr_misc_ops = {
-    .read  = virt_iocsr_misc_read,
-    .write = virt_iocsr_misc_write,
+    .read_with_attrs  = virt_iocsr_misc_read,
+    .write_with_attrs = virt_iocsr_misc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-- 
2.34.1


