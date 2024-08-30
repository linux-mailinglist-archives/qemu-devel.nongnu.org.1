Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949EC966921
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 20:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk6eq-000836-Iw; Fri, 30 Aug 2024 14:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sk6ea-0007xE-Fz; Fri, 30 Aug 2024 14:47:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sk6eX-00023K-4h; Fri, 30 Aug 2024 14:47:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwRrC025wz6L6td;
 Sat, 31 Aug 2024 02:43:55 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 8CAB414038F;
 Sat, 31 Aug 2024 02:47:14 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.73.222) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 19:47:14 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <linuxarm@huawei.com>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@Huawei.com>, <jiangkunkun@huawei.com>
Subject: [PATCH v2] target/arm/tcg: refine cache descriptions with a wrapper
Date: Fri, 30 Aug 2024 19:47:13 +0100
Message-ID: <20240830184713.224-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.73.222]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch allows for easier manipulation of the cache description
register, CCSIDR. Which is helpful for testing as well. Currently
numbers get hard-coded and might be prone to errors.

Therefore, this patch adds wrappers for different types of CPUs
available in tcg to decribe caches. Two functions `make_ccsidr32` and
`make_ccsidr64` describing descriptions. The 32 bit version receives
extra parameters that became unknown later in 64 bit.

For CCSIDR register, 32 bit version follows specification [1].
Conversely, 64 bit version follows specification [2].

[1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
edition, https://developer.arm.com/documentation/ddi0406
[2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
https://developer.arm.com/documentation/ddi0487/latest/

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
 target/arm/cpu64.c        | 19 ++++++---
 target/arm/tcg/cpu64.c    | 86 ++++++++++++++++++---------------------
 3 files changed, 105 insertions(+), 53 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c59ca104fe..00a0f0d963 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1022,6 +1022,59 @@ static inline bool isar_feature_any_evt(const ARMISARegisters *id)
     return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
 }
 
+static inline uint64_t make_ccsidr32(unsigned assoc, unsigned linesize,
+                                     unsigned cachesize, uint8_t flags)
+{
+    unsigned lg_linesize = ctz32(linesize);
+    unsigned sets;
+
+    /*
+     * The 32-bit CCSIDR_EL1 format is:
+     *   [27:13] number of sets - 1
+     *   [12:3]  associativity - 1
+     *   [2:0]   log2(linesize) - 4
+     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+     */
+    assert(assoc != 0);
+    assert(is_power_of_2(linesize));
+    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
+
+    /* sets * associativity * linesize == cachesize. */
+    sets = cachesize / (assoc * linesize);
+    assert(cachesize % (assoc * linesize) == 0);
+
+    return ((uint64_t)(flags) << 28)
+        | ((sets - 1) << 13)
+        | ((assoc - 1) << 3)
+        | (lg_linesize - 4);
+}
+
+static inline uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
+                              unsigned cachesize)
+{
+    unsigned lg_linesize = ctz32(linesize);
+    unsigned sets;
+
+    /*
+     * The 64-bit CCSIDR_EL1 format is:
+     *   [55:32] number of sets - 1
+     *   [23:3]  associativity - 1
+     *   [2:0]   log2(linesize) - 4
+     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+     */
+    assert(assoc != 0);
+    assert(is_power_of_2(linesize));
+    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
+
+    /* sets * associativity * linesize == cachesize. */
+    sets = cachesize / (assoc * linesize);
+    assert(cachesize % (assoc * linesize) == 0);
+
+    return ((uint64_t)(sets - 1) << 32)
+         | ((assoc - 1) << 3)
+         | (lg_linesize - 4);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 262a1d6c0b..57ebc1b979 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
+#include "qemu/units.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/qtest.h"
@@ -642,9 +643,12 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
+    /* 48KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(3, 64, 48 * KiB, 2);
+    /* 2048KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 64, 2 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -700,9 +704,12 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x1;
     cpu->isar.reset_pmcr_el0 = 0x41033000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe07a; /* 1024KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(1, 64, 32 * KiB, 2);
+    /* 1024KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 64, 1 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fe232eb306..85d8b1a5b4 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -29,32 +29,6 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 
-static uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
-                              unsigned cachesize)
-{
-    unsigned lg_linesize = ctz32(linesize);
-    unsigned sets;
-
-    /*
-     * The 64-bit CCSIDR_EL1 format is:
-     *   [55:32] number of sets - 1
-     *   [23:3]  associativity - 1
-     *   [2:0]   log2(linesize) - 4
-     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
-     */
-    assert(assoc != 0);
-    assert(is_power_of_2(linesize));
-    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
-
-    /* sets * associativity * linesize == cachesize. */
-    sets = cachesize / (assoc * linesize);
-    assert(cachesize % (assoc * linesize) == 0);
-
-    return ((uint64_t)(sets - 1) << 32)
-         | ((assoc - 1) << 3)
-         | (lg_linesize - 4);
-}
-
 static void aarch64_a35_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -106,9 +80,12 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x410a3000;
 
     /* From B2.29 Cache ID registers */
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x703fe03a; /* 512KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(4, 64, 32 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 64, 512 * KiB, 7);
 
     /* From B3.5 VGIC Type register */
     cpu->gic_num_lrs = 4;
@@ -272,9 +249,12 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.23 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x200fe01a; /* 32KB L1 icache */
-    cpu->ccsidr[2] = 0x703fe07a; /* 512KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
+    /* 32KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(4, 64, 32 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 64, 512 * KiB, 7);
 
     /* From B2.96 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -338,9 +318,12 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41023000;
     cpu->clidr = 0x0a200023;
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
+    /* 48KB L1 dcache */
+    cpu->ccsidr[1] = make_ccsidr32(3, 64, 48 * KiB, 2);
+    /* 1MB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 64, 1 * MiB, 7);
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -397,9 +380,12 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.18 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x701fe01a; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe01a; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x707fe03a; /* 512KB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(4, 64, 64 * KiB, 2);
+    /* 512KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(8, 64, 512 * KiB, 7);
 
     /* From B2.93 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -449,9 +435,12 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = 0x0000000000010001;
     cpu->isar.id_aa64zfr0 = 0x0000000000000000;
     cpu->clidr = 0x0000000080000023;
-    cpu->ccsidr[0] = 0x7007e01c; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x2007e01c; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07c; /* 8MB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 256, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(4, 256, 64 * KiB, 2);
+    /* 8MB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr32(16, 256, 8 * MiB, 7);
     cpu->dcz_blocksize = 6; /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -637,9 +626,12 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->revidr = 0;
 
     /* From B2.23 CCSIDR_EL1 */
-    cpu->ccsidr[0] = 0x701fe01a; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe01a; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe03a; /* 1MB L2 cache */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr32(4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr32(4, 64, 64 * KiB, 2);
+    /* 1MB L2 dcache */
+    cpu->ccsidr[2] = make_ccsidr32(8, 64, 1 * MiB, 7);
 
     /* From B2.98 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -721,9 +713,9 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * L2: 8-way set associative, 64 byte line size, either 512K or 1MB.
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
-    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB); /* L1 dcache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];                 /* L1 icache */
-    cpu->ccsidr[2] = make_ccsidr64(8, 64, 1 * MiB);  /* L2 cache */
+    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB); /* 64KB L1 dcache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];                 /* 64KB L1 icache */
+    cpu->ccsidr[2] = make_ccsidr64(8, 64, 1 * MiB);  /* 1MB L2 cache */
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
-- 
2.34.1


