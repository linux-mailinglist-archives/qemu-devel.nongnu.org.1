Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD797CBB23
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNo-0003P9-VU; Tue, 17 Oct 2023 02:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNT-0002m5-JQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:28 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNQ-0004fq-PZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:27 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57bb6a2481fso2702037eaf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523383; x=1698128183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIdv4hx783oHJ/Rv5v17K5kZUyzvz0qQFAi5WSlSZKU=;
 b=EoLOl1QaJSL777vbgB3o9pnKnSrjLQnVuFyHlSr7+iL3c/LTeCkUj/3CpL10Y5pwns
 Yt44U3yfVQUF1he946QcI2HgkC2Ym8xvuvKZ/pz7bYIbi89QuTg55i638JQxKTOgHoSa
 cSrjBp1cPlCPHMkDGsEJnfrjbqUFnz1Ob86NX5ysfD56oQYa1lcmYyjKaUtC8oFMAHcx
 RD1SDLi4wzQ8m4aXiP6Pk5jkwtrA0KcpLox+uV1FiNo8I9YVdO6zH+r0Oqqoydop2xNb
 z0aHVOzoQZB9xV16Osbhd2lORd0aYNqtrnQ3HtREPvdUG9SWwTie+3vhfiCRGKlDKYTa
 bMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523383; x=1698128183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIdv4hx783oHJ/Rv5v17K5kZUyzvz0qQFAi5WSlSZKU=;
 b=aMNLu48eiB9NSzTQ5G0+PI+YvPaHSgfWokeyqlGJUvwqK87M1U88nLyPNqUYR6/ZXF
 o8J8AnPAvgPAAQCBeFLQJA5uB5p5inALY9HwSRPCM0h/t5px1y4o/dh9eDgmVG95P+bz
 i4SpF8DqtoWtx65HVBmL75Yfh821i9jl8S21sr/KTcMLEUbnumrMQXykbuQ1JAZGrACN
 01QLfd8qfKe9mok43hdcg+TDSR4NvUIhh2kVnsh+SL6JyL9x1+sAQiI4KtV3JNtkixOr
 S1lKMFcPDDbkpv4u50+n+Ts5PEuArONxE2na9kdECiEUNEkWj3adSGvwDEoDsQO6yXoe
 sGCw==
X-Gm-Message-State: AOJu0Ywojj8tVJ94RcakgmGYjx87+IhRSR3bVgKjLuEJ4MTB6JS8nXAO
 tyvJjXwf4iDpz96b/Gmn2CdC7Mxkov9ySnTDh2U=
X-Google-Smtp-Source: AGHT+IE5KvbOH4/+QjStXydgzjNYU3GvP4LRIA+NW19GFqF4euKpkXIoM0yTeRYCi6HjlUD0kyiBOg==
X-Received: by 2002:a05:6358:cc15:b0:148:1a09:2469 with SMTP id
 gx21-20020a056358cc1500b001481a092469mr1377550rwb.25.1697523383403; 
 Mon, 16 Oct 2023 23:16:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 45/90] target/sparc: Drop ifdef around get_asi and friends
Date: Mon, 16 Oct 2023 23:11:59 -0700
Message-Id: <20231017061244.681584-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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
index 1d3bfb724e..6404ec5858 100644
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
@@ -1845,7 +1857,6 @@ static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
 }
 
 /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 typedef enum {
     GET_ASI_HELPER,
     GET_ASI_EXCP,
@@ -2094,8 +2105,8 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2129,8 +2140,8 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
     }
 }
 
-static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2205,8 +2216,8 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
     }
 }
 
-static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
-                         TCGv addr, int insn)
+static void __attribute__((unused))
+gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
 
@@ -2223,8 +2234,8 @@ static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
     }
 }
 
-static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                        int insn, int rd)
+static void __attribute__((unused))
+gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
     TCGv oldv;
@@ -2245,7 +2256,8 @@ static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+static void __attribute__((unused))
+gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_UB);
 
@@ -2280,11 +2292,9 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
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
@@ -2392,8 +2402,8 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_stf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2475,21 +2485,23 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,
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
@@ -2503,9 +2515,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
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
@@ -2525,9 +2537,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 
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
@@ -2537,8 +2549,8 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
     gen_store_gpr(dc, rd + 1, lo);
 }
 
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv lo = gen_load_gpr(dc, rd + 1);
@@ -2548,10 +2560,11 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
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
@@ -2562,15 +2575,37 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
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
@@ -2581,9 +2616,9 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
 
             save_state(dc);
@@ -2593,8 +2628,8 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
     }
 }
 
-static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv oldv;
@@ -2615,88 +2650,6 @@ static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
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


