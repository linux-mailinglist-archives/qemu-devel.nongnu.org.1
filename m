Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F7A3F6B9
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:03:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbM-0008Qn-4e; Fri, 21 Feb 2025 09:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWv-0006Wj-AF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:05 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWs-000175-Nf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:05 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id E48322053679; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E48322053679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=NAV5De61Rnf9i8r9pTLLPWYBriI7vC/J7U9MSRQKY9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cTnE/XRgyvvcVSAnelFxiFhB2Nk8dX/Exhmm5S2/VNNt+TNl7pH9+6SuN5N2/8sXO
 k3Y4V+D4kgUgGLKwsTnvde30iXicP4wIfaVjS7beTogMUmzfT4mDIyLiZf6x68i2Dy
 Ab2Owkb5i3e+eMArdNmxs2EwG09R6a02A56ynsv0=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 13/19] target/i386: rename lazy flags field and its type
Date: Fri, 21 Feb 2025 00:36:21 -0800
Message-Id: <1740126987-8483-14-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:12 -0500
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

The same structure and code can be used by other accelerators. Drop
the hvf prefix in the type and field name.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/cpu.h           |  6 ++--
 target/i386/hvf/x86_flags.c | 56 ++++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bfdb1f87a3..00bb2ed79a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1772,10 +1772,10 @@ typedef struct CPUCaches {
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 
-typedef struct HVFX86LazyFlags {
+typedef struct X86LazyFlags {
     target_ulong result;
     target_ulong auxbits;
-} HVFX86LazyFlags;
+} X86LazyFlags;
 
 typedef struct CPUArchState {
     /* standard registers */
@@ -2069,7 +2069,7 @@ typedef struct CPUArchState {
     QemuMutex xen_timers_lock;
 #endif
 #if defined(CONFIG_HVF)
-    HVFX86LazyFlags hvf_lflags;
+    X86LazyFlags lflags;
     void *mmio_buf;
 #endif
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 03d6de5efc..3c02c9c563 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -62,7 +62,7 @@
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
     target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
     (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
     if ((size) == 32) { \
         temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
     } else if ((size) == 16) { \
@@ -72,7 +72,7 @@
     } else { \
         VM_PANIC("unimplemented");  \
     } \
-    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)temp; \
+    env->lflags.auxbits = (target_ulong)(uint32_t)temp; \
 }
 
 /* carries, result */
@@ -99,10 +99,10 @@
     } else { \
         VM_PANIC("unimplemented");      \
     } \
-    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong delta_c = (env->hvf_lflags.auxbits ^ temp) & LF_MASK_CF; \
+    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong delta_c = (env->lflags.auxbits ^ temp) & LF_MASK_CF; \
     delta_c ^= (delta_c >> 1); \
-    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
+    env->lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
 }
 
 /* carries, result */
@@ -116,8 +116,8 @@
 void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
 {
     uint32_t temp_po = new_of ^ new_cf;
-    env->hvf_lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
-    env->hvf_lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
+    env->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
+    env->lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
 }
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
@@ -213,27 +213,27 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
 
 bool get_PF(CPUX86State *env)
 {
-    uint32_t temp = (255 & env->hvf_lflags.result);
-    temp = temp ^ (255 & (env->hvf_lflags.auxbits >> LF_BIT_PDB));
+    uint32_t temp = (255 & env->lflags.result);
+    temp = temp ^ (255 & (env->lflags.auxbits >> LF_BIT_PDB));
     temp = (temp ^ (temp >> 4)) & 0x0F;
     return (0x9669U >> temp) & 1;
 }
 
 void set_PF(CPUX86State *env, bool val)
 {
-    uint32_t temp = (255 & env->hvf_lflags.result) ^ (!val);
-    env->hvf_lflags.auxbits &= ~(LF_MASK_PDB);
-    env->hvf_lflags.auxbits |= (temp << LF_BIT_PDB);
+    uint32_t temp = (255 & env->lflags.result) ^ (!val);
+    env->lflags.auxbits &= ~(LF_MASK_PDB);
+    env->lflags.auxbits |= (temp << LF_BIT_PDB);
 }
 
 bool get_OF(CPUX86State *env)
 {
-    return ((env->hvf_lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
+    return ((env->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return (env->hvf_lflags.auxbits >> LF_BIT_CF) & 1;
+    return (env->lflags.auxbits >> LF_BIT_CF) & 1;
 }
 
 void set_OF(CPUX86State *env, bool val)
@@ -250,45 +250,45 @@ void set_CF(CPUX86State *env, bool val)
 
 bool get_AF(CPUX86State *env)
 {
-    return (env->hvf_lflags.auxbits >> LF_BIT_AF) & 1;
+    return (env->lflags.auxbits >> LF_BIT_AF) & 1;
 }
 
 void set_AF(CPUX86State *env, bool val)
 {
-    env->hvf_lflags.auxbits &= ~(LF_MASK_AF);
-    env->hvf_lflags.auxbits |= val << LF_BIT_AF;
+    env->lflags.auxbits &= ~(LF_MASK_AF);
+    env->lflags.auxbits |= val << LF_BIT_AF;
 }
 
 bool get_ZF(CPUX86State *env)
 {
-    return !env->hvf_lflags.result;
+    return !env->lflags.result;
 }
 
 void set_ZF(CPUX86State *env, bool val)
 {
     if (val) {
-        env->hvf_lflags.auxbits ^=
-         (((env->hvf_lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
+        env->lflags.auxbits ^=
+         (((env->lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
         /* merge the parity bits into the Parity Delta Byte */
-        uint32_t temp_pdb = (255 & env->hvf_lflags.result);
-        env->hvf_lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
+        uint32_t temp_pdb = (255 & env->lflags.result);
+        env->lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
         /* now zero the .result value */
-        env->hvf_lflags.result = 0;
+        env->lflags.result = 0;
     } else {
-        env->hvf_lflags.result |= (1 << 8);
+        env->lflags.result |= (1 << 8);
     }
 }
 
 bool get_SF(CPUX86State *env)
 {
-    return ((env->hvf_lflags.result >> LF_SIGN_BIT) ^
-            (env->hvf_lflags.auxbits >> LF_BIT_SD)) & 1;
+    return ((env->lflags.result >> LF_SIGN_BIT) ^
+            (env->lflags.auxbits >> LF_BIT_SD)) & 1;
 }
 
 void set_SF(CPUX86State *env, bool val)
 {
     bool temp_sf = get_SF(env);
-    env->hvf_lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
+    env->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
 }
 
 void lflags_to_rflags(CPUX86State *env)
@@ -303,7 +303,7 @@ void lflags_to_rflags(CPUX86State *env)
 
 void rflags_to_lflags(CPUX86State *env)
 {
-    env->hvf_lflags.auxbits = env->hvf_lflags.result = 0;
+    env->lflags.auxbits = env->lflags.result = 0;
     set_OF(env, env->eflags & CC_O);
     set_SF(env, env->eflags & CC_S);
     set_ZF(env, env->eflags & CC_Z);
-- 
2.39.5 (Apple Git-154)


