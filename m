Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FF706225
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6w-0003A4-RD; Wed, 17 May 2023 04:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6h-0002jM-PN; Wed, 17 May 2023 04:01:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6f-0000lf-CM; Wed, 17 May 2023 04:01:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19BA26768;
 Wed, 17 May 2023 11:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9D8255E20;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: (nullmailer pid 3624172 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v8.0.1 31/36] target/arm: Correct AArch64.S2MinTxSZ 32-bit EL1
 input size check
Date: Wed, 17 May 2023 11:00:51 +0300
Message-Id: <20230517080056.3623993-31-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In check_s2_mmu_setup() we have a check that is attempting to
implement the part of AArch64.S2MinTxSZ that is specific to when EL1
is AArch32:

    if !s1aarch64 then
        // EL1 is AArch32
        min_txsz = Min(min_txsz, 24);

Unfortunately we got this wrong in two ways:

(1) The minimum txsz corresponds to a maximum inputsize, but we got
the sense of the comparison wrong and were faulting for all
inputsizes less than 40 bits

(2) We try to implement this as an extra check that happens after
we've done the same txsz checks we would do for an AArch64 EL1, but
in fact the pseudocode is *loosening* the requirements, so that txsz
values that would fault for an AArch64 EL1 do not fault for AArch32
EL1, because it does Min(old_min, 24), not Max(old_min, 24).

You can see this also in the text of the Arm ARM in table D8-8, which
shows that where the implemented PA size is less than 40 bits an
AArch32 EL1 is still OK with a configured stage2 T0SZ for a 40 bit
IPA, whereas if EL1 is AArch64 then the T0SZ must be big enough to
constrain the IPA to the implemented PA size.

Because of part (2), we can't do this as a separate check, but
have to integrate it into aa64_va_parameters(). Add a new argument
to that function to indicate that EL1 is 32-bit. All the existing
callsites except the one in get_phys_addr_lpae() can pass 'false',
because they are either doing a lookup for a stage 1 regime or
else they don't care about the tsz/tsz_oob fields.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1627
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230509092059.3176487-1-peter.maydell@linaro.org
(cherry picked from commit 478dccbb99db0bf8f00537dd0b4d0de88d5cb537)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/arm/gdbstub64.c        |  2 +-
 target/arm/helper.c           | 15 +++++++++++++--
 target/arm/internals.h        | 12 +++++++++++-
 target/arm/ptw.c              | 14 ++------------
 target/arm/tcg/pauth_helper.c |  6 +++---
 5 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index c1f7e8c934..d7b79a6589 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -233,7 +233,7 @@ int aarch64_gdb_get_pauth_reg(CPUARMState *env, GByteArray *buf, int reg)
             ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
             ARMVAParameters param;
 
-            param = aa64_va_parameters(env, -is_high, mmu_idx, is_data);
+            param = aa64_va_parameters(env, -is_high, mmu_idx, is_data, false);
             return gdb_get_reg64(buf, pauth_ptr_mask(param));
         }
     default:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2297626bfb..0b7fd2e7e6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4904,7 +4904,7 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     unsigned int page_size_granule, page_shift, num, scale, exponent;
     /* Extract one bit to represent the va selector in use. */
     uint64_t select = sextract64(value, 36, 1);
-    ARMVAParameters param = aa64_va_parameters(env, select, mmuidx, true);
+    ARMVAParameters param = aa64_va_parameters(env, select, mmuidx, true, false);
     TLBIRange ret = { };
     ARMGranuleSize gran;
 
@@ -11193,7 +11193,8 @@ static ARMGranuleSize sanitize_gran_size(ARMCPU *cpu, ARMGranuleSize gran,
 }
 
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data)
+                                   ARMMMUIdx mmu_idx, bool data,
+                                   bool el1_is_aa32)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     bool epd, hpd, tsz_oob, ds, ha, hd;
@@ -11289,6 +11290,16 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         }
     }
 
+    if (stage2 && el1_is_aa32) {
+        /*
+         * For AArch32 EL1 the min txsz (and thus max IPA size) requirements
+         * are loosened: a configured IPA of 40 bits is permitted even if
+         * the implemented PA is less than that (and so a 40 bit IPA would
+         * fault for an AArch64 EL1). See R_DTLMN.
+         */
+        min_tsz = MIN(min_tsz, 24);
+    }
+
     if (tsz > max_tsz) {
         tsz = max_tsz;
         tsz_oob = true;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c2c70d5918..f82b3db411 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1091,8 +1091,18 @@ typedef struct ARMVAParameters {
     ARMGranuleSize gran : 2;
 } ARMVAParameters;
 
+/**
+ * aa64_va_parameters: Return parameters for an AArch64 virtual address
+ * @env: CPU
+ * @va: virtual address to look up
+ * @mmu_idx: determines translation regime to use
+ * @data: true if this is a data access
+ * @el1_is_aa32: true if we are asking about stage 2 when EL1 is AArch32
+ *  (ignored if @mmu_idx is for a stage 1 regime; only affects tsz/tsz_oob)
+ */
 ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
-                                   ARMMMUIdx mmu_idx, bool data);
+                                   ARMMMUIdx mmu_idx, bool data,
+                                   bool el1_is_aa32);
 
 int aa64_va_parameter_tbi(uint64_t tcr, ARMMMUIdx mmu_idx);
 int aa64_va_parameter_tbid(uint64_t tcr, ARMMMUIdx mmu_idx);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 00399a2e9c..48f5992348 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1122,17 +1122,6 @@ static int check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, uint64_t tcr,
 
     sl0 = extract32(tcr, 6, 2);
     if (is_aa64) {
-        /*
-         * AArch64.S2InvalidTxSZ: While we checked tsz_oob near the top of
-         * get_phys_addr_lpae, that used aa64_va_parameters which apply
-         * to aarch64.  If Stage1 is aarch32, the min_txsz is larger.
-         * See AArch64.S2MinTxSZ, where min_tsz is 24, translated to
-         * inputsize is 64 - 24 = 40.
-         */
-        if (iasize < 40 && !arm_el_is_aa64(&cpu->env, 1)) {
-            goto fail;
-        }
-
         /*
          * AArch64.S2InvalidSL: Interpretation of SL depends on the page size,
          * so interleave AArch64.S2StartLevel.
@@ -1272,7 +1261,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int ps;
 
         param = aa64_va_parameters(env, address, mmu_idx,
-                                   access_type != MMU_INST_FETCH);
+                                   access_type != MMU_INST_FETCH,
+                                   !arm_el_is_aa64(env, 1));
         level = 0;
 
         /*
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index de067fa716..62af569341 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -293,7 +293,7 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                              ARMPACKey *key, bool data)
 {
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
-    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
     uint64_t pac, ext_ptr, ext, test;
     int bot_bit, top_bit;
 
@@ -355,7 +355,7 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
                            ARMPACKey *key, bool data, int keynumber)
 {
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
-    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
     int bot_bit, top_bit;
     uint64_t pac, orig_ptr, test;
 
@@ -379,7 +379,7 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
 static uint64_t pauth_strip(CPUARMState *env, uint64_t ptr, bool data)
 {
     ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
-    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data);
+    ARMVAParameters param = aa64_va_parameters(env, ptr, mmu_idx, data, false);
 
     return pauth_original_ptr(ptr, param);
 }
-- 
2.39.2


