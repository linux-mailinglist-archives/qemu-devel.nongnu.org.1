Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFE7D1AFB
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eb-0003M9-Ur; Sat, 21 Oct 2023 01:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eY-0003K0-1H
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:02 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eW-0001Ae-9i
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:01 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ce2988d62eso978458a34.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866559; x=1698471359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSTynkYrGd+b+TlAqlMoO6TITVEsT/0JIz0Gl8KiF5M=;
 b=ezqu2osKVrNm8+a5MIo8ycgxlpBrPpZpZY7C/EuTES4bj5EzFlLvyYN+610WyFVhUw
 tk+jCeCAq4IwBGW/b+lFzcjXhVxksFV54wbPimBOOpzV7ZEqAYCDL9YF3c3t8IBGC+c7
 NCItsjYweEZkEupwOobYminESquPQhFYto5F9h/blGPtHcSNhzjWw0J5nw7eLX2CauiI
 n31vsV5+vnpVzhPGzZdn1bN1RQwH0Yj1+Da2GhFV/uIu/Nx6EjKdSvZ1JPMfXswkjcOO
 81zizJpzY4ur2fGSC1sk4qjLgsZg4NLYXZuURTHcNT+9eQ2Xw9Vb/9xC5YNaYhJrc8+/
 zN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866559; x=1698471359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PSTynkYrGd+b+TlAqlMoO6TITVEsT/0JIz0Gl8KiF5M=;
 b=GdafPVG5uWL5xbcLVNtxjs6RuWeDBeKT0aQQQjCkql/fv+ua+PSTRq2qA/A6Uuw+Nv
 UTUBGqVxecX2O1n7KKmcL8DSvLFAFU7LQgcQAcLcPbYBjiCyff2fVV0vQqeq5hhAO3Nr
 S66c6AqkADiXX8FyGsqXlGyJ54cXHn/JAxz8yiiu5qfpyeS6eNKrUbkOQklIC8vDNS8S
 kxDutYIRM1TayHmnOX6HxB/q5kiXTu1o6ziSvch9qBY43vpyqR9IPvd5Mjh3LG1pTyL2
 XthcbS+6SIGlJIxsqm7PVj1/h7PCNiZdKIsgiiji+G5zeITY15cET1dG5It8wKFmJyTD
 RJlA==
X-Gm-Message-State: AOJu0YwQMHL6H2d1nYPjDyBR/z4hGDNU5Uq1m9VYjiQn+Y4j+klKtEiA
 92Bbl2r/r/UriIE8gC49icYObXwif6Ug7f8TM6o=
X-Google-Smtp-Source: AGHT+IENXi71GEP+ZbS4UhQuK3K+9KCO++kRGC1Q1TFtXnme1nrKxqk/I7p6vvd4WHaLqxcRo4ta0A==
X-Received: by 2002:a05:6808:2c8:b0:3a7:44da:d5e4 with SMTP id
 a8-20020a05680802c800b003a744dad5e4mr3746863oid.51.1697866558868; 
 Fri, 20 Oct 2023 22:35:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 71/90] target/sparc: Move gen_fop_DD insns to decodetree
Date: Fri, 20 Oct 2023 22:31:39 -0700
Message-Id: <20231021053158.278135-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Move FSQRTd, FxTOd, FdTOx.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 50 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 76186bddf0..d8a49838a0 100644
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
index f6d6e8b746..38ad2034eb 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -53,6 +53,8 @@
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1665,20 +1667,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4952,6 +4940,28 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
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
@@ -5094,10 +5104,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5202,9 +5212,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                     gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
                     break;
-                case 0x82: /* V9 fdtox */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fdtox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
@@ -5212,9 +5219,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


