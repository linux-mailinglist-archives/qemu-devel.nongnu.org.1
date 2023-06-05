Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029087230F1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GcV-0001o0-GW; Mon, 05 Jun 2023 16:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcS-0001nZ-PP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcQ-0003la-EM
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-652426346bbso2709355b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996156; x=1688588156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q4L5Xu0HMQdUE9v27UYwFFrBy92qJzPKsISG2RoSJg=;
 b=y19hKIdYfvNt8Zx/BN1WBHKC63wRxPSDt87KasaUPenqxn4GWpKa+YnBB7KPa5WA99
 mrOmDVHxMH2ddzatQU7HnfZ0KwyvXliNs59uF5SsljKIiMHyWSW2oiJpHb9EKRzW87kF
 PadrE7XUSQppk1XQ4DpYVvYV3laPeaXyE/ogxB3WQee0Q1aQ/FwrvnLdbI+7SkssB7cU
 z8HqrrBqJNktN3WfWwTRurRtG3/CCMcSy/538B2c/tWU/DQDA7iU6qNLdFSSICYQZQFZ
 90TlZa8n7uoNXLnUrbTkt1fUZ8RHN/BN4l4f/VpdcoLAPLt+icZBrG1sWrwaYThTZNG+
 Mkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996156; x=1688588156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Q4L5Xu0HMQdUE9v27UYwFFrBy92qJzPKsISG2RoSJg=;
 b=NezHPZ1DptGFbA9Ior9Cp0O+g2lI32KGIXsH2svbs7xNgMecUARz9OPB4MaJK4ICUq
 y1xg/EUh7jiTjWVATD+fwRz5sdtTWhmM2vaGdUahNPZzjfiWXdCQNpata/eSjTcxq2WA
 Z2C4Cg5B1Xrfa6KHKzWYcAJ+YEZ6zf6AN85JTjRp4VZCKUhIFeb4kMM6dkeelbbuxKz0
 yRyBmt9F6YnHynZSzJYy3GlPdmeQBR62ekCM4Kp4X7fNMK7n1SWNFtKOEWCz9i6oYrO0
 Nsu+7a7gQWaeyYXf3OK8eNvbHWWv4F9fDIszQe4MrEnzJ0J0H0uPYo//DwPQRCJy1DaK
 d7qA==
X-Gm-Message-State: AC+VfDyEbwNiFk65kign7Qr9YZTQe1IxNGzPH2+RXpBfRANp9NQgWA1/
 ZcTGulH8ZqkmxRe9+JWTNpJzaKkKLCBOAUdpvm8=
X-Google-Smtp-Source: ACHHUZ6fVWjDZsWF6QtH8o7W9WS4xi0Nk+GF3ElGaYhgxncS70WRa8C4vQQ2LLQILquuD2HbzHtcRw==
X-Received: by 2002:a05:6a00:234b:b0:647:d698:56d2 with SMTP id
 j11-20020a056a00234b00b00647d69856d2mr797988pfj.27.1685996156026; 
 Mon, 05 Jun 2023 13:15:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:15:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 06/52] tcg: Widen CPUTLBEntry comparators to 64-bits
Date: Mon,  5 Jun 2023 13:15:02 -0700
Message-Id: <20230605201548.1596865-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
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
index 261ad25210..e23c57e2cd 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1690,6 +1690,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
 
     /* Load the tlb comparator into TMP0, and the fast path addend into TMP1. */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP1,
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
index 3274d9aace..4c0de0a380 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1311,14 +1311,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
index 11955a6cc2..73f6ea0393 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2098,20 +2098,24 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
index a8f99f7e77..a6d56e2d0e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1249,6 +1249,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     }
 
     /* Load the tlb comparator and the addend.  */
+    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
     tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2795242b60..03be800c3b 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1796,6 +1796,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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


