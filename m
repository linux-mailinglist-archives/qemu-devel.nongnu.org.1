Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FE70DEDE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST0-000667-Rh; Tue, 23 May 2023 09:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSE-0004Nt-7F
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSA-00030g-DI
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d2b42a8f9so4267584b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850009; x=1687442009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HxoP9990OHDYwNOE0anIjEZqeR9eEOPQW77YwWr1n2g=;
 b=CiVjx6Bvt1MQL6FvqAXZW3RFOJboT0fws4N9DOVUWfkU9urFNk4kFwnrFL4QQ90/i7
 VcB/MFFMlvZM/mhzgNePOzKhs1YKHnT/+x73fqf5T84aVQWPUjCMS2bPdWVFblKZ85v3
 7N765LYgw2Q5I5fgUX82tmoeDsa/YsR6NwmcCBcWXi3HDqndpk3mI/IRo0xqNnqcJ5r7
 CFwLYDcnRSsddRdrI29PYvnEj+xRdLnK1ieC3f1PFoFDqxFfvywnEcyYWr0QrlFZJW7g
 k8lmKg3x732CLq75+bRl/uZc1WVpQ1tvpvSSD8WO47PlfXQkVArn8DIiTmhW0QGV3NCy
 cy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850009; x=1687442009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxoP9990OHDYwNOE0anIjEZqeR9eEOPQW77YwWr1n2g=;
 b=TWJbQs2BeF6amGEiBR4RDGH9Vl9YGbluqe+gDZPHsWlcl0pZYkavPufJIeUG8hhbzQ
 MGNbTyKzi6Wr3qLwAaTMIzUA1CUlfp/7m4hT/QKlsSbieaagjO2w0ks8Fxl5SDRM8c3c
 z8LqByQx6pbnm8JzErGSPO90zHoDx99eHNuJKbWO0a/F161AiJ9UzRhtEc0MDKCPWFEO
 EMPTE8AwHGyqxsR+3GmpK/zZ9hYUBXdJlpxyxyjguB8uDGVX86m1A7f1Sip4huIQ5IPg
 LaKcuc+W8Os7tZMqGSQJtIJOoKUdln/o4BetDwmq9+rUCLBRoghYg1jQz+2mSFIzyg6D
 rb0Q==
X-Gm-Message-State: AC+VfDxLgjXwgoQCdU23wzawp8P1dhhnjAMy4nj5l0BVaxCynsX0HPGx
 J/UY0fvonjuF9HZ8FS7NZ+WqdHnLV/ofxGcfFmY=
X-Google-Smtp-Source: ACHHUZ4dV5GSDXk6dAffbHsu2/u2LW5up4/lds4tPq+2+yxY5Dr9UGw8b56Q6zH/qyI9oHrheb+OdA==
X-Received: by 2002:a05:6a20:72a8:b0:10b:b166:8836 with SMTP id
 o40-20020a056a2072a800b0010bb1668836mr6772260pzk.47.1684850008864; 
 Tue, 23 May 2023 06:53:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/52] tcg: Widen CPUTLBEntry comparators to 64-bits
Date: Tue, 23 May 2023 06:52:36 -0700
Message-Id: <20230523135322.678948-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This makes CPUTLBEntry agnostic to the address size of the guest.
When 32-bit addresses are in effect, we can simply read the low
32 bits of the 64-bit field.  Similarly when we need to update
the field for setting TLB_NOTDIRTY.

For TCG backends that could in theory be big-endian, but in
practice are not (arm, loongarch, riscv), use QEMU_BUILD_BUG_ON
to document and ensure this is not accidentally missed.

For s390x, which is always big-endian, use HOST_BIG_ENDIAN anyway,
to document the reason for the adjustment.

For sparc64 and ppc64, always perform a 64-bit load, and rely on
the following 32-bit comparison to ignore the high bits.

Rearrange mips and ppc if ladders for clarity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h          | 37 +++++++++++---------------------
 include/exec/cpu_ldst.h          | 19 ++++++++++------
 accel/tcg/cputlb.c               |  8 +++++--
 tcg/aarch64/tcg-target.c.inc     |  1 +
 tcg/arm/tcg-target.c.inc         |  1 +
 tcg/loongarch64/tcg-target.c.inc |  1 +
 tcg/mips/tcg-target.c.inc        | 13 ++++++-----
 tcg/ppc/tcg-target.c.inc         | 28 +++++++++++++-----------
 tcg/riscv/tcg-target.c.inc       |  1 +
 tcg/s390x/tcg-target.c.inc       |  1 +
 tcg/sparc64/tcg-target.c.inc     |  8 +++++--
 11 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index a6e0cf1812..b757d37966 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -65,11 +65,7 @@
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
-#if HOST_LONG_BITS == 32 && TARGET_LONG_BITS == 32
-#define CPU_TLB_ENTRY_BITS 4
-#else
 #define CPU_TLB_ENTRY_BITS 5
-#endif
 
 #define CPU_TLB_DYN_MIN_BITS 6
 #define CPU_TLB_DYN_DEFAULT_BITS 8
@@ -95,33 +91,26 @@
 # endif
 
 /* Minimalized TLB entry for use by TCG fast path. */
-typedef struct CPUTLBEntry {
-    /* bit TARGET_LONG_BITS to TARGET_PAGE_BITS : virtual address
-       bit TARGET_PAGE_BITS-1..4  : Nonzero for accesses that should not
-                                    go directly to ram.
-       bit 3                      : indicates that the entry is invalid
-       bit 2..0                   : zero
-    */
-    union {
-        struct {
-            target_ulong addr_read;
-            target_ulong addr_write;
-            target_ulong addr_code;
-            /* Addend to virtual address to get host address.  IO accesses
-               use the corresponding iotlb value.  */
-            uintptr_t addend;
-        };
+typedef union CPUTLBEntry {
+    struct {
+        uint64_t addr_read;
+        uint64_t addr_write;
+        uint64_t addr_code;
         /*
-         * Padding to get a power of two size, as well as index
-         * access to addr_{read,write,code}.
+         * Addend to virtual address to get host address.  IO accesses
+         * use the corresponding iotlb value.
          */
-        target_ulong addr_idx[(1 << CPU_TLB_ENTRY_BITS) / TARGET_LONG_SIZE];
+        uintptr_t addend;
     };
+    /*
+     * Padding to get a power of two size, as well as index
+     * access to addr_{read,write,code}.
+     */
+    uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
 } CPUTLBEntry;
 
 QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
 
-
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 5939688f69..a43b34e46b 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -334,18 +334,25 @@ static inline target_ulong tlb_read_idx(const CPUTLBEntry *entry,
 {
     /* Do not rearrange the CPUTLBEntry structure members. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * TARGET_LONG_SIZE);
+                      MMU_DATA_LOAD * sizeof(uint64_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * TARGET_LONG_SIZE);
+                      MMU_DATA_STORE * sizeof(uint64_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * TARGET_LONG_SIZE);
+                      MMU_INST_FETCH * sizeof(uint64_t));
 
-    const target_ulong *ptr = &entry->addr_idx[access_type];
-#if TCG_OVERSIZED_GUEST
-    return *ptr;
+#if TARGET_LONG_BITS == 32
+    /* Use qatomic_read, in case of addr_write; only care about low bits. */
+    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
+    ptr += HOST_BIG_ENDIAN;
+    return qatomic_read(ptr);
 #else
+    const uint64_t *ptr = &entry->addr_idx[access_type];
+# if TCG_OVERSIZED_GUEST
+    return *ptr;
+# else
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
+# endif
 #endif
 }
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 90c72c9940..6beaeb0a81 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1000,11 +1000,15 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
         addr &= TARGET_PAGE_MASK;
         addr += tlb_entry->addend;
         if ((addr - start) < length) {
-#if TCG_OVERSIZED_GUEST
+#if TARGET_LONG_BITS == 32
+            uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
+            ptr_write += HOST_BIG_ENDIAN;
+            qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
+#elif TCG_OVERSIZED_GUEST
             tlb_entry->addr_write |= TLB_NOTDIRTY;
 #else
             qatomic_set(&tlb_entry->addr_write,
-                       tlb_entry->addr_write | TLB_NOTDIRTY);
+                        tlb_entry->addr_write | TLB_NOTDIRTY);
 #endif
         }
     }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 84283665e7..39bb47baec 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1674,6 +1674,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
 
     /* Load the tlb comparator into X0, and the fast path addend into X1.  */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     tcg_out_ld(s, addr_type, TCG_REG_X0, TCG_REG_X1,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 20cc1cc477..64eb0cb5dc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1430,6 +1430,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
      * Load the tlb comparator into R2/R3 and the fast path addend into R1.
      */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     if (cmp_off == 0) {
         if (s->addr_type == TCG_TYPE_I32) {
             tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 0bae922982..e89f3b848b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -875,6 +875,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
     /* Load the tlb comparator and the addend.  */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ef146b193c..26ed2a4e9b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1199,14 +1199,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* Add the tlb_table pointer, creating the CPUTLBEntry address in TMP3.  */
     tcg_out_opc_reg(s, ALIAS_PADD, TCG_TMP3, TCG_TMP3, TCG_TMP1);
 
+    if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
+        /* Load the (low half) tlb comparator.  */
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_TMP0, TCG_TMP3,
+                   cmp_off + HOST_BIG_ENDIAN * 4);
+    } else {
+        tcg_out_ld(s, TCG_TYPE_I64, TCG_TMP0, TCG_TMP3, cmp_off);
+    }
+
     if (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32) {
-        /* Load the tlb comparator.  */
-        tcg_out_ld(s, addr_type, TCG_TMP0, TCG_TMP3, cmp_off);
         /* Load the tlb addend for the fast path.  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP3, TCG_TMP3, add_off);
-    } else {
-        /* Load the low half of the tlb comparator.  */
-        tcg_out_ldst(s, OPC_LW, TCG_TMP0, TCG_TMP3, cmp_off + LO_OFF);
     }
 
     /*
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 30372519dd..8add9afbbf 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2085,20 +2085,24 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     }
     tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
-    /* Load the (low part) TLB comparator into TMP2.  */
-    if (cmp_off == 0
-        && (TCG_TARGET_REG_BITS == 64 || addr_type == TCG_TYPE_I32)) {
-        uint32_t lxu = (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32
-                        ? LWZUX : LDUX);
-        tcg_out32(s, lxu | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
+    /*
+     * Load the (low part) TLB comparator into TMP2.
+     * For 64-bit host, always load the entire 64-bit slot for simplicity.
+     * We will ignore the high bits with tcg_out_cmp(..., addr_type).
+     */
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (cmp_off == 0) {
+            tcg_out32(s, LDUX | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
+        } else {
+            tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
+            tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
+        }
+    } else if (cmp_off == 0 && !HOST_BIG_ENDIAN) {
+        tcg_out32(s, LWZUX | TAB(TCG_REG_TMP2, TCG_REG_TMP1, TCG_REG_TMP2));
     } else {
         tcg_out32(s, ADD | TAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP2));
-        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2,
-                       TCG_REG_TMP1, cmp_off + 4 * HOST_BIG_ENDIAN);
-        } else {
-            tcg_out_ld(s, addr_type, TCG_REG_TMP2, TCG_REG_TMP1, cmp_off);
-        }
+        tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
+                   cmp_off + 4 * HOST_BIG_ENDIAN);
     }
 
     /*
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 45bd09cfc4..1b5e3d3ec3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -962,6 +962,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     }
 
     /* Load the tlb comparator and the addend.  */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index c32801b829..319c697a3c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1783,6 +1783,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ofs = offsetof(CPUTLBEntry, addr_write);
     }
     if (addr_type == TCG_TYPE_I32) {
+        ofs += HOST_BIG_ENDIAN * 4;
         tcg_out_insn(s, RX, C, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
     } else {
         tcg_out_insn(s, RXY, CG, TCG_REG_R0, TCG_TMP0, TCG_REG_NONE, ofs);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 48efd83817..6c60657c36 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1063,8 +1063,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* Add the tlb_table pointer, creating the CPUTLBEntry address into R2.  */
     tcg_out_arith(s, TCG_REG_T1, TCG_REG_T1, TCG_REG_T3, ARITH_ADD);
 
-    /* Load the tlb comparator and the addend. */
-    tcg_out_ld(s, addr_type, TCG_REG_T2, TCG_REG_T1, cmp_off);
+    /*
+     * Load the tlb comparator and the addend.
+     * Always load the entire 64-bit comparator for simplicity.
+     * We will ignore the high bits via BPCC_ICC below.
+     */
+    tcg_out_ld(s, TCG_TYPE_I64, TCG_REG_T2, TCG_REG_T1, cmp_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_T1, TCG_REG_T1, add_off);
     h->base = TCG_REG_T1;
 
-- 
2.34.1


