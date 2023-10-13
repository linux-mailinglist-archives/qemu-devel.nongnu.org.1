Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDF7C8F21
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPlt-0007zp-37; Fri, 13 Oct 2023 17:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlq-0007kO-25
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:34 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPll-0001LK-H4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso385077b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232746; x=1697837546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M91yoQdGXBejSl6trWlHpYf1tkOCkHw3ekFimpTrLSg=;
 b=EDAU5/WdeEYkW7BoEl1mEZxC6eQ/gZRHgAUFC+bBXvMuoePs4AK9cPchfinrWDXJwQ
 3cvMdAcUEvwsD6MnmcvtolGjk3SGItaqilApxtiOW1AmAJ2qCukvQyftquQo3ppIWG3L
 d0KgcFDXMsbn4LvzSlRzLwPY7zt0zCgaxzFOOOrREJ7o+mN9xoGEvaqdhabNuigna6Su
 zLgktviC8S52QShcBaSNZvfsEshWMqfzjX6Vvjl/ZuKhYoht+9im+KK/uiH2ETWZQj+g
 ssysjpQA745egLLHgYYe+0TAMf85J2JNzp5dHyz38RScskPJvqhCDDamhmnnA6YZe4Nu
 xQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232746; x=1697837546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M91yoQdGXBejSl6trWlHpYf1tkOCkHw3ekFimpTrLSg=;
 b=BlcLjIrkFHsiODgW6XcNoaybGO5R1prBIMW25RtLhzZfr6AwTaGvmbwTdRXXg0c+Jb
 Tely4TQ7Mjk25SJOUm8B1D8f0+Mqyk2aXBZbFc11Yj5Es2p+GCrDmh+XpPqVCdisdYJa
 4E2NwHYyAZFYjTtVSLfqlbqjrvLW8aE6HSxi0PbdbglRsZ7c8RZybDUABtUWna5ZCWsM
 BjDl0mklsqyKft9bIa1fUXvwLu+ajEsBuAcza7RX8ys0IyJtV+mF4DL1XK6FN5TiFpUp
 Y1X11JAjLD2DPDJKHo8Qi19S0AvSyEDeXNawb0Mo0humKJM1xAaYM1VhiFMLO+m54AR4
 MqkA==
X-Gm-Message-State: AOJu0YxuZFi8iyPCpUW8ZxXBc+whPdLKSGzDQSxeVkz8TgNZNl1UlPJr
 ogCwANHtDxHRoHUHvrqX9jQsKwoQw45E0/kDpwA=
X-Google-Smtp-Source: AGHT+IFsDF0EFaJ13Qe8JE1ssctT24rtIndeesad7GDyAq4Ewh48TUYrJDsMM/zyo+jtC5R8Ll5Dpw==
X-Received: by 2002:a05:6a00:4784:b0:68f:c1e0:a2c4 with SMTP id
 dh4-20020a056a00478400b0068fc1e0a2c4mr1663487pfb.3.1697232746117; 
 Fri, 13 Oct 2023 14:32:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 40/85] target/sparc: Drop ifdef around get_asi and friends
Date: Fri, 13 Oct 2023 14:28:01 -0700
Message-Id: <20231013212846.165724-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mark some of the functions as unused, temporarily.
Fix up some tl vs i64 issues revealed in the process.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 187 +++++++++++++++------------------------
 1 file changed, 70 insertions(+), 117 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 42a26671f1..a6ae031181 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,6 +58,18 @@
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
+# ifdef CONFIG_USER_ONLY
+static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+# endif
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -1796,7 +1808,6 @@ static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
 }
 
 /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 typedef enum {
     GET_ASI_HELPER,
     GET_ASI_EXCP,
@@ -2045,8 +2056,8 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2080,8 +2091,8 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
     }
 }
 
-static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2156,8 +2167,8 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
     }
 }
 
-static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
-                         TCGv addr, int insn)
+static void __attribute__((unused))
+gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
 
@@ -2174,8 +2185,8 @@ static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
     }
 }
 
-static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                        int insn, int rd)
+static void __attribute__((unused))
+gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
     TCGv oldv;
@@ -2196,7 +2207,8 @@ static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+static void __attribute__((unused))
+gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_UB);
 
@@ -2231,11 +2243,9 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         break;
     }
 }
-#endif
 
-#ifdef TARGET_SPARC64
-static void gen_ldf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2343,8 +2353,8 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_stf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2426,21 +2436,23 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
+static void __attribute__((unused))
+gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv_i64 hi = gen_dest_gpr(dc, rd);
-    TCGv_i64 lo = gen_dest_gpr(dc, rd + 1);
+    TCGv hi = gen_dest_gpr(dc, rd);
+    TCGv lo = gen_dest_gpr(dc, rd + 1);
 
     switch (da.type) {
     case GET_ASI_EXCP:
         return;
 
     case GET_ASI_DTWINX:
+        assert(TARGET_LONG_BITS == 64);
         gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_i64(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_ld_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_i64(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_ld_tl(lo, addr, da.mem_idx, da.memop);
         break;
 
     case GET_ASI_DIRECT:
@@ -2454,9 +2466,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
                result is byte swapped.  Having just performed one
                64-bit bswap, we need now to swap the writebacks.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_extr32_i64(lo, hi, tmp);
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
-                tcg_gen_extr32_i64(hi, lo, tmp);
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
             }
         }
         break;
@@ -2476,9 +2488,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_extr32_i64(lo, hi, tmp);
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
             } else {
-                tcg_gen_extr32_i64(hi, lo, tmp);
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
             }
         }
         break;
@@ -2488,8 +2500,8 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
     gen_store_gpr(dc, rd + 1, lo);
 }
 
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv lo = gen_load_gpr(dc, rd + 1);
@@ -2499,10 +2511,11 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
         break;
 
     case GET_ASI_DTWINX:
+        assert(TARGET_LONG_BITS == 64);
         gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_i64(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
+        tcg_gen_qemu_st_tl(hi, addr, da.mem_idx, da.memop | MO_ALIGN_16);
         tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_i64(lo, addr, da.mem_idx, da.memop);
+        tcg_gen_qemu_st_tl(lo, addr, da.mem_idx, da.memop);
         break;
 
     case GET_ASI_DIRECT:
@@ -2513,15 +2526,37 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
                byte swapped.  We will perform one 64-bit LE store, so now
                we must swap the order of the construction.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
             gen_address_mask(dc, addr);
             tcg_gen_qemu_st_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
         }
         break;
 
+    case GET_ASI_BFILL:
+        assert(TARGET_LONG_BITS == 32);
+        /* Store 32 bytes of T64 to ADDR.  */
+        /* ??? The original qemu code suggests 8-byte alignment, dropping
+           the low bits, but the only place I can see this used is in the
+           Linux kernel with 32 byte alignment, which would make more sense
+           as a cacheline-style operation.  */
+        {
+            TCGv_i64 t64 = tcg_temp_new_i64();
+            TCGv d_addr = tcg_temp_new();
+            TCGv eight = tcg_constant_tl(8);
+            int i;
+
+            tcg_gen_concat_tl_i64(t64, lo, hi);
+            tcg_gen_andi_tl(d_addr, addr, -8);
+            for (i = 0; i < 32; i += 8) {
+                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
+                tcg_gen_add_tl(d_addr, d_addr, eight);
+            }
+        }
+        break;
+
     default:
         /* ??? In theory we've handled all of the ASIs that are valid
            for stda, and this should raise DAE_invalid_asi.  */
@@ -2532,9 +2567,9 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
 
             save_state(dc);
@@ -2544,8 +2579,8 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
     }
 }
 
-static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv oldv;
@@ -2566,88 +2601,6 @@ static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-#elif !defined(CONFIG_USER_ONLY)
-static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
-{
-    /* ??? Work around an apparent bug in Ubuntu gcc 4.8.2-10ubuntu2+12,
-       whereby "rd + 1" elicits "error: array subscript is above array".
-       Since we have already asserted that rd is even, the semantics
-       are unchanged.  */
-    TCGv lo = gen_dest_gpr(dc, rd | 1);
-    TCGv hi = gen_dest_gpr(dc, rd);
-    TCGv_i64 t64 = tcg_temp_new_i64();
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        return;
-    case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_ld_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
-        break;
-    default:
-        {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(MO_UQ);
-
-            save_state(dc);
-            gen_helper_ld_asi(t64, tcg_env, addr, r_asi, r_mop);
-        }
-        break;
-    }
-
-    tcg_gen_extr_i64_i32(lo, hi, t64);
-    gen_store_gpr(dc, rd | 1, lo);
-    gen_store_gpr(dc, rd, hi);
-}
-
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv lo = gen_load_gpr(dc, rd + 1);
-    TCGv_i64 t64 = tcg_temp_new_i64();
-
-    tcg_gen_concat_tl_i64(t64, lo, hi);
-
-    switch (da.type) {
-    case GET_ASI_EXCP:
-        break;
-    case GET_ASI_DIRECT:
-        gen_address_mask(dc, addr);
-        tcg_gen_qemu_st_i64(t64, addr, da.mem_idx, da.memop | MO_ALIGN);
-        break;
-    case GET_ASI_BFILL:
-        /* Store 32 bytes of T64 to ADDR.  */
-        /* ??? The original qemu code suggests 8-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
-        {
-            TCGv d_addr = tcg_temp_new();
-            TCGv eight = tcg_constant_tl(8);
-            int i;
-
-            tcg_gen_andi_tl(d_addr, addr, -8);
-            for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da.mem_idx, da.memop);
-                tcg_gen_add_tl(d_addr, d_addr, eight);
-            }
-        }
-        break;
-    default:
-        {
-            TCGv_i32 r_asi = tcg_constant_i32(da.asi);
-            TCGv_i32 r_mop = tcg_constant_i32(MO_UQ);
-
-            save_state(dc);
-            gen_helper_st_asi(tcg_env, addr, t64, r_asi, r_mop);
-        }
-        break;
-    }
-}
-#endif
-
 static TCGv get_src1(DisasContext *dc, unsigned int insn)
 {
     unsigned int rs1 = GET_FIELD(insn, 13, 17);
-- 
2.34.1


