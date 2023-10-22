Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DF7D214D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaz-0004Cr-Io; Sun, 22 Oct 2023 02:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaB-0001VL-NJ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:05 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa9-0002JR-9s
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:03 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2f28caab9so1505669b6e.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954700; x=1698559500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TR+fWlwCjtkGBaCz8luUNVYFZSetVObTTw4qwW/abek=;
 b=UwARxvkLmu40WyjmNYQwKx+YypVjDLPr22YkM4QtdJSLe+aqUDTwjjIxpeXfNjr4vG
 HcyR2RxC0fszOxWuGmt4eib1WyY5zm8SezZGYCJwfTGnSz8F558wbyuD4BnYEdt1rqV6
 WD3O0t9xFWD5kJJtJTJRB1a1QwJFX3Sq7WXp6tTOFZe2tIfNLx+bi70txdnasftPHCwW
 yW6BgkcZ2pobYTuNOU9h4LPHRtdVRc970dsVxYPqLI8NX23Li0PJmA+n0f8BDmE4g7Wk
 E0X3ovd/7F6/Kk4WvYyopQjqSt+jP3v/aHBahISQY8Dk4ARvoVJz1Y6tmsU/mZselbOZ
 rtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954700; x=1698559500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TR+fWlwCjtkGBaCz8luUNVYFZSetVObTTw4qwW/abek=;
 b=PaW0ewpvRtjTbi//sUlIseqy7FFfbMwtRP5fBG0Ti/R9r6I6dkJAivAZEKeM3voVRE
 qRUTRLOQlPF6VHhGjGjX9Yd7wdK1iPTAEjSozoDKyne1hPZ3zQa8kgHlvMGK7VRPaXGE
 8/pikiFbKFQmNjVFBgMLPd53jXRfRg9gYAhpGHtqZGLDfFIo0q/hv4rFgD5wBnBuuO4b
 OoSS1k7hLuezwhfyre1jVaqSrhXVn6tHvQDQc4A1LIso13m6pRLaAjXvN1m55FKDsVZI
 DnThvEGw+640iJJ4XgE+12AGlEGIBP7Ytcdpt6KCs91atMX+//tM+sSWdiPyFbRZ7rYI
 1YPg==
X-Gm-Message-State: AOJu0YwdeoJzmI2fJlCy6SDeSIg3clCVvVUeu3GvBXPqk4IfB9doeDDv
 P7INRYm43aGuChLXmkHj1UTCf6TD26RESt7HMTs=
X-Google-Smtp-Source: AGHT+IEczUv6hu9tVYVdVUZmbeEEiP6OrYn9AghOUX1xpN3au1vTkrsVwN7maYkHUxwfTntAlU7Fjw==
X-Received: by 2002:a05:6808:1c1:b0:3b2:f588:5a9c with SMTP id
 x1-20020a05680801c100b003b2f5885a9cmr6560572oic.6.1697954699793; 
 Sat, 21 Oct 2023 23:04:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 69/90] target/sparc: Move gen_gsr_fop_DDD insns to
 decodetree
Date: Sat, 21 Oct 2023 23:00:10 -0700
Message-Id: <20231022060031.490251-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Move FPACK32, FALIGNDATA, BSHUFFLE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   3 ++
 target/sparc/translate.c  | 101 ++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 42d740ad44..bc449023dd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -277,9 +277,12 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
+    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
+    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ebcc8fae6b..f60e7603d5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -748,6 +748,51 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_shli_tl(dst, dst, 2);
 }
 
+static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpack32(dst, cpu_gsr, src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv t1, t2, shift;
+
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    shift = tcg_temp_new();
+
+    tcg_gen_andi_tl(shift, cpu_gsr, 7);
+    tcg_gen_shli_tl(shift, shift, 3);
+    tcg_gen_shl_tl(t1, s1, shift);
+
+    /*
+     * A shift of 64 does not produce 0 in TCG.  Divide this into a
+     * shift of (up to 63) followed by a constant shift of 1.
+     */
+    tcg_gen_xori_tl(shift, shift, 63);
+    tcg_gen_shr_tl(t2, s2, shift);
+    tcg_gen_shri_tl(t2, t2, 1);
+
+    tcg_gen_or_tl(dst, t1, t2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_bshuffle(dst, cpu_gsr, src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -1663,22 +1708,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, cpu_gsr, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
 static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_ptr))
 {
@@ -2702,27 +2731,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
         tcg_gen_add_ptr(r_tsptr, r_tsptr, r_tl_tmp);
     }
 }
-
-static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
-{
-    TCGv t1, t2, shift;
-
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    shift = tcg_temp_new();
-
-    tcg_gen_andi_tl(shift, gsr, 7);
-    tcg_gen_shli_tl(shift, shift, 3);
-    tcg_gen_shl_tl(t1, s1, shift);
-
-    /* A shift of 64 does not produce 0 in TCG.  Divide this into a
-       shift of (up to 63) followed by a constant shift of 1.  */
-    tcg_gen_xori_tl(shift, shift, 63);
-    tcg_gen_shr_tl(t2, s2, shift);
-    tcg_gen_shri_tl(t2, t2, 1);
-
-    tcg_gen_or_tl(dst, t1, t2);
-}
 #endif
 
 static int extract_dfpreg(DisasContext *dc, int x)
@@ -5049,6 +5057,10 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5479,6 +5491,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
                 case 0x03e: /* VIS I pdist */
+                case 0x03a: /* VIS I fpack32 */
+                case 0x048: /* VIS I faligndata */
+                case 0x04c: /* VIS II bshuffle */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5536,10 +5551,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fcmpeq32(cpu_dst, cpu_src1_64, cpu_src2_64);
                     gen_store_gpr(dc, rd, cpu_dst);
                     break;
-                case 0x03a: /* VIS I fpack32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpack32);
-                    break;
                 case 0x03b: /* VIS I fpack16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
@@ -5554,14 +5565,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x048: /* VIS I faligndata */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
-                    break;
-                case 0x04c: /* VIS II bshuffle */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_bshuffle);
-                    break;
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


