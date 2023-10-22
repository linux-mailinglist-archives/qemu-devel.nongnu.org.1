Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E53887D274D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx4-0006c7-U7; Sun, 22 Oct 2023 19:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwy-0006XM-BK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwu-0007ka-9q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so2638603b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017615; x=1698622415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kshPMHakV2bUC6chskAF4IgYKibFojIFtVCgyadZKng=;
 b=OakUuecrFgIEdVYellHhcWoWxFYaJVoBWY3IuKTst/Pbk0pH8wqAn5O1dzPH6MC2nn
 xtKPC8omsDuWJ9s9nNG7DdAX8L0CDy3ZYzhqGDpFKNDlqpTev+V9eJWz/Ak33O5BcsmE
 D+DiG4yoepAO425gMNDP9fp8nJS4zvdPDiEl3+DnZViLw3v/nM+nLHsLuX5WI7JxWUfI
 +UC1SEUIVHybjlVecvsDdXRH/wPD58JPOGQWZrUcOsTSbzHicYtQ2ok36LY7j6WQ52sC
 pr2Wk++nN6cRGuEfBeNrJ6JcRRCrzIotwjAArprDWqB41a2oonwZeFTUZNc/Mu2Q/Mmp
 uJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017615; x=1698622415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kshPMHakV2bUC6chskAF4IgYKibFojIFtVCgyadZKng=;
 b=p5z3euu/0hhwFm6+VEerPL3F3u26aptiVoDM1cmaRQmf2Xg3V2k9f+95CChHUyiGt8
 Tft9moYjVBmSE+6tgA8eEbvb7/xQ7xJn+qelmRrPFen5p+HSUh4q4BzSZIpv4NH7utPq
 J6yOertEovwKOVxIJFdkwoMffyLNBAmvTAnrLV/u68/Yl4DgBAUITes9bWEaRjSWKlGB
 olmyIJRlUH+aRqe+n5UNmB+Z+kR5KchoLgTA659s18yjfv0lbSKWIU0isq3TPHs9HDDP
 wxHmKBvc1W6EzNOw7KZ6byC0qFP7Be3p5lj0VMZfZH/nXxgVle9eZqkOmRf8TmihvewV
 X8ZA==
X-Gm-Message-State: AOJu0YwQa4otTWavF96e969Qya5FaOIj8lOnm4dYBszWTgZSGUXJqPoa
 AELwM/ZQqpGVuMQ1LQVy6Khy7Sz3DdwBWb04UiQ=
X-Google-Smtp-Source: AGHT+IElYKJh+30MsJ/uNTvcF5p3o3uhrkUr5nVMul+UusoB5RH5XK6JUGl8H4VQBaDKjgQh3ouDwg==
X-Received: by 2002:a05:6a00:230a:b0:68f:dfea:9100 with SMTP id
 h10-20020a056a00230a00b0068fdfea9100mr9454577pfh.21.1698017614991; 
 Sun, 22 Oct 2023 16:33:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 72/94] target/sparc: Move PDIST to decodetree
Date: Sun, 22 Oct 2023 16:29:10 -0700
Message-Id: <20231022232932.80507-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0e29629b5c..42d740ad44 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -277,6 +277,7 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c33a95b44b..60ae716802 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -72,6 +72,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
 # define MAXTL_MASK                             0
@@ -1680,21 +1681,6 @@ static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 
     gen_store_fpr_D(dc, rd, dst);
 }
-
-static void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
-                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src0, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    src0 = gen_load_fpr_D(dc, rd);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src0, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
 #endif
 
 static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
@@ -4900,6 +4886,26 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
+                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src0, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = gen_dest_fpr_D(dc, a->rd);
+    src0 = gen_load_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src0, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5309,6 +5315,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x039: /* VIS I fmuld8ulx16 */
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
+                case 0x03e: /* VIS I pdist */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5384,10 +5391,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x03e: /* VIS I pdist */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDDD(dc, rd, rs1, rs2, gen_helper_pdist);
-                    break;
                 case 0x048: /* VIS I faligndata */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
-- 
2.34.1


