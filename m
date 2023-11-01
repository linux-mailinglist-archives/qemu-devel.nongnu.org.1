Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7C7DDBD3
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aP-00065N-6l; Wed, 01 Nov 2023 00:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2aL-00064P-Be
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:12:05 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a7-0007aH-1d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:12:05 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce2de8da87so4125041a34.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811910; x=1699416710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpZuzrzwSlvvsjA8kEYOZtIcA1fO/m3N7DPDJHvFsS0=;
 b=Ikhg733hOSazb2mESxIzXru8xTrCD8RJQ1NQFMLXlAwVZ+Z/vJOFlmxKv8VMywxZvS
 6pNIj54HfZgEm7FipEGeeiUxmCzjOyijzH/jsC0ghWwxbrKnBlhqD96QK9f8nw1IuK6V
 I2edrmSG7stPcoEj2siLCFLPJ82RQ/J7JqssKtnuXGHV5Md8O45vRKd+/umI/vuJS/xJ
 4llvecG+6DfcJXIv/OfQ0bIp2IHy/sUmbDkttFVT8LbypIrBjiGfYBC0rCLDtBHkEXKu
 bYUcsmiEHB+05MGMUzxWE2E2wm0tnouJogJJuC98rDTHTzcsXI/VN4zaxFKAoS57EyFs
 mAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811910; x=1699416710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpZuzrzwSlvvsjA8kEYOZtIcA1fO/m3N7DPDJHvFsS0=;
 b=lZ5p1SeQ+d3IZD/PbjuQDzoE4FTn3DkKFh6VrUh7lPYgHx7U6fQ+ZU8ofbhtNVPJc8
 Ebm08SBE+CRmDLRN2QRYQeKN2tLERCp68arMuwHbT3ZQxFLKhTkU+JHn/wgrRksKec42
 6owf3p2pavO/10Q5Ind60OAygNw3O4kPhd5zZb+i3eHNPcbjPM4EIvgBbHdHAgBSv4QE
 1KYoVsuM3TLLxa/vJc4/AerxmKmasprVXumaYS11UCtdjkwSYO2JcKC5kiWnoTvAlEDS
 eWt1SLw9c+MbGIBs8IW0cSGPMiEwMPUAQgBpNzgdsniLfYIUn7a2ktZwDzw/POd3Bchc
 rq0Q==
X-Gm-Message-State: AOJu0Yy8QH84123F6WkMNRn3Pk6HyPxTqTck2OVXmVOfWvV9jelE/fqE
 Y1qsSw8mxXXQuKhRlgvHRSI7uhUDLHVulNjftus=
X-Google-Smtp-Source: AGHT+IGDZjJhQXBn8mhdVgtfGi8J46gNyAsyY6ndq52/QURb+VwfzaNOafJsbW9bF88k+ZieCFI1Zw==
X-Received: by 2002:a05:6808:bc6:b0:3b2:dd49:4e9d with SMTP id
 o6-20020a0568080bc600b003b2dd494e9dmr20971817oik.6.1698811909942; 
 Tue, 31 Oct 2023 21:11:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 19/21] target/sparc: Implement UDIVX and SDIVX inline
Date: Tue, 31 Oct 2023 21:11:30 -0700
Message-Id: <20231101041132.174501-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |   4 --
 target/sparc/insns.decode |   4 +-
 target/sparc/helper.c     |  24 ---------
 target/sparc/translate.c  | 109 +++++++++++++++++++++++++++++++++-----
 4 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index decd94c0d6..55eff66283 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -31,10 +31,6 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
-#ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(sdivx, TCG_CALL_NO_WG, s64, env, s64, s64)
-DEF_HELPER_FLAGS_3(udivx, TCG_CALL_NO_WG, i64, env, i64, i64)
-#endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0552f1447d..52f54b87cc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -182,8 +182,8 @@ UMUL        10 ..... 0.1010 ..... . .............          @r_r_ri_cc
 SMUL        10 ..... 0.1011 ..... . .............          @r_r_ri_cc
 MULScc      10 ..... 100100 ..... . .............          @r_r_ri_cc1
 
-UDIVX       10 ..... 001101 ..... . .............          @r_r_ri_cc0
-SDIVX       10 ..... 101101 ..... . .............          @r_r_ri_cc0
+UDIVX       10 ..... 001101 ..... . .............          @r_r_ri
+SDIVX       10 ..... 101101 ..... . .............          @r_r_ri
 UDIV        10 ..... 0.1110 ..... . .............          @r_r_ri_cc
 SDIV        10 ..... 0.1111 ..... . .............          @r_r_ri_cc
 
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 6117e99b55..bd10b60e4b 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -129,30 +129,6 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
     return (uint32_t)r;
 }
 
-#ifdef TARGET_SPARC64
-int64_t helper_sdivx(CPUSPARCState *env, int64_t a, int64_t b)
-{
-    if (b == 0) {
-        /* Raise divide by zero trap.  */
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
-    } else if (b == -1) {
-        /* Avoid overflow trap with i386 divide insn.  */
-        return -a;
-    } else {
-        return a / b;
-    }
-}
-
-uint64_t helper_udivx(CPUSPARCState *env, uint64_t a, uint64_t b)
-{
-    if (b == 0) {
-        /* Raise divide by zero trap.  */
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
-    }
-    return a / b;
-}
-#endif
-
 target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3564c6032e..95cc4c71f4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -51,12 +51,10 @@
 # define gen_helper_restored(E)                 qemu_build_not_reached()
 # define gen_helper_retry(E)                    qemu_build_not_reached()
 # define gen_helper_saved(E)                    qemu_build_not_reached()
-# define gen_helper_sdivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define gen_helper_tick_set_count(P, S)        qemu_build_not_reached()
 # define gen_helper_tick_set_limit(P, S)        qemu_build_not_reached()
-# define gen_helper_udivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrcwp(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrgl(E, S)                  qemu_build_not_reached()
@@ -579,16 +577,6 @@ static void gen_op_smul(TCGv dst, TCGv src1, TCGv src2)
     gen_op_multiply(dst, src1, src2, 1);
 }
 
-static void gen_op_udivx(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_helper_udivx(dst, tcg_env, src1, src2);
-}
-
-static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_helper_sdivx(dst, tcg_env, src1, src2);
-}
-
 static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
 {
 #ifdef TARGET_SPARC64
@@ -3580,8 +3568,6 @@ TRANS(UMUL, MUL, do_logic, a, gen_op_umul, NULL)
 TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 TRANS(MULScc, ALL, do_arith, a, NULL, NULL, gen_op_mulscc)
 
-TRANS(UDIVX, 64, do_arith, a, gen_op_udivx, NULL, NULL)
-TRANS(SDIVX, 64, do_arith, a, gen_op_sdivx, NULL, NULL)
 TRANS(UDIV, DIV, do_arith, a, gen_op_udiv, NULL, gen_op_udivcc)
 TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL, gen_op_sdivcc)
 
@@ -3605,6 +3591,101 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
     return do_logic(dc, a, tcg_gen_or_tl, tcg_gen_ori_tl);
 }
 
+static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv dst, src1, src2;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    if (a->imm) {
+        src2 = tcg_constant_tl(a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        src2 = cpu_regs[a->rs2_or_imm];
+        tcg_gen_brcondi_tl(TCG_COND_EQ, src2, 0, lab);
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_gpr(dc, a->rs1);
+
+    tcg_gen_divu_tl(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv dst, src1, src2;
+
+    if (!avail_64(dc)) {
+        return false;
+    }
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    if (unlikely(a->rs2_or_imm == 0)) {
+        gen_exception(dc, TT_DIV_ZERO);
+        return true;
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_gpr(dc, a->rs1);
+
+    if (a->imm) {
+        if (unlikely(a->rs2_or_imm == -1)) {
+            tcg_gen_neg_tl(dst, src1);
+            gen_store_gpr(dc, a->rd, dst);
+            return advance_pc(dc);
+        }
+        src2 = tcg_constant_tl(a->rs2_or_imm);
+    } else {
+        TCGLabel *lab;
+        TCGv t1, t2;
+
+        finishing_insn(dc);
+        flush_cond(dc);
+
+        lab = delay_exception(dc, TT_DIV_ZERO);
+        src2 = cpu_regs[a->rs2_or_imm];
+        tcg_gen_brcondi_tl(TCG_COND_EQ, src2, 0, lab);
+
+        /*
+         * Need to avoid INT64_MIN / -1, which will trap on x86 host.
+         * Set SRC2 to 1 as a new divisor, to produce the correct result.
+         */
+        t1 = tcg_temp_new();
+        t2 = tcg_temp_new();
+        tcg_gen_setcondi_tl(TCG_COND_EQ, t1, src1, (target_long)INT64_MIN);
+        tcg_gen_setcondi_tl(TCG_COND_EQ, t2, src2, -1);
+        tcg_gen_and_tl(t1, t1, t2);
+        tcg_gen_movcond_tl(TCG_COND_NE, t1, t1, tcg_constant_tl(0),
+                           tcg_constant_tl(1), src2);
+        src2 = t1;
+    }
+
+    tcg_gen_div_tl(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
                      int width, bool cc, bool left)
 {
-- 
2.34.1


