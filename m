Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 783117CBAE2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdOJ-0004Qt-S7; Tue, 17 Oct 2023 02:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdOF-0004Dc-Ak
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:17:15 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNs-0004pr-A5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:17:09 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57bb6b1f764so3534138eaf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523411; x=1698128211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBVDczIzJd36UTe8IiE5Bt+zb8ayI5XWrKAn966xiPE=;
 b=To5HvP2eINqQ8/vgN8SQunkz4e3xKi0TXWRMpExzrUo8Y1HAW3/1OZijnpjBsbPdG6
 /T2C51EC6jW6y4QCJEFn0h2TIJAyalkl99XxH+XpfbbjNBTw4XGTBlCzb6GKdL1mRHlH
 hzmeG9PtRJPxCX/m1soeiLmMGIsiuclrdqaGdR4aSzI6mSNK46dg2AS4ANNdT4zZfdbl
 tQXVcqYGrGyBfZb8RKjtZCppS4MAC6ldCZAo0k7WmtQLaDDqf1jDP6/BIKmDXh73JdAk
 FGLWsQlb+pkKrHAGAXBfH3fIrXnuMPCtO2kX7uCCZwKxLP89yvcOnWtn++QL77U3Rrvj
 B4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523411; x=1698128211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBVDczIzJd36UTe8IiE5Bt+zb8ayI5XWrKAn966xiPE=;
 b=ZWkEU8TISAL1EF+JEvvZqSObeXOUWjhVGuT5LDXX56wRM4Lhilsr6nITNG0w9ImBjM
 u+EvfKIHIXGVbOydkliShmTC+luxYLh7Xbrr8qvIUmDcHqwrp1XLisj4bcrAC8nWTlFW
 BLnFxnshB1XPQFYNZLDrvjOh06doR/yyiD4vBGeS6svnkeejs1yp3H6jQcBEtFcgeX1K
 2NuMcurt7qj47sg2h3U4AkkO6WXilnw+/K+wRK6QwLH+N4lmlo0TECLZ5/6lQYjkdTRf
 0RM/mMuPZ7nNeeR3JJQPgYTTlD45Jjw/JFuAjJpqf6rdlifOdOBuG6+LpZ3ebylGrZOV
 View==
X-Gm-Message-State: AOJu0YxGGL4wnjoKTUFmE72UHPosJrXMe2NPihS38bPF2iaJhLPOPKFT
 lgUcp2h57tw1ZzGPF3CkVfe0tTaxBaAh/emgd1c=
X-Google-Smtp-Source: AGHT+IFKmr7VDE2MMSLaRsxWEY2LDh3b+zymJThDKwdvBHMPysZ1P1ZcvLNoXEQEcoEkLtJY66NKcw==
X-Received: by 2002:a05:6359:2ea3:b0:166:cae0:6e19 with SMTP id
 rp35-20020a0563592ea300b00166cae06e19mr1617518rwb.3.1697523411222; 
 Mon, 16 Oct 2023 23:16:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 77/90] target/sparc: Move FDMULQ to decodetree
Date: Mon, 16 Oct 2023 23:12:31 -0700
Message-Id: <20231017061244.681584-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 96d9139d21..a98b3b2bdd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -254,6 +254,7 @@ FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
+FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7f94bb99e0..28d63c9915 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1624,21 +1624,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-
-    gen(tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_fop_DF(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
@@ -5069,6 +5054,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
 TRANS(FMULq, ALL, do_env_qqq, a, gen_helper_fmulq)
 TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
 
+static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_fdmulq(tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5135,11 +5141,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
-- 
2.34.1


