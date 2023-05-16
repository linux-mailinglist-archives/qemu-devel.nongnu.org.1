Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBA77057FF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cg-0000qy-Ja; Tue, 16 May 2023 15:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000M8-GC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cD-0003iP-Lv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-24df161f84bso39442a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266344; x=1686858344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ojCK0LNJKJYp6jdH9Or6ZqPPjbgWADgsJhhQdni33Y=;
 b=rzzHkcQjQlcUYKQ+HPDBvL9xupgQUMG59a3UbZhXor9hyxV4DJM+mrrMjV6W8E6yXG
 WCawRPiWusNvNE4JC+lQfQ8UGudHOSQKPeQys44umm2Fe2vXKBVrry82sM1TCjfio8cw
 pIQudEcGcdjNA4hb3yxjzyyI+9XQaEaYIw2PbdeO9cb7nInm2enlFgpWJW3HR8J60EVN
 iY+avlPqYV//w4xRhXUjgqL/we6+hn4Q/vl8rQrdPc9lk7hpdn2rx5bsn57SS5x2ShBM
 +yWOHNUVd132mbqUKCmXNwkN1IiFnURWgwKYcf3GBCEdAjQ9VpDjZZJZ+Fhb3YqbHdMy
 HOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266344; x=1686858344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ojCK0LNJKJYp6jdH9Or6ZqPPjbgWADgsJhhQdni33Y=;
 b=QPDkPl0llom57bLkZu76apFj1EK/beOaejgZQ+l0G19+J/uKQwMfNMEqSs2+Y4DWYI
 eyJdgmb+//XEP+nnMunFLD17dodcj7sXcTbAC75NYnb5/Jl+wohiiw5qCjBi6WYwkWHz
 1CNcgnxA8uMD9/OmT2oJsRgDonCdI3ZA32gBMBD1eJ/3coUVlQPvDPbQa+Mt2/YaEnLD
 v/XPLUUzeoZx0L6zY6uvOmzU8e9UleuyWEcXUTqbW95XWK6Hw2vAEILpGJJX2NKzOLMN
 cft/ZXRsUQyaFnYQfLjaoZNuNNStpwk4Cl6Qx7qGe7sGi/zDU+kdfye2OibXuU1/s+k0
 zasw==
X-Gm-Message-State: AC+VfDxU02NlmQnPEmMnlTnEG50lz7NLW3kaoqL+mMOtmjMuZkGTjw8/
 5QuMN4Y6AoxeAULt8R6SccmyX2b8b9lkkyGlwaw=
X-Google-Smtp-Source: ACHHUZ7yX+WAdyWKJo0maAjs57fqnOTK12eDxaQI1mK8SCyaPKY4Mpq7r2R4dnWW4Uf2lN8pYcvOUg==
X-Received: by 2002:a17:90a:1bcd:b0:23d:bbcb:c97f with SMTP id
 r13-20020a17090a1bcd00b0023dbbcbc97fmr37554231pjr.1.1684266343639; 
 Tue, 16 May 2023 12:45:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 64/80] tcg: Remove TCGv from tcg_gen_qemu_{ld,st}_*
Date: Tue, 16 May 2023 12:41:29 -0700
Message-Id: <20230516194145.1749305-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Expand from TCGv to TCGTemp inline in the translators,
and validate that the size matches tcg_ctx->addr_type.
These inlines will eventually be seen only by target-specific code.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  50 ++++++-
 tcg/tcg-op-ldst.c    | 343 ++++++++++++++++++++++++++-----------------
 2 files changed, 251 insertions(+), 142 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index de3b70aa84..e556450ba9 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -803,22 +803,60 @@ static inline void tcg_gen_plugin_cb_end(void)
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcg_temp_free tcg_temp_free_i32
+#define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
 #else
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcg_temp_free tcg_temp_free_i64
+#define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
 #endif
 
-void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, MemOp);
-void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, MemOp);
-void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, MemOp);
-void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, MemOp);
-void tcg_gen_qemu_ld_i128(TCGv_i128, TCGv, TCGArg, MemOp);
-void tcg_gen_qemu_st_i128(TCGv_i128, TCGv, TCGArg, MemOp);
+void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_ld_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_ld_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+
+static inline void
+tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i32_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
+
+static inline void
+tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i32_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
+
+static inline void
+tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i64_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
+
+static inline void
+tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i64_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
+
+static inline void
+tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i128_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
+
+static inline void
+tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i128_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
+}
 
 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGv_i32,
                                 TCGArg, MemOp);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 2d5e98971d..84a03bf6ed 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -68,39 +68,38 @@ static inline MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
     return op;
 }
 
-static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,
-                         MemOp memop, TCGArg idx)
+static void gen_ldst(TCGOpcode opc, TCGTemp *vl, TCGTemp *vh,
+                     TCGTemp *addr, MemOpIdx oi)
 {
-    MemOpIdx oi = make_memop_idx(memop, idx);
-#if TARGET_LONG_BITS == 32
-    tcg_gen_op3i_i32(opc, val, addr, oi);
-#else
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_op4i_i32(opc, val, TCGV_LOW(addr), TCGV_HIGH(addr), oi);
+    if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
+        if (vh) {
+            tcg_gen_op4(opc, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
+        } else {
+            tcg_gen_op3(opc, temp_arg(vl), temp_arg(addr), oi);
+        }
     } else {
-        tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_i64_arg(addr), oi);
+        /* See TCGV_LOW/HIGH. */
+        TCGTemp *al = addr + HOST_BIG_ENDIAN;
+        TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
+
+        if (vh) {
+            tcg_gen_op5(opc, temp_arg(vl), temp_arg(vh),
+                        temp_arg(al), temp_arg(ah), oi);
+        } else {
+            tcg_gen_op4(opc, temp_arg(vl), temp_arg(al), temp_arg(ah), oi);
+        }
     }
-#endif
 }
 
-static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
-                         MemOp memop, TCGArg idx)
+static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
 {
-    MemOpIdx oi = make_memop_idx(memop, idx);
-#if TARGET_LONG_BITS == 32
     if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_op4i_i32(opc, TCGV_LOW(val), TCGV_HIGH(val), addr, oi);
+        TCGTemp *vl = tcgv_i32_temp(TCGV_LOW(v));
+        TCGTemp *vh = tcgv_i32_temp(TCGV_HIGH(v));
+        gen_ldst(opc, vl, vh, addr, oi);
     } else {
-        tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_i32_arg(addr), oi);
+        gen_ldst(opc, tcgv_i64_temp(v), NULL, addr, oi);
     }
-#else
-    if (TCG_TARGET_REG_BITS == 32) {
-        tcg_gen_op5i_i32(opc, TCGV_LOW(val), TCGV_HIGH(val),
-                         TCGV_LOW(addr), TCGV_HIGH(addr), oi);
-    } else {
-        tcg_gen_op3i_i64(opc, val, addr, oi);
-    }
-#endif
 }
 
 static void tcg_gen_req_mo(TCGBar type)
@@ -115,13 +114,17 @@ static void tcg_gen_req_mo(TCGBar type)
 }
 
 /* Only required for loads, where value might overlap addr. */
-static TCGv_i64 plugin_maybe_preserve_addr(TCGv vaddr)
+static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         /* Save a copy of the vaddr for use after a load.  */
         TCGv_i64 temp = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_tl_i64(temp, vaddr);
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            tcg_gen_extu_i32_i64(temp, temp_tcgv_i32(addr));
+        } else {
+            tcg_gen_mov_i64(temp, temp_tcgv_i64(addr));
+        }
         return temp;
     }
 #endif
@@ -129,54 +132,55 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGv vaddr)
 }
 
 static void
-plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGv orig_addr, MemOpIdx oi,
+plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
-#if TARGET_LONG_BITS == 64
-        if (copy_addr) {
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            if (!copy_addr) {
+                copy_addr = tcg_temp_ebb_new_i64();
+                tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
+            }
             plugin_gen_empty_mem_callback(copy_addr, info);
             tcg_temp_free_i64(copy_addr);
         } else {
-            plugin_gen_empty_mem_callback(orig_addr, info);
+            if (copy_addr) {
+                plugin_gen_empty_mem_callback(copy_addr, info);
+                tcg_temp_free_i64(copy_addr);
+            } else {
+                plugin_gen_empty_mem_callback(temp_tcgv_i64(orig_addr), info);
+            }
         }
-#else
-        if (!copy_addr) {
-            copy_addr = tcg_temp_ebb_new_i64();
-            tcg_gen_extu_tl_i64(copy_addr, orig_addr);
-        }
-        plugin_gen_empty_mem_callback(copy_addr, info);
-        tcg_temp_free_i64(copy_addr);
-#endif
     }
 #endif
 }
 
-void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
+static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
+                                    TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
-    MemOpIdx oi;
+    MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    memop = tcg_canonicalize_memop(memop, 0, 0);
-    oi = make_memop_idx(memop, idx);
+    orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
+    orig_oi = oi = make_memop_idx(memop, idx);
 
-    orig_memop = memop;
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
         if ((memop & MO_SSIZE) == MO_SW) {
             memop &= ~MO_SIGN;
         }
+        oi = make_memop_idx(memop, idx);
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(copy_addr, addr, oi, QEMU_PLUGIN_MEM_R);
+    gen_ldst(INDEX_op_qemu_ld_i32, tcgv_i32_temp(val), NULL, addr, oi);
+    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -194,14 +198,24 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 }
 
-void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
+void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
+                             MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
+    tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
+}
+
+static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
+                                    TCGArg idx, MemOp memop)
 {
     TCGv_i32 swap = NULL;
-    MemOpIdx oi;
+    MemOpIdx orig_oi, oi;
+    TCGOpcode opc;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    oi = make_memop_idx(memop, idx);
+    orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         swap = tcg_temp_ebb_new_i32();
@@ -217,28 +231,39 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         }
         val = swap;
         memop &= ~MO_BSWAP;
+        oi = make_memop_idx(memop, idx);
     }
 
     if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
-        gen_ldst_i32(INDEX_op_qemu_st8_i32, val, addr, memop, idx);
+        opc = INDEX_op_qemu_st8_i32;
     } else {
-        gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+        opc = INDEX_op_qemu_st_i32;
     }
-    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
+    gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
+    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i32(swap);
     }
 }
 
-void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
+void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
+                             MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
+    tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
+}
+
+static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
+                                    TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
-    MemOpIdx oi;
+    MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
+        tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
         if (memop & MO_SIGN) {
             tcg_gen_sari_i32(TCGV_HIGH(val), TCGV_LOW(val), 31);
         } else {
@@ -248,21 +273,21 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    memop = tcg_canonicalize_memop(memop, 1, 0);
-    oi = make_memop_idx(memop, idx);
+    orig_memop = memop = tcg_canonicalize_memop(memop, 1, 0);
+    orig_oi = oi = make_memop_idx(memop, idx);
 
-    orig_memop = memop;
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
         if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
             memop &= ~MO_SIGN;
         }
+        oi = make_memop_idx(memop, idx);
     }
 
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(copy_addr, addr, oi, QEMU_PLUGIN_MEM_R);
+    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, oi);
+    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -284,19 +309,28 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     }
 }
 
-void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
+void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
+                             MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
+    tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
+}
+
+static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
+                                    TCGArg idx, MemOp memop)
 {
     TCGv_i64 swap = NULL;
-    MemOpIdx oi;
+    MemOpIdx orig_oi, oi;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
-        tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
+        tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
         return;
     }
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    oi = make_memop_idx(memop, idx);
+    orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         swap = tcg_temp_ebb_new_i64();
@@ -315,16 +349,25 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         }
         val = swap;
         memop &= ~MO_BSWAP;
+        oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
+    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, oi);
+    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i64(swap);
     }
 }
 
+void tcg_gen_qemu_st_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
+                             MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
+    tcg_gen_qemu_st_i64_int(val, addr, idx, memop);
+}
+
 /*
  * Return true if @mop, without knowledge of the pointer alignment,
  * does not require 16-byte atomicity, and it would be adventagous
@@ -360,9 +403,6 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
 {
     MemOp mop_1 = orig, mop_2;
 
-    tcg_debug_assert((orig & MO_SIZE) == MO_128);
-    tcg_debug_assert((orig & MO_SIGN) == 0);
-
     /* Reduce the size to 64-bit. */
     mop_1 = (mop_1 & ~MO_SIZE) | MO_64;
 
@@ -403,12 +443,6 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
-#if TARGET_LONG_BITS == 64
-#define tcg_temp_ebb_new  tcg_temp_ebb_new_i64
-#else
-#define tcg_temp_ebb_new  tcg_temp_ebb_new_i32
-#endif
-
 static TCGv_i64 maybe_extend_addr64(TCGv addr)
 {
 #if TARGET_LONG_BITS == 32
@@ -427,39 +461,32 @@ static void maybe_free_addr64(TCGv_i64 a64)
 #endif
 }
 
-void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
+static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
+                                     TCGArg idx, MemOp memop)
 {
-    const MemOpIdx oi = make_memop_idx(memop, idx);
-
-    tcg_debug_assert((memop & MO_SIZE) == MO_128);
-    tcg_debug_assert((memop & MO_SIGN) == 0);
+    const MemOpIdx orig_oi = make_memop_idx(memop, idx);
+    TCGv_i64 ext_addr = NULL;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
         TCGv_i64 lo, hi;
-        TCGArg addr_arg;
-        MemOpIdx adj_oi;
         bool need_bswap = false;
+        MemOpIdx oi = orig_oi;
 
         if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
             lo = TCGV128_HIGH(val);
             hi = TCGV128_LOW(val);
-            adj_oi = make_memop_idx(memop & ~MO_BSWAP, idx);
+            oi = make_memop_idx(memop & ~MO_BSWAP, idx);
             need_bswap = true;
         } else {
             lo = TCGV128_LOW(val);
             hi = TCGV128_HIGH(val);
-            adj_oi = oi;
         }
 
-#if TARGET_LONG_BITS == 32
-        addr_arg = tcgv_i32_arg(addr);
-#else
-        addr_arg = tcgv_i64_arg(addr);
-#endif
-        tcg_gen_op4ii_i64(INDEX_op_qemu_ld_i128, lo, hi, addr_arg, adj_oi);
+        gen_ldst(INDEX_op_qemu_ld_i128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -467,10 +494,13 @@ void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     } else if (use_two_i64_for_i128(memop)) {
         MemOp mop[2];
-        TCGv addr_p8;
+        TCGTemp *addr_p8;
         TCGv_i64 x, y;
+        MemOpIdx oi;
+        bool need_bswap;
 
         canonicalize_memop_i128_as_i64(mop, memop);
+        need_bswap = (mop[0] ^ memop) & MO_BSWAP;
 
         /*
          * Since there are no global TCGv_i128, there is no visible state
@@ -485,35 +515,56 @@ void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
             y = TCGV128_LOW(val);
         }
 
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr, mop[0], idx);
+        oi = make_memop_idx(mop[0], idx);
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr, oi);
 
-        if ((mop[0] ^ memop) & MO_BSWAP) {
+        if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
         }
 
-        addr_p8 = tcg_temp_ebb_new();
-        tcg_gen_addi_tl(addr_p8, addr, 8);
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8, mop[1], idx);
-        tcg_temp_free(addr_p8);
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            TCGv_i32 t = tcg_temp_ebb_new_i32();
+            tcg_gen_addi_i32(t, temp_tcgv_i32(addr), 8);
+            addr_p8 = tcgv_i32_temp(t);
+        } else {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            tcg_gen_addi_i64(t, temp_tcgv_i64(addr), 8);
+            addr_p8 = tcgv_i64_temp(t);
+        }
 
-        if ((mop[0] ^ memop) & MO_BSWAP) {
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8, oi);
+        tcg_temp_free_internal(addr_p8);
+
+        if (need_bswap) {
             tcg_gen_bswap64_i64(y, y);
         }
     } else {
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
-        gen_helper_ld_i128(val, cpu_env, a64, tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            ext_addr = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(ext_addr, temp_tcgv_i32(addr));
+            addr = tcgv_i64_temp(ext_addr);
+        }
+        gen_helper_ld_i128(val, cpu_env, temp_tcgv_i64(addr),
+                           tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
 }
 
-void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
+void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+                              MemOp memop, TCGType addr_type)
 {
-    const MemOpIdx oi = make_memop_idx(memop, idx);
-
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
     tcg_debug_assert((memop & MO_SIZE) == MO_128);
     tcg_debug_assert((memop & MO_SIGN) == 0);
+    tcg_gen_qemu_ld_i128_int(val, addr, idx, memop);
+}
+
+static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
+                                     TCGArg idx, MemOp memop)
+{
+    const MemOpIdx orig_oi = make_memop_idx(memop, idx);
+    TCGv_i64 ext_addr = NULL;
 
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
 
@@ -521,29 +572,23 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
 
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
         TCGv_i64 lo, hi;
-        TCGArg addr_arg;
-        MemOpIdx adj_oi;
+        MemOpIdx oi = orig_oi;
         bool need_bswap = false;
 
         if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-            lo = tcg_temp_new_i64();
-            hi = tcg_temp_new_i64();
+            lo = tcg_temp_ebb_new_i64();
+            hi = tcg_temp_ebb_new_i64();
             tcg_gen_bswap64_i64(lo, TCGV128_HIGH(val));
             tcg_gen_bswap64_i64(hi, TCGV128_LOW(val));
-            adj_oi = make_memop_idx(memop & ~MO_BSWAP, idx);
+            oi = make_memop_idx(memop & ~MO_BSWAP, idx);
             need_bswap = true;
         } else {
             lo = TCGV128_LOW(val);
             hi = TCGV128_HIGH(val);
-            adj_oi = oi;
         }
 
-#if TARGET_LONG_BITS == 32
-        addr_arg = tcgv_i32_arg(addr);
-#else
-        addr_arg = tcgv_i64_arg(addr);
-#endif
-        tcg_gen_op4ii_i64(INDEX_op_qemu_st_i128, lo, hi, addr_arg, adj_oi);
+        gen_ldst(INDEX_op_qemu_st_i128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -551,8 +596,8 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     } else if (use_two_i64_for_i128(memop)) {
         MemOp mop[2];
-        TCGv addr_p8;
-        TCGv_i64 x, y;
+        TCGTemp *addr_p8;
+        TCGv_i64 x, y, b = NULL;
 
         canonicalize_memop_i128_as_i64(mop, memop);
 
@@ -564,29 +609,55 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
             y = TCGV128_LOW(val);
         }
 
-        addr_p8 = tcg_temp_ebb_new();
         if ((mop[0] ^ memop) & MO_BSWAP) {
-            TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-            tcg_gen_bswap64_i64(t, x);
-            gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr, mop[0], idx);
-            tcg_gen_bswap64_i64(t, y);
-            tcg_gen_addi_tl(addr_p8, addr, 8);
-            gen_ldst_i64(INDEX_op_qemu_st_i64, t, addr_p8, mop[1], idx);
-            tcg_temp_free_i64(t);
-        } else {
-            gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr, mop[0], idx);
-            tcg_gen_addi_tl(addr_p8, addr, 8);
-            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8, mop[1], idx);
+            b = tcg_temp_ebb_new_i64();
+            tcg_gen_bswap64_i64(b, x);
+            x = b;
         }
-        tcg_temp_free(addr_p8);
+        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr,
+                     make_memop_idx(mop[0], idx));
+
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            TCGv_i32 t = tcg_temp_ebb_new_i32();
+            tcg_gen_addi_i32(t, temp_tcgv_i32(addr), 8);
+            addr_p8 = tcgv_i32_temp(t);
+        } else {
+            TCGv_i64 t = tcg_temp_ebb_new_i64();
+            tcg_gen_addi_i64(t, temp_tcgv_i64(addr), 8);
+            addr_p8 = tcgv_i64_temp(t);
+        }
+
+        if (b) {
+            tcg_gen_bswap64_i64(b, y);
+            y = b;
+        }
+        gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8,
+                     make_memop_idx(mop[1], idx));
+
+        if (b) {
+            tcg_temp_free_i64(b);
+        }
+        tcg_temp_free_internal(addr_p8);
     } else {
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
-        gen_helper_st_i128(cpu_env, a64, val, tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
+        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
+            ext_addr = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(ext_addr, temp_tcgv_i32(addr));
+            addr = tcgv_i64_temp(ext_addr);
+        }
+        gen_helper_st_i128(cpu_env, temp_tcgv_i64(addr), val,
+                           tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+}
+
+void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+                              MemOp memop, TCGType addr_type)
+{
+    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
+    tcg_debug_assert((memop & MO_SIZE) == MO_128);
+    tcg_debug_assert((memop & MO_SIGN) == 0);
+    tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
 static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-- 
2.34.1


