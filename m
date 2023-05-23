Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD8A70DE35
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STJ-0006qz-0t; Tue, 23 May 2023 09:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSK-0004uI-NQ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSA-0002zf-Up
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso3750511b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850010; x=1687442010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=++xGouEzAnDLCOE+hfQe+33jtp4dTZsPLh5EBleA5as=;
 b=NJSwZF1IQXP+5VK7pUoOmH+wfB9aZ4bGRKoOAysGt0SewV9dDQVVdssp092QPR1Fmb
 v9+J2PCRulGs99Krkd5JDS1OiEAHlil8n7P4Nc2dZLXgwuUZzWtci+pdQqHI6Yms4XM+
 j+Y/nIcRsquQYdu8wZqdvFGf1fKEWdlffVHpmLUW7d4zP9l3jfzJ1I5dnLHkecsb7QXb
 evbDzjB1FZ06EjufkJ0vrgPqqaewMouWfGRBjiXux0AdTy4VsDVIMDiSOZaEFfqlJzou
 9dNsqlEuNeoY9g1Tlb+j2at9LitLV0z7EoS9M3yVkMcUvfuS0XS11WBarTZ3DUOv7NiJ
 Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850010; x=1687442010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++xGouEzAnDLCOE+hfQe+33jtp4dTZsPLh5EBleA5as=;
 b=M0yqLxAznPO6q1XBOoLMLKg92IJl8zFImRnoUVMPvEyWFKQBbcZYrIPa1xpRBX0txz
 zWJg5jl5pSYHoyjsstAshUVKYTQSA2SzD01xdf7KE+0UK071GJ6fE5Cc1uQ2ldglNNWD
 uJ5KV5eHM/ChGb6bubNBI/UU8kI1Or8hyaGvXovcPIX5pZbfBxND66JiEmwptsKEG9Yq
 cYiCK6wTN0SEAUj4EqpFhYViOAFPxAE7WSluP7LCa9CuBQZA2ckLyabTUhnAM5C/SQPv
 5M88EsS2ZSH7sby0hgykob2AMWJDLTHP0BjzKN5bkeEDDGu+YlIt8TbE4gJroU3zk0RC
 +YgA==
X-Gm-Message-State: AC+VfDwu+sUOQn6oeRk+Th0R+oqIYrpDdJa1q8o9cCKPOqTB/9PB9BMh
 uV10Xp3SfOVg6M5t+mcpxRm5ME2t3o6FT9YtP5Y=
X-Google-Smtp-Source: ACHHUZ5YJqp2FFPmr9C+Rjk6/x3O/UKv3kd2aIx6xCK5UWR8I7i5dGMFLVeJ9NTh3pNDhmfR4JZK8g==
X-Received: by 2002:a05:6a00:1689:b0:627:6328:79f1 with SMTP id
 k9-20020a056a00168900b00627632879f1mr20302375pfc.34.1684850010011; 
 Tue, 23 May 2023 06:53:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/52] tcg: Add tlb_fast_offset to TCGContext
Date: Tue, 23 May 2023 06:52:37 -0700
Message-Id: <20230523135322.678948-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Disconnect the layout of ArchCPU from TCG compilation.
Pass the relative offset of 'env' and 'neg.tlb.f' as a parameter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h          | 39 +---------------------
 include/exec/tlb-common.h        | 56 ++++++++++++++++++++++++++++++++
 include/tcg/tcg.h                |  1 +
 accel/tcg/translate-all.c        |  2 ++
 tcg/tcg.c                        | 13 ++++++++
 tcg/aarch64/tcg-target.c.inc     |  7 ++--
 tcg/arm/tcg-target.c.inc         |  7 ++--
 tcg/i386/tcg-target.c.inc        |  9 ++---
 tcg/loongarch64/tcg-target.c.inc |  7 ++--
 tcg/mips/tcg-target.c.inc        |  7 ++--
 tcg/ppc/tcg-target.c.inc         |  7 ++--
 tcg/riscv/tcg-target.c.inc       |  7 ++--
 tcg/s390x/tcg-target.c.inc       |  7 ++--
 tcg/sparc64/tcg-target.c.inc     |  7 ++--
 14 files changed, 110 insertions(+), 66 deletions(-)
 create mode 100644 include/exec/tlb-common.h

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index b757d37966..0d418a0384 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -61,12 +61,11 @@
 #define NB_MMU_MODES 16
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#include "exec/tlb-common.h"
 
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
-#define CPU_TLB_ENTRY_BITS 5
-
 #define CPU_TLB_DYN_MIN_BITS 6
 #define CPU_TLB_DYN_DEFAULT_BITS 8
 
@@ -90,27 +89,6 @@
 #  endif
 # endif
 
-/* Minimalized TLB entry for use by TCG fast path. */
-typedef union CPUTLBEntry {
-    struct {
-        uint64_t addr_read;
-        uint64_t addr_write;
-        uint64_t addr_code;
-        /*
-         * Addend to virtual address to get host address.  IO accesses
-         * use the corresponding iotlb value.
-         */
-        uintptr_t addend;
-    };
-    /*
-     * Padding to get a power of two size, as well as index
-     * access to addr_{read,write,code}.
-     */
-    uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
-} CPUTLBEntry;
-
-QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
-
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 #if !defined(CONFIG_USER_ONLY)
@@ -184,17 +162,6 @@ typedef struct CPUTLBDesc {
     CPUTLBEntryFull *fulltlb;
 } CPUTLBDesc;
 
-/*
- * Data elements that are per MMU mode, accessed by the fast path.
- * The structure is aligned to aid loading the pair with one insn.
- */
-typedef struct CPUTLBDescFast {
-    /* Contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */
-    uintptr_t mask;
-    /* The array of tlb entries itself. */
-    CPUTLBEntry *table;
-} CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
-
 /*
  * Data elements that are shared between all MMU modes.
  */
@@ -230,10 +197,6 @@ typedef struct CPUTLB {
     CPUTLBDescFast f[NB_MMU_MODES];
 } CPUTLB;
 
-/* This will be used by TCG backends to compute offsets.  */
-#define TLB_MASK_TABLE_OFS(IDX) \
-    ((int)offsetof(ArchCPU, neg.tlb.f[IDX]) - (int)offsetof(ArchCPU, env))
-
 #else
 
 typedef struct CPUTLB { } CPUTLB;
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
new file mode 100644
index 0000000000..dc5a5faa0b
--- /dev/null
+++ b/include/exec/tlb-common.h
@@ -0,0 +1,56 @@
+/*
+ * Common definitions for the softmmu tlb
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef EXEC_TLB_COMMON_H
+#define EXEC_TLB_COMMON_H 1
+
+#define CPU_TLB_ENTRY_BITS 5
+
+/* Minimalized TLB entry for use by TCG fast path. */
+typedef union CPUTLBEntry {
+    struct {
+        uint64_t addr_read;
+        uint64_t addr_write;
+        uint64_t addr_code;
+        /*
+         * Addend to virtual address to get host address.  IO accesses
+         * use the corresponding iotlb value.
+         */
+        uintptr_t addend;
+    };
+    /*
+     * Padding to get a power of two size, as well as index
+     * access to addr_{read,write,code}.
+     */
+    uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
+} CPUTLBEntry;
+
+QEMU_BUILD_BUG_ON(sizeof(CPUTLBEntry) != (1 << CPU_TLB_ENTRY_BITS));
+
+/*
+ * Data elements that are per MMU mode, accessed by the fast path.
+ * The structure is aligned to aid loading the pair with one insn.
+ */
+typedef struct CPUTLBDescFast {
+    /* Contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */
+    uintptr_t mask;
+    /* The array of tlb entries itself. */
+    CPUTLBEntry *table;
+} CPUTLBDescFast QEMU_ALIGNED(2 * sizeof(void *));
+
+#endif /* EXEC_TLB_COMMON_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0da17f1b4f..54f260a66b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -547,6 +547,7 @@ struct TCGContext {
     TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
 
 #ifdef CONFIG_SOFTMMU
+    int tlb_fast_offset;
     int page_mask;
     uint8_t page_bits;
     uint8_t tlb_dyn_max_bits;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6c8ad1a18..be38d4aad8 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -361,6 +361,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
+    tcg_ctx->tlb_fast_offset =
+        (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
 #endif
 
  tb_overflow:
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0b0fe9c7ad..35bbc03ede 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -44,6 +44,7 @@
 #define NO_CPU_IO_DEFS
 
 #include "exec/exec-all.h"
+#include "exec/tlb-common.h"
 #include "tcg/tcg-op.h"
 
 #if UINTPTR_MAX == UINT32_MAX
@@ -410,6 +411,13 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
     return (uintptr_t)tcg_splitwx_to_rx(&s->gen_tb->jmp_target_addr[which]);
 }
 
+#if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
+static int tlb_mask_table_ofs(TCGContext *s, int which)
+{
+    return s->tlb_fast_offset + which * sizeof(CPUTLBDescFast);
+}
+#endif
+
 /* Signal overflow, starting over with fewer guest insns. */
 static G_NORETURN
 void tcg_raise_tb_overflow(TCGContext *s)
@@ -1526,6 +1534,11 @@ void tcg_func_start(TCGContext *s)
 
     tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
                      s->addr_type == TCG_TYPE_I64);
+
+#if defined(CONFIG_SOFTMMU) && !defined(CONFIG_TCG_INTERPRETER)
+    tcg_debug_assert(s->tlb_fast_offset < 0);
+    tcg_debug_assert(s->tlb_fast_offset >= MIN_TLB_MASK_TABLE_OFS);
+#endif
 }
 
 static TCGTemp *tcg_temp_alloc(TCGContext *s)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 39bb47baec..af4e9fdac7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1620,6 +1620,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     return true;
 }
 
+/* We expect to use a 7-bit scaled negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -512
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -1658,12 +1661,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
     /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
     tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
-                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);
+                 tlb_mask_table_ofs(s, mem_index), 1, 0);
 
     /* Extract the TLB index from the address into X0.  */
     tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 64eb0cb5dc..83e286088f 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1374,6 +1374,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     return true;
 }
 
+/* We expect to use an 9-bit sign-magnitude negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -256
+
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                            TCGReg addrlo, TCGReg addrhi,
                                            MemOpIdx oi, bool is_ld)
@@ -1405,7 +1408,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int mem_index = get_mmuidx(oi);
     int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
                         : offsetof(CPUTLBEntry, addr_write);
-    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_off = tlb_mask_table_ofs(s, mem_index);
     unsigned s_mask = (1 << (opc & MO_SIZE)) - 1;
     TCGReg t_addr;
 
@@ -1416,8 +1419,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrhi_reg = addrhi;
 
     /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -256);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
     tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index bfe9d98b7e..d955aa6a9c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1858,6 +1858,8 @@ static inline int setup_guest_base_seg(void)
 #endif /* setup_guest_base_seg */
 #endif /* !SOFTMMU */
 
+#define MIN_TLB_MASK_TABLE_OFS  INT_MIN
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -1892,6 +1894,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     unsigned mem_index = get_mmuidx(oi);
     unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1 << s_bits) - 1;
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
     int tlb_mask;
 
     ldst = new_ldst_label(s);
@@ -1917,12 +1920,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                    s->page_bits - CPU_TLB_ENTRY_BITS);
 
     tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, TCG_REG_L0, TCG_AREG0,
-                         TLB_MASK_TABLE_OFS(mem_index) +
-                         offsetof(CPUTLBDescFast, mask));
+                         fast_ofs + offsetof(CPUTLBDescFast, mask));
 
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, TCG_REG_L0, TCG_AREG0,
-                         TLB_MASK_TABLE_OFS(mem_index) +
-                         offsetof(CPUTLBDescFast, table));
+                         fast_ofs + offsetof(CPUTLBDescFast, table));
 
     /*
      * If the required alignment is at least as large as the access, simply
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e89f3b848b..baf5fc3819 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -834,6 +834,9 @@ bool tcg_target_has_memory_bswap(MemOp memop)
     return false;
 }
 
+/* We expect to use a 12-bit negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -(1 << 11)
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -855,7 +858,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 #ifdef CONFIG_SOFTMMU
     unsigned s_bits = opc & MO_SIZE;
     int mem_index = get_mmuidx(oi);
-    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
     int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
 
@@ -864,8 +867,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->oi = oi;
     ldst->addrlo_reg = addr_reg;
 
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 11));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 26ed2a4e9b..e2a78d0530 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1142,6 +1142,9 @@ bool tcg_target_has_memory_bswap(MemOp memop)
     return false;
 }
 
+/* We expect to use a 16-bit negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -32768
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -1167,7 +1170,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 #ifdef CONFIG_SOFTMMU
     unsigned s_mask = (1 << s_bits) - 1;
     int mem_index = get_mmuidx(oi);
-    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_off = tlb_mask_table_ofs(s, mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
     int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     int add_off = offsetof(CPUTLBEntry, addend);
@@ -1181,8 +1184,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrhi_reg = addrhi;
 
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP1, TCG_AREG0, table_off);
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 8add9afbbf..073361a54b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2023,6 +2023,9 @@ bool tcg_target_has_memory_bswap(MemOp memop)
     return true;
 }
 
+/* We expect to use a 16-bit negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -32768
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -2058,7 +2061,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int mem_index = get_mmuidx(oi);
     int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
                         : offsetof(CPUTLBEntry, addr_write);
-    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_off = tlb_mask_table_ofs(s, mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
     int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     unsigned s_bits = opc & MO_SIZE;
@@ -2070,8 +2073,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrhi_reg = addrhi;
 
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_AREG0, table_off);
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1b5e3d3ec3..99e375d5b1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -898,6 +898,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     return true;
 }
 
+/* We expect to use a 12-bit negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -(1 << 11)
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -921,7 +924,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1u << s_bits) - 1;
     int mem_index = get_mmuidx(oi);
-    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
     int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
     int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
     int compare_mask;
@@ -932,8 +935,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     ldst->oi = oi;
     ldst->addrlo_reg = addr_reg;
 
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 11));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 319c697a3c..264a5628db 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1722,6 +1722,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     return true;
 }
 
+/* We're expecting to use a 20-bit negative offset on the tlb memory ops.  */
+#define MIN_TLB_MASK_TABLE_OFS  -(1 << 19)
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -1744,7 +1747,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1 << s_bits) - 1;
     int mem_index = get_mmuidx(oi);
-    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_off = tlb_mask_table_ofs(s, mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
     int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     int ofs, a_off;
@@ -1758,8 +1761,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
                  s->page_bits - CPU_TLB_ENTRY_BITS);
 
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 19));
     tcg_out_insn(s, RXY, NG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, mask_off);
     tcg_out_insn(s, RXY, AG, TCG_TMP0, TCG_AREG0, TCG_REG_NONE, table_off);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 6c60657c36..ffcb879211 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1017,6 +1017,9 @@ bool tcg_target_has_memory_bswap(MemOp memop)
     return true;
 }
 
+/* We expect to use a 13-bit negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -(1 << 12)
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
@@ -1040,7 +1043,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
 #ifdef CONFIG_SOFTMMU
     int mem_index = get_mmuidx(oi);
-    int fast_off = TLB_MASK_TABLE_OFS(mem_index);
+    int fast_off = tlb_mask_table_ofs(s, mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
     int table_off = fast_off + offsetof(CPUTLBDescFast, table);
     int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
@@ -1050,8 +1053,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     int cc;
 
     /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
-    QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 12));
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_T2, TCG_AREG0, mask_off);
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_T3, TCG_AREG0, table_off);
 
-- 
2.34.1


