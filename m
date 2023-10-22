Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6804A7D272E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx9-0006yF-HT; Sun, 22 Oct 2023 19:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx0-0006YL-4P
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:42 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwv-0007lS-PH
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:41 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so107987539f.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017616; x=1698622416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNsHxI8bIzopE9R3HNUQ8PwyH45Fz5eZKoBnXj6h7VQ=;
 b=UZI3g9UjL2QGV0MZ1N9thoGZwiJniSI1Xxd3LkLiidm/l9r5isYxHEnNb9iP0pphUv
 XtvMyZYOIxfqtfh/0ShnZzsi7uMoGpfDmGLMt0FKMzMzwJUS9iKOX0D0LWBFxd/II+XF
 aL0buv8/Oyw6YFVp3ERqDMeei/Q5PzPX6Bp4kiMp0UngQWyO/0BGHouZTyX8C3TVQO6W
 QUofPsKnBPGVDJF1d4c6a3klHplnIXU+K18+bzaEEmPlSzDGr9z3OjSnZmN2J0U0e5Gz
 g55X1BSm0PwblrQ82FGE64OUMvPZ6qTbWKoZEqprdzUnfZpSgOz6rv1XqgMTacHsqBsZ
 jW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017616; x=1698622416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNsHxI8bIzopE9R3HNUQ8PwyH45Fz5eZKoBnXj6h7VQ=;
 b=OhCM5/Adj0HzkRMBjt6UIble+xnGRunD9Zi4xueo4OmqUzc5u4CJ+146V/QKyjvIFt
 3m1Ck6Ov8g9ssgjH5BQYyrNKsNxtHXohXiHk8Ah2rxvAC3MsdmLXiLh+A2lbN4Et6xPH
 8v2cSaDgay3lbaibNVHxkn4+zYsUT/ldlpclxV6ySLiFKvKZyBAZNyAnyJOg/q1t/Q1u
 ezjK9ognMOR6zZGLty1GI6MU5Uh26bwlLyXdC3Pqg7LMTgAcK/JIojrhIP9wlEccsX4+
 ZNX2FUNBREXyHxCAp41LHpKYSBGWtd2te16oD0dy6rAy4drupGHIVSgkp2X2R1dTHVzU
 PJew==
X-Gm-Message-State: AOJu0YyGZJrhqOz6s/+9BHC/jlAwC4V5DVTgm2geCixB+BytFWUB9cce
 zGBRaNhDolJJJ/9Jm5J2W5yhwwKkjFFCpWhihV8=
X-Google-Smtp-Source: AGHT+IH1D1x7iwu6KsXXLkW5rpVzFvOqsosOw+OKQoFQKWCXT1DOGPwnrl18ceuWAJ1DDu9rMUzsXQ==
X-Received: by 2002:a92:d2d2:0:b0:357:70f3:c431 with SMTP id
 w18-20020a92d2d2000000b0035770f3c431mr8900352ilg.9.1698017616567; 
 Sun, 22 Oct 2023 16:33:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 74/94] target/sparc: Move gen_fop_FF insns to decodetree
Date: Sun, 22 Oct 2023 16:29:12 -0700
Message-Id: <20231022232932.80507-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2d.google.com
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

Move FSQRTs, FiTOs, FsTOi.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 47 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index bc449023dd..85464285b7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -245,6 +245,9 @@ FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 25f3fea74e..db964002b7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1654,20 +1654,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_FF(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4803,6 +4789,27 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_env_ff(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tcg_env, tmp);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
+TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
+TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -4964,10 +4971,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2: /* V9 fmovd */
                 case 0x6: /* V9 fnegd */
                 case 0xa: /* V9 fabsd */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
-                    break;
+                case 0xc4: /* fitos */
+                case 0xd1: /* fstoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
                     gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
                     break;
@@ -5023,9 +5030,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
                     break;
-                case 0xc4: /* fitos */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fitos);
-                    break;
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
@@ -5055,9 +5059,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd1: /* fstoi */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fstoi);
-                    break;
                 case 0xd2: /* fdtoi */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
                     break;
-- 
2.34.1


