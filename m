Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 670167D7989
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA9-0004xJ-Jf; Wed, 25 Oct 2023 20:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9e-0002zc-SQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9W-0008Ev-If
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ac865d1358so301870a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279789; x=1698884589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFG3LVvfi+A5uqJYCl0wfU1RjeC2BCq05T39q27kqdA=;
 b=RuVv6tB4dFE8dAvArjZKVjcUg6b8aa6PMJ6c5I6vLpLUUcZoHVcTEb68VDDSoAC9pY
 jmGGJnGP66o5kOsG6FxBPHAnu0l1YyawvKjyew24o0soDF0hCimr9Zj3Dlr4zk7nIZhM
 O+IpqstwNkESDpCPhZgEssV0ufPlAip05wWLwXbc7ArpnlGmCB9G4pSkrTfs7ckFlSEQ
 0epDhX+8EPNmywyE40s+2QX9gRF70AYmnAJyOtgwAUh+ux3HiOb4ckhQUrKvknLvpKss
 6bHyXebYTmV9g2EuDOlTfknI746EvGawWRn8c0FU29NchZgkcnvrymX0Vm+OwAnb1GUN
 LobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279789; x=1698884589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFG3LVvfi+A5uqJYCl0wfU1RjeC2BCq05T39q27kqdA=;
 b=QbBvKnoUemCxbK3jD7BVwXY5uydAeB7BsC/iITwNGhlxy1LTLqWwJElIjWsvlhMD74
 YpOSJGA1p67oyxamVZXqBAKtkZ1I46EBlF1Vc/iphwkva7y4QwxjIFXHE+0LBX0JhHAa
 E+uGNiXxGUlBhDZlioAuxqfuyyEC8AxSFfHhK4wz8CoIDnTzJU0i/D/dOhTCrpHcRD4W
 NlkxOwvG9CbT06zXX6MEgqYyTbhtFTi9qzXx+eC+gqNoEJr396IcSNh95NdGXAJ7kpVI
 yJfirLnXhdWrKRiE5FwtWqmT4Ra9U2OVHXa9U0qcNdqf9edsWRz6dAHfirrSmIj8p1+Z
 K/QA==
X-Gm-Message-State: AOJu0YyaM1d6G+oL/zuNiaznBmX47lEqyszZztM6dUMl7VvJpyyAXahw
 OcZk5FUNubhXdxSXB5SGfEQ03UhhJeSTt/QG2aQ=
X-Google-Smtp-Source: AGHT+IHD07ATmDS6YFyNjlsRo7PBN8mw+xFycJjHINTMYBEoiFxBu66E1SX7iJALlRY2TlJwlc4asg==
X-Received: by 2002:a17:90b:2d8d:b0:27d:4ab9:fccb with SMTP id
 sj13-20020a17090b2d8d00b0027d4ab9fccbmr14930344pjb.5.1698279788983; 
 Wed, 25 Oct 2023 17:23:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 75/94] target/sparc: Move gen_fop_DD insns to decodetree
Date: Wed, 25 Oct 2023 17:15:23 -0700
Message-Id: <20231026001542.1141412-105-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move FSQRTd, FxTOd, FdTOx.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 50 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 85464285b7..1d766fab21 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -246,6 +246,9 @@ FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 13932e087d..307fbc4628 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -63,6 +63,7 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
@@ -72,6 +73,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
@@ -1669,20 +1671,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static void gen_fop_DD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 dst, src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4835,6 +4823,28 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
 TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
 TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
 
+static bool do_env_dd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i64))
+{
+    TCGv_i64 dst, src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
+TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
+TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -4977,10 +4987,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x29: /* fsqrts */
                 case 0xc4: /* fitos */
                 case 0xd1: /* fstoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
-                    break;
+                case 0x82: /* V9 fdtox */
+                case 0x88: /* V9 fxtod */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
@@ -5085,9 +5095,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                     gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
                     break;
-                case 0x82: /* V9 fdtox */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fdtox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
@@ -5095,9 +5102,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x84: /* V9 fxtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
                     break;
-                case 0x88: /* V9 fxtod */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fxtod);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


