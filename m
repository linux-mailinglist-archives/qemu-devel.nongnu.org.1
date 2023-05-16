Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038E270582E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eL-0002lX-B3; Tue, 16 May 2023 15:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000Lk-DD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cD-0003kw-Cp
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-24ded4b33d7so21887a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266341; x=1686858341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuME4Q0uyj8eqINyik0cwsf020/cK1vI3bJfJHG03XY=;
 b=MYYreJyO/ie479vEeEk6NixhZOLMixFy1P9G90NT+LsB7f+SfwP3kEq6iOP85RgBkl
 FJfYNrvzmERmYG3FL3Kwfss6Nk4SH1O2E8erOF6RdLz12EqbTntQZbMwxOc9RNJTDOBL
 V2qZoBJ3UFRwq1MuwIW/cfUeZsah+3fNZd8m3hAU4fwVGeRHdn0fve3QP5fEBOYFls60
 gW0l+UGSbBwTLq+r8hkcPoHf58yUUNy8aDdBXLsAb4+cb3cV248HgfK5ODONpkillxWa
 7qsxTDwA8ceKm1Q4f+5ChhlR+zH1Wkib9JzkMOsrzGy54K7X7EXgj5UvE8Lpc53++0fz
 KkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266341; x=1686858341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuME4Q0uyj8eqINyik0cwsf020/cK1vI3bJfJHG03XY=;
 b=b27DujgwYHf6d7WLHa1snhAwWWIMxXj2hGD6v5uENDuHraQvLf0JfbE9UUcRAG9VUL
 WrRWokDV8dY5WLZWEUS8NchjRoa79BoXs2qXNtzK0rgm/vUCaUdhNsRPrpqk3TLs0CbX
 0RHKgRqnsRWjSfJTfZxvhzon05OzNLwLuCqY3WLLJh0K6EsKV/jrzGlQyBbAHO/vZqi4
 F4jmy3E4T48LQbO1g886u6gVX5HGp1Bnpw+xJIsWnlGqbpp74l4oBCHQhv7c6tEB/uTK
 JgY+NmgdK/nh0zAyyD1mpPApbCQ646yVh7uu0WpXsAZRTlPpmIplC1a0nFoNDxRlK35G
 tvsw==
X-Gm-Message-State: AC+VfDxk/EQAizSF/FafWzvAcSS9WUJR6EJCbVKr3T4FOojw5m4afl4e
 lIy6mVJYtmAS6LPIcQeaKbLcMa44IGyfXlPX3Ow=
X-Google-Smtp-Source: ACHHUZ5+gZtFwVBLdm4BY92mdXNBHo8pE8jvIpKi5UDxx7Pc7dKrW4IroNmcRB/itC4ttqiv4DYOGQ==
X-Received: by 2002:a17:90a:b793:b0:250:6bd9:d0d with SMTP id
 m19-20020a17090ab79300b002506bd90d0dmr32874155pjr.15.1684266341199; 
 Tue, 16 May 2023 12:45:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 61/80] tcg: Reduce copies for plugin_gen_mem_callbacks
Date: Tue, 16 May 2023 12:41:26 -0700
Message-Id: <20230516194145.1749305-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

We only need to make copies for loads, when the destination
overlaps the address.  For now, only eliminate the copy for
stores and 128-bit loads.

Rename plugin_prep_mem_callbacks to plugin_maybe_preserve_addr,
returning NULL if no copy is made.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index ca57a2779d..b695d2954e 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -114,7 +114,8 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
-static inline TCGv plugin_prep_mem_callbacks(TCGv vaddr)
+/* Only required for loads, where value might overlap addr. */
+static TCGv plugin_maybe_preserve_addr(TCGv vaddr)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
@@ -124,17 +125,20 @@ static inline TCGv plugin_prep_mem_callbacks(TCGv vaddr)
         return temp;
     }
 #endif
-    return vaddr;
+    return NULL;
 }
 
-static void plugin_gen_mem_callbacks(TCGv vaddr, MemOpIdx oi,
-                                     enum qemu_plugin_mem_rw rw)
+static void
+plugin_gen_mem_callbacks(TCGv copy_addr, TCGv orig_addr, MemOpIdx oi,
+                         enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
-        plugin_gen_empty_mem_callback(vaddr, info);
-        tcg_temp_free(vaddr);
+        plugin_gen_empty_mem_callback(copy_addr ? : orig_addr, info);
+        if (copy_addr) {
+            tcg_temp_free(copy_addr);
+        }
     }
 #endif
 }
@@ -143,6 +147,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx oi;
+    TCGv copy_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -157,9 +162,9 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
-    addr = plugin_prep_mem_callbacks(addr);
+    copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks(copy_addr, addr, oi, QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -202,13 +207,12 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
-    addr = plugin_prep_mem_callbacks(addr);
     if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
         gen_ldst_i32(INDEX_op_qemu_st8_i32, val, addr, memop, idx);
     } else {
         gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
     }
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -219,6 +223,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     MemOp orig_memop;
     MemOpIdx oi;
+    TCGv copy_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -243,9 +248,9 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
-    addr = plugin_prep_mem_callbacks(addr);
+    copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks(copy_addr, addr, oi, QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -300,9 +305,8 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
-    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -419,7 +423,6 @@ void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_debug_assert((memop & MO_SIGN) == 0);
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
-    addr = plugin_prep_mem_callbacks(addr);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
@@ -490,7 +493,7 @@ void tcg_gen_qemu_ld_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
         maybe_free_addr64(a64);
     }
 
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_R);
 }
 
 void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
@@ -501,7 +504,6 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_debug_assert((memop & MO_SIGN) == 0);
 
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
-    addr = plugin_prep_mem_callbacks(addr);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
 
@@ -572,7 +574,7 @@ void tcg_gen_qemu_st_i128(TCGv_i128 val, TCGv addr, TCGArg idx, MemOp memop)
         maybe_free_addr64(a64);
     }
 
-    plugin_gen_mem_callbacks(addr, oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks(NULL, addr, oi, QEMU_PLUGIN_MEM_W);
 }
 
 static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-- 
2.34.1


