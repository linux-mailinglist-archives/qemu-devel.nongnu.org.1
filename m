Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40D7C8F5A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmM-0002cW-8h; Fri, 13 Oct 2023 17:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm5-000156-IG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:49 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm3-0001Wq-F8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:49 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57de6e502fcso1377749eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232766; x=1697837566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ExSfYzeDVp6EigNCTB/x1jsV6gbwxUmalA4VP4i7XM=;
 b=E3y7MYm+dBdyBjSX/vca9zeXMRhcglBVYiwbLtjhZuXkuvKmr7/su578sH41vfiE8B
 m9Qqa9Xg0+ZYagw6Nas81CTtEX8+hFmfyCGs8YBYjqdLuAe9xVYNrSGbZ4VmeX0Mnlf7
 pJ+tGUvcI5OoNLRux+SQ6VuXwCOvgqHdS1xOIR54L2LHjzT255aENQ+164AeXIZfssaU
 XK66J7O9nKvnVFRe99exrmGANHDpNib9FVP6XJYohrJgZyWvJJ4w2OtmjvV4udwsbcwY
 kiNzxlA9p9SnN+jMZEG53xCwyRyMCk8Rw/kFR83VZeNbiVv1XLonLeIJpLgRHm3Abs+M
 z6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232766; x=1697837566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ExSfYzeDVp6EigNCTB/x1jsV6gbwxUmalA4VP4i7XM=;
 b=dHwsOxvOneXNQ1bAv6aI59eH1o0y7OopREH3/S4YqXoNe6bR1ORQG0moCLUtuQdz7m
 7PPJVxb3h4w+Z+YZg7FObo61BLQh+UWGrws7tiAzCn+tma78bzIz4fqpVWM22XuM9L8B
 Y6WUgVkLOedvqynSVpAlgyhlj4pwKAdiDFfjHx4GXLBAli38TVH3NOpTfrwfZUklSqJ1
 Le9Wypyu9CsXoMUkVSrRWFhfD1p8yE6xhCRy8OTwbZ6y4VIPjtc/RGCvaawRiRURDBpD
 eF5/Cap2xmGaPEJj2e+cweiBjdLF6hMZRQpawvn5R79XfbFOMYF9JUcgrH87FnU7yRK4
 zHdQ==
X-Gm-Message-State: AOJu0YzDKYGUbuJrk9ksN5kylPwaxy6VPx8nIAbgP7UsoqY2KWsJxPyA
 guRMb9eHmJj/R8SSfv1tly6/C9U4RLThdY05kX4=
X-Google-Smtp-Source: AGHT+IH46HipIZpKGGCVv42d2B1cMsVGZIhT/kbpaN93KGJ+UoHJaA5k25/i+PogAyY7iw6xEuaf4g==
X-Received: by 2002:a05:6358:9485:b0:135:46d9:12f7 with SMTP id
 i5-20020a056358948500b0013546d912f7mr26311399rwb.26.1697232766295; 
 Fri, 13 Oct 2023 14:32:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 63/85] target/sparc: Move PDIST to decodetree
Date: Fri, 13 Oct 2023 14:28:24 -0700
Message-Id: <20231013212846.165724-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
index 576349a719..12db108a31 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -271,6 +271,7 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8b16772a71..5da3170978 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -68,6 +68,7 @@
 #define gen_helper_fmuld8ulx16          ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
+#define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -1549,21 +1550,6 @@ static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 
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
@@ -4887,6 +4873,26 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
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
@@ -5296,6 +5302,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x039: /* VIS I fmuld8ulx16 */
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
+                case 0x03e: /* VIS I pdist */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5371,10 +5378,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


