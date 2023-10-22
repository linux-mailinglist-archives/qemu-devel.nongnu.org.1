Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 654127D215F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRay-00049u-IY; Sun, 22 Oct 2023 02:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaB-0001UO-Gf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:04 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa9-0002J9-9M
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:02 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-584042a01eeso1440384eaf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954699; x=1698559499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wobaPdMLmdNNcr2LxtwQ6wdYNx2FFwm+kYJQe6jhC/o=;
 b=MJF5p0lvhXBq8PEp0c4cunHN9MNkkkNtnyUC8f3gPiCBJMA0dnlODUdydrh3stBVec
 6wNTmd+z1iric5Xil6rAFkJ4yOOBNgoUcN/r94ShYRHxZD3SdO+R0kbzGGxyR4hTp5pV
 l3TyPCaEVU9GSapvIQ/+/fkVn/3KOdtiPJaHT+wBFbA449Ev+qeHEWMX1rJl5QmYqfii
 drdfJ2E1/nnDPP+/x3bEEraEfZ7nf8i7r0ejAYvQYYvVW4IObfZwCkr9a9vswlcVyQIW
 0ktZJy/wamPkyngshnNo6gKCOGao3cXzk0ExWVAhWu1xVFRPV/0yoN9B8A6uVCUzZBm9
 Rc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954699; x=1698559499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wobaPdMLmdNNcr2LxtwQ6wdYNx2FFwm+kYJQe6jhC/o=;
 b=CaSz4GaE2tjwnp6TKo1C7e/tl/045FfP175wP743qyd0rlwADISWDOcnCdx6k4U9HL
 07BU9QbmIM4rtPUZMClhNxsd67cJiIRObe0ol4pAOkympHosRf86UXWVuoLzvuCn75kN
 HbzPwlV2u5rCqOh0cThFUaHXOO0C9tQdH8kEJlqceSvljG6O5igOjompb6dW7qyNd9SC
 eaxc8YuMLhWwD0IoVirXyIfEDg5+JipvFeg7n5nR0twPRCGctficqBrJjSidWBQtyD2s
 UGDYKqVIapchKpIBjGI3TUXfY//qX/b7RHPyppEO0L3hR5K/oxutIvEH7WkODRfcchHA
 h5Ww==
X-Gm-Message-State: AOJu0Yxizyp0FgwwtVzYP4gi3dhgx1+Aw2bUmCicyVKsddf8mTxnXWvF
 jyyoyWUiaJnOp7VEYWtOHwB15bZxpPoAbnV65Xk=
X-Google-Smtp-Source: AGHT+IHFMkK6p/I6vMxf9FuSqu7d2vDKlBNxDtnvg6PTX6oyz6TrfBJlf19KXpa6U2uKiBj8iQPS8g==
X-Received: by 2002:a05:6358:5922:b0:142:eb11:b0b8 with SMTP id
 g34-20020a056358592200b00142eb11b0b8mr6936124rwf.1.1697954698887; 
 Sat, 21 Oct 2023 23:04:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 68/90] target/sparc: Move PDIST to decodetree
Date: Sat, 21 Oct 2023 23:00:09 -0700
Message-Id: <20231022060031.490251-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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
index 51f96d2253..ebcc8fae6b 100644
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
@@ -1676,21 +1677,6 @@ static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 
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
@@ -5063,6 +5049,26 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
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
@@ -5472,6 +5478,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x039: /* VIS I fmuld8ulx16 */
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
+                case 0x03e: /* VIS I pdist */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5547,10 +5554,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


