Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811657CBB24
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNv-0003fD-JZ; Tue, 17 Oct 2023 02:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNq-0003T9-8i
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNm-0004nR-Qo
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso1395169b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523405; x=1698128205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwVmSHeYexn71dvX+8E6usFelzw3up8bbDGmKt8+qZ4=;
 b=dntQXuWFDPWlreCAU6lzkMjiFOCQVudOkHA4LIptVHuuAOqWVbqQU3jcG/G9V00yCM
 OW5nDihy9ja+iTibpw2whwxdik7gCGbXfCd1dw/hRetwN8LsXWAFbjtXttFizP68ymws
 DWIgQ7w+aj2bkt+8CHeWJ3U2DwEwa+Q1P0/qi/+CrmDf+jyzaD5CDkCe+Yw8dHhEnzrA
 HumxSsflnCLUg2v5lHNueX9ckHaaK5dxM3y70aWUI4g0YU8DF9BhzsXEXTW3H2sJgNI4
 UJoHkE4W7qoP3GnxyyEMP3BcqTFbNbywcxzBKClA29wYfWVFzHRjMrhpV/ILzcEyvt3D
 t3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523405; x=1698128205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwVmSHeYexn71dvX+8E6usFelzw3up8bbDGmKt8+qZ4=;
 b=hknqXpF+QPx9VsmKkleSBpwPFLxkDsUjBSYzhD9klZzzD8ZgDfUxCVlwKf4YBBnIJ2
 EhOoqxuCZWwIStjErkLtETUypRWgu2FcANoRE4OS5EYfJJm07XKszZNubGEkU9tJM3dY
 /T+wv8Jw0F1AcXWQ8VQurps3QUc48r6ec7VBkBCrcbYrYGMo2gvTmMdcvIGbu8DXeap7
 cSkBYiISsLkTFbgTBDLUpWc1ved1Za6zagnn+VzB767jP/i4uaSdTXEKd7/Fo3FN0ZUV
 Evd33nM/E64cv0KxNtBXN4pHbS5M4eHZs287jrtnFa1NPk60/9V8PIZCgtdtkcQtYb5H
 bIVg==
X-Gm-Message-State: AOJu0Yy2wcxGUd5HpmCPmECRAa4Wk+j8dVVzsgM8eEr6xvni1mqRKIZR
 SnpMUUQXDBcjrz9hBB4oVTtCJbeQ3h7Sk6G7ZdE=
X-Google-Smtp-Source: AGHT+IFAv6iw6lgZSzIm5TrzvWneWonrVxqqJKNXTRr0gERT2i2qfVnnraR3yEtj9CIHuPqRlZJAEQ==
X-Received: by 2002:a05:6a00:1827:b0:6be:2e07:5c5c with SMTP id
 y39-20020a056a00182700b006be2e075c5cmr1397372pfa.20.1697523405296; 
 Mon, 16 Oct 2023 23:16:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 70/90] target/sparc: Move gen_fop_FF insns to decodetree
Date: Mon, 16 Oct 2023 23:12:24 -0700
Message-Id: <20231017061244.681584-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 47 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 966cda6680..4f10809e98 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -238,6 +238,9 @@ FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cd585b77bc..6707164207 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1608,20 +1608,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -4892,6 +4878,27 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
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
@@ -5053,10 +5060,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5112,9 +5119,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
                     break;
-                case 0xc4: /* fitos */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fitos);
-                    break;
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
@@ -5144,9 +5148,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


