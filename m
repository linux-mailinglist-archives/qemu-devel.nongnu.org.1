Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBC7C8F2A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmR-0002eS-Qq; Fri, 13 Oct 2023 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm6-0001Gm-Hn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:50 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm4-0001X0-Eb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:50 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c665b2469dso1600685a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232767; x=1697837567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no+j+aOfCu7U1CN6BMLPKphfGA1mvhpsnYY9YQJOeo4=;
 b=dh7QCQr1HSaFMnxh/JxOHzi3fYqw5g8bR1vw3goEomcoaJJaEngkYvzGfrD8G2TVs/
 xfgHz9yZiVVoWq8zZKuYv148a7laqw/7jOU/3PXkUzpHT5Y7uk/pu+pRBErYB8JRU72R
 fhpFgUOshi0YN9hY+DxB5a7kFkiW0K9HVpRj4n9b37s6eoHEjvy8Y392LqHh8RANPDBq
 euWPNTEI4KJj6Cq5PvEsmbrT17PgVpZX9i8ylQyhsD35jY5JOTK3q01hCS34CoZGyNZS
 exMhlGYLAfFyA3003p+F0qCiFZlhhnpnR6G+XToSXMrcLQuvV8cPulhKmRodrWEF+jCL
 StdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232767; x=1697837567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=no+j+aOfCu7U1CN6BMLPKphfGA1mvhpsnYY9YQJOeo4=;
 b=RrzKmnMSTr0lAWjaTsREMqonr9e4XzVaK0dKp2ohcV7gpSt9TwhhXlIEmfF2yJ30ot
 CcN/rivyBm/Ad5zTR3H9NlsEEasA9bLlY00qUAhYyWN/rOwas37OrdYuNOJui9d0pDzW
 zmRQsslr8oQ21/XwUrTxqVFsI19pgY+UwXmDsfeSAjBFe1b0NHmdKe2q/7Wlhi5qhIqt
 W6ZoMAxBY0ICjdqsHEV1BvkiX6w5NC/vRvTU4koyoouDfQrI3g1yGTPLNYen02xALG5m
 00ft6IeUWkizZy6WKaz1p1+ZtPY+wSIPPQxvtOrU9gMQV6DFyDqV+CHEme5EoDA1368C
 igjA==
X-Gm-Message-State: AOJu0Ywybbi2QIN7HZC2wo7dzJbrUj8xfW56m40J9nrSmzj14ylp3UwE
 liw1zzgVsG4Fi2l5/5m84oq+DuDY09mWFBQhP4E=
X-Google-Smtp-Source: AGHT+IGrK18YcZkkL6TK4Zm+ELZX2McJQFhEHNTSW655tNgUU/ix1Qtb392Qi6zuW3S68x+S97hcPQ==
X-Received: by 2002:a9d:74d9:0:b0:6b8:7eef:a236 with SMTP id
 a25-20020a9d74d9000000b006b87eefa236mr29336086otl.30.1697232767220; 
 Fri, 13 Oct 2023 14:32:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 64/85] target/sparc: Move gen_gsr_fop_DDD insns to decodetree
Date: Fri, 13 Oct 2023 14:28:25 -0700
Message-Id: <20231013212846.165724-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
index 12db108a31..541b95c2dd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -271,9 +271,12 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
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
index 5da3170978..605a218255 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -686,6 +686,51 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
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
@@ -1536,22 +1581,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -2573,27 +2602,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
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
@@ -4873,6 +4881,10 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5303,6 +5315,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
                 case 0x03e: /* VIS I pdist */
+                case 0x03a: /* VIS I fpack32 */
+                case 0x048: /* VIS I faligndata */
+                case 0x04c: /* VIS II bshuffle */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5360,10 +5375,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5378,14 +5389,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


