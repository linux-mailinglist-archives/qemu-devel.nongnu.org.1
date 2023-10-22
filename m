Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE4D7D2720
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwj-0004iS-CQ; Sun, 22 Oct 2023 19:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwf-0004Hh-In
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwb-0007WA-On
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:21 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1968432b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017596; x=1698622396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rL95SN/2P76ND6STZe+RzAs56cWUK0TNB9Zyz/t1iO0=;
 b=heEnFacp54sUczAHaVm7opd0K9JDT3X785J+6TvSAH8/1OMrWI2Mu/b4XPsxukwttq
 v6LQfMSi9xZS/yvNR3EtfiJ3liYE9yCdPD+6iL8zIRIkB0kYu2ty1J7Jy3JL7K2oIjpZ
 NUc3GjS/fcjxItPIupo6amSmWwhmMcoCzk8ar5equpLT8GPcsBNiNULoS/11aLkp+Btj
 E3TtClhASOE+yxQYJAQOJSxUamklTi+d/TlZjk8aQfwcMFeVVXUVMQ5IzhpiTYj6CeEx
 vRHBlXAqS8gbxo4gqBEoPmh3xGoXyJuHTF72Le0E1RDPgoVhwPgp5pGQu9wCwmDPixGa
 DtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017596; x=1698622396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL95SN/2P76ND6STZe+RzAs56cWUK0TNB9Zyz/t1iO0=;
 b=NkxqCCwf4B2LelgQbjrYMa+f4fUJboUi2IffCAdOjdvYTMwBGVhnxuxC7OZGnyNb6I
 zWNDRumqhg4UhQrr0OKPSwoH4btOCNKiCG55XQRUA81TEd/LKeYgA10yn71kfSCD9pza
 1uFyjs8JQ19FSQ/MGBHsK6UIJz28DqWH5zlGfgkGw/jeOuQgSg85oU032AEMvWn58tEr
 ujuuRMzYPgUhUEk1KRhL9qDUjIr1B1m4MHCrTl4+ZulIJfsuPyb6ijOo8yYM97ypk7fb
 6qBfRRLsg8NdDz6gTlKyQVpTWYNsv4JFK3OV+UcocHNCtZkqgzS9CAKSMjI5mz3/jF5v
 w0iA==
X-Gm-Message-State: AOJu0Yw5oo0J62acTkMfC8UOxrcdGMSisSsBMWQXc/+3uXNQfBVNjK+Y
 wBKR3C3f8aGJv/mROMd8V5bans6bki4goCaNR0Q=
X-Google-Smtp-Source: AGHT+IEjCbrVGAfUCyGwVnsTyf9F1RL2pFZZrjIq629TgB4lL5hAq1zGF6onb07VfwMqLEP5eTbxvQ==
X-Received: by 2002:a05:6a00:1702:b0:6be:7ee:9914 with SMTP id
 h2-20020a056a00170200b006be07ee9914mr5662435pfc.11.1698017596184; 
 Sun, 22 Oct 2023 16:33:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 49/94] target/sparc: Drop ifdef around get_asi and friends
Date: Sun, 22 Oct 2023 16:28:47 -0700
Message-Id: <20231022232932.80507-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 189 +++++++++++++++------------------------
 1 file changed, 72 insertions(+), 117 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 81277fb8ea..c2a2ee4621 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1900,7 +1900,6 @@ static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
 }
 
 /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 typedef enum {
     GET_ASI_HELPER,
     GET_ASI_EXCP,
@@ -2149,8 +2148,22 @@ static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
     return resolve_asi(dc, asi, memop);
 }
 
-static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
-                       int insn, MemOp memop)
+#if defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+
+static void gen_helper_st_asi(TCGv_env e, TCGv a, TCGv_i64 r,
+                              TCGv_i32 asi, TCGv_i32 mop)
+{
+    g_assert_not_reached();
+}
+#endif
+
+static void __attribute__((unused))
+gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2184,8 +2197,8 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
     }
 }
 
-static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
-                       int insn, MemOp memop)
+static void __attribute__((unused))
+gen_st_asi(DisasContext *dc, TCGv src, TCGv addr, int insn, MemOp memop)
 {
     DisasASI da = get_asi(dc, insn, memop);
 
@@ -2260,8 +2273,8 @@ static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
     }
 }
 
-static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
-                         TCGv addr, int insn)
+static void __attribute__((unused))
+gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
 
@@ -2278,8 +2291,8 @@ static void gen_swap_asi(DisasContext *dc, TCGv dst, TCGv src,
     }
 }
 
-static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                        int insn, int rd)
+static void __attribute__((unused))
+gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUL);
     TCGv oldv;
@@ -2300,7 +2313,8 @@ static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
     }
 }
 
-static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
+static void __attribute__((unused))
+gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
 {
     DisasASI da = get_asi(dc, insn, MO_UB);
 
@@ -2335,11 +2349,9 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
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
@@ -2447,8 +2459,8 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,
     }
 }
 
-static void gen_stf_asi(DisasContext *dc, TCGv addr,
-                        int insn, int size, int rd)
+static void __attribute__((unused))
+gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
     DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL : MO_TEUQ));
     TCGv_i32 d32;
@@ -2530,21 +2542,23 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,
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
@@ -2558,9 +2572,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
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
@@ -2580,9 +2594,9 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
 
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
@@ -2592,8 +2606,8 @@ static void gen_ldda_asi(DisasContext *dc, TCGv addr, int insn, int rd)
     gen_store_gpr(dc, rd + 1, lo);
 }
 
-static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv lo = gen_load_gpr(dc, rd + 1);
@@ -2603,10 +2617,11 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
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
@@ -2617,15 +2632,37 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
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
@@ -2636,9 +2673,9 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
 
             /* See above.  */
             if ((da.memop & MO_BSWAP) == MO_TE) {
-                tcg_gen_concat32_i64(t64, lo, hi);
+                tcg_gen_concat_tl_i64(t64, lo, hi);
             } else {
-                tcg_gen_concat32_i64(t64, hi, lo);
+                tcg_gen_concat_tl_i64(t64, hi, lo);
             }
 
             save_state(dc);
@@ -2648,8 +2685,8 @@ static void gen_stda_asi(DisasContext *dc, TCGv hi, TCGv addr,
     }
 }
 
-static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
-                         int insn, int rd)
+static void __attribute__((unused))
+gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
 {
     DisasASI da = get_asi(dc, insn, MO_TEUQ);
     TCGv oldv;
@@ -2670,88 +2707,6 @@ static void gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
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


