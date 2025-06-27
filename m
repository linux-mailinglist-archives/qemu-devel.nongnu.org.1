Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E385AEAD4D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 05:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzhd-0005Eu-BM; Thu, 26 Jun 2025 23:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uUzha-0005E1-Qm
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uUzhX-00065S-SO
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxWXHnDl5onAgeAQ--.1819S3;
 Fri, 27 Jun 2025 11:24:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XiDl5oz10sAQ--.3598S3;
 Fri, 27 Jun 2025 11:24:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v3 1/9] hw/loongarch: move some machine define to virt.h
Date: Fri, 27 Jun 2025 11:01:30 +0800
Message-Id: <20250627030138.2482055-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250627030138.2482055-1-gaosong@loongson.cn>
References: <20250627030138.2482055-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XiDl5oz10sAQ--.3598S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

move som machine define to virt.h and define avec feature and status bit.
Use the IOCSRF_AVEC bit for avdance interrupt controller drivers
avecintc_enable[1] and set the default value of the MISC_FUNC_REG bit IOCSRM_AVEC_EN.
and set the default value of the MISC_FUNC_REG bit IOCSRM_AVEC_EN.

[1]:https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-loongarch-avec.c

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c         |  4 ++++
 include/hw/loongarch/virt.h | 20 ++++++++++++++++++++
 target/loongarch/cpu.h      | 21 ---------------------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b15ada2078..6a169d4824 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -574,6 +574,8 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
+        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
+        ret |= BIT(IOCSRF_AVEC);
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
@@ -603,6 +605,8 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
         }
+        /* enable avec default */
+        ret |= BIT_ULL(IOCSRM_AVEC_EN);
         break;
     default:
         g_assert_not_reached();
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 602feab0f0..cc6656619d 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -13,6 +13,26 @@
 #include "hw/block/flash.h"
 #include "hw/loongarch/boot.h"
 
+#define IOCSRF_TEMP             0
+#define IOCSRF_NODECNT          1
+#define IOCSRF_MSI              2
+#define IOCSRF_EXTIOI           3
+#define IOCSRF_CSRIPI           4
+#define IOCSRF_FREQCSR          5
+#define IOCSRF_FREQSCALE        6
+#define IOCSRF_DVFSV1           7
+#define IOCSRF_GMOD             9
+#define IOCSRF_VM               11
+#define IOCSRF_AVEC             15
+
+#define VERSION_REG             0x0
+#define FEATURE_REG             0x8
+#define VENDOR_REG              0x10
+#define CPUNAME_REG             0x20
+#define MISC_FUNC_REG           0x420
+#define IOCSRM_EXTIOI_EN        48
+#define IOCSRM_EXTIOI_INT_ENCODE 49
+#define IOCSRM_AVEC_EN           51
 #define LOONGARCH_MAX_CPUS      256
 
 #define VIRT_FWCFG_BASE         0x1e020000UL
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9538e8d61d..56fc4a1459 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -21,27 +21,6 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
 
-#define IOCSRF_TEMP             0
-#define IOCSRF_NODECNT          1
-#define IOCSRF_MSI              2
-#define IOCSRF_EXTIOI           3
-#define IOCSRF_CSRIPI           4
-#define IOCSRF_FREQCSR          5
-#define IOCSRF_FREQSCALE        6
-#define IOCSRF_DVFSV1           7
-#define IOCSRF_GMOD             9
-#define IOCSRF_VM               11
-
-#define VERSION_REG             0x0
-#define FEATURE_REG             0x8
-#define VENDOR_REG              0x10
-#define CPUNAME_REG             0x20
-#define MISC_FUNC_REG           0x420
-#define IOCSRM_EXTIOI_EN        48
-#define IOCSRM_EXTIOI_INT_ENCODE 49
-
-#define IOCSR_MEM_SIZE          0x428
-
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
-- 
2.34.1


