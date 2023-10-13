Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FF7C8F4F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmE-00029R-Qh; Fri, 13 Oct 2023 17:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmA-0001nL-PE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm8-0001YO-Vg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso649765b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232772; x=1697837572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oooruiOv6h7ka+dZCOXFZY2mCMK7kriizLGIpTmucAw=;
 b=LR/4Y3MDtdeen5kZfI3YAfkaGy5Df/b0xiQchwpUBa/lxrgpPUcYCKFCIV5OBF0p+B
 Ee+qxcJjPcB8UGLRjapB1mKi4zy+ZvkDWt0uEtPgYBOe8lMx20S0OCvGGhYeGyVmIYxq
 qwqUOloN0J885Gzsxwo8B0rBQ4+TCOxBblH5Nwyp4qHGAVEjX00ar+07zwAUSdFNIs/e
 iCS3V5YHLhodTcU7O3/NkqjFUsq0m0XTV7ebVE22Huu2jWJiB21ahOpGTA6JCPbvQc39
 eyYE2NYQbozAWeqEn4FfzlXJzWu4gz7/suyAKi5tUhisM/SVKCVX3cbaSGQ2LhZ8tsTW
 Qn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232772; x=1697837572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oooruiOv6h7ka+dZCOXFZY2mCMK7kriizLGIpTmucAw=;
 b=ahyd8IvA1MRCfDrcFm2ofZE2RfeKpn5Kivp3Wk7mDQuVtBkk//kRHnNuNLHMRQpNEb
 vEzhKO58UG51rIBc8JlfMEi9PAEdILvk1AgU4gXK7EfE741rzQhvDh19mEgMAVtmCv5E
 PnW+6zeZNKVrQTgEJ9uzVIEovW5izE7G6V7Nq22wh9Wwis8pE53WSfa5ggSVjNOY+wyn
 XYjGFAKR0EshE75pNGijxarcXVfNCLLbnxjD3UacB1Yiq1IuBO6wsB7UFnMFXw52Zlsa
 oqP+yKTwnPINcLa8NV8V5Jojk13gOLocf2Z91trJf16iSy8uYpaAnH1wyceo/S/tROCt
 VqDQ==
X-Gm-Message-State: AOJu0YxpKoASJUizkf9KVTUxTTfAondiKyBqLZDWLodXNazuMklfmdmM
 ekDRy5Ma3Mq63/EjuXvGX5MdTvy+QFk9EcNhTtI=
X-Google-Smtp-Source: AGHT+IEsVIiQZ2fwRQ22HiEoiUNwvoaZ99t5JfB1iNQiyKNv3rW8/9te9vP9id0DX2wf5THE5Qcohw==
X-Received: by 2002:a05:6a00:21c5:b0:692:af9c:d96a with SMTP id
 t5-20020a056a0021c500b00692af9cd96amr27416782pfj.5.1697232771712; 
 Fri, 13 Oct 2023 14:32:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 69/85] target/sparc: Move gen_fop_DDD insns to decodetree
Date: Fri, 13 Oct 2023 14:28:30 -0700
Message-Id: <20231013212846.165724-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Move FADDd, FSUBd, FMULd, FDIVd.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 55 ++++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fcf4704ef8..5c7b918462 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -243,9 +243,13 @@ FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
+FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
+FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
+FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
+FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9d68c8cc20..b7e0207405 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1526,21 +1526,6 @@ static void gen_op_clear_ieee_excp_and_FTT(void)
     tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
 }
 
-static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -4920,6 +4905,30 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FADDd, ALL, do_env_ddd, a, gen_helper_faddd)
+TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
+TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
+TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4997,31 +5006,23 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x45: /* fsubs */
                 case 0x49: /* fmuls */
                 case 0x4d: /* fdivs */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x42: /* faddd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_faddd);
-                    break;
+                case 0x46: /* fsubd */
+                case 0x4a: /* fmuld */
+                case 0x4e: /* fdivd */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x43: /* faddq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x46: /* fsubd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
-                    break;
                 case 0x47: /* fsubq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x4a: /* fmuld */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
-                    break;
                 case 0x4b: /* fmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
-                case 0x4e: /* fdivd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fdivd);
-                    break;
                 case 0x4f: /* fdivq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fdivq);
-- 
2.34.1


