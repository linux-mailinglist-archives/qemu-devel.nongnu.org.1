Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A67CBB02
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNw-0003kL-MK; Tue, 17 Oct 2023 02:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNq-0003TH-EC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:50 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNn-0004nb-Eu
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:50 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6ccfed5e05bso778a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523406; x=1698128206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0ig2xAlbRoOxf6SMJuUw0w4vgldzT8/7vGmOft+bGo=;
 b=WhYdU0sp5QT5U7IFddbhJeZUCy6rsIVOBYopATxS99dzu8vq0XN1Z5dhR6G3Hco3Uz
 Yu9dYNhgYM0BW4jaysp/+Tf8uwfH1KV03P2tWa6k4AEspzvRqfqXUmN5nFH+lJ0tupnh
 Km2oz+FdAd8Gkond+YTKTdyG4JR6IfPGeUwQvlLqn6VbOLdZ3qTgLRZUtI2TOQyTLxRu
 Pfx8H+T75WVNs/bxhajFiFe7adCptlBuz+tfh0N3f/CypkJzz0/eZvRDc9ohFORb60+H
 aL/eLxhZ2T7sE4h36SypXGwcuWzPBl1pOoF++qIdXZxkUzrQQtHuoI6y+rpbP41GT1ad
 BxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523406; x=1698128206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0ig2xAlbRoOxf6SMJuUw0w4vgldzT8/7vGmOft+bGo=;
 b=jN29ZKQlG4PMZoMQ8iHNbacCsStRBuVtaYLXT2zehIzUh2SFX4BFevM9cNzxyOwpLn
 S3bSdG/RpYD03BYXRKM0Z+U1sWAVZcVDoQOIUVoZpdNnk1oQ9CO8kjBB7fdOO1p4EClh
 jr3w2cFhgnFfoMafJ7+VhWgAuQII/ZD/5t9jetSK61TiLIBNee51J/dkD4C/SRTY2Dv/
 noUBARkNIarMcefDdtVv4aHEsKs0nebz1xeaaoT9nvmtkmB6f+aqgLXAShGJXeRQ0VWK
 ksWL/3FNZTj+JpZT4O6fxxo/jQwQ40lGNTP9jh7DKMzp7aRThPYlMlrCL1wt8Y4gdOaU
 WNIw==
X-Gm-Message-State: AOJu0YwXHK+exq4ENoKqOBL1p6M1azGiMvCRPh4csNTS3UK1x9U0ZzzT
 3gHksAj0LYMoRILF3nSkbGU69RmxFqJcRonPntA=
X-Google-Smtp-Source: AGHT+IEy/9qFgvtAdanHAj+IgD3QQ8cAe/0uL/Oo+2iQ2vscjs8H0M6ZFwyUd2eBoHlE+h/KAwl8bw==
X-Received: by 2002:a05:6359:29c4:b0:143:897e:6e31 with SMTP id
 qf4-20020a05635929c400b00143897e6e31mr1447078rwb.7.1697523406012; 
 Mon, 16 Oct 2023 23:16:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 71/90] target/sparc: Move gen_fop_DD insns to decodetree
Date: Mon, 16 Oct 2023 23:12:25 -0700
Message-Id: <20231017061244.681584-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
index 4f10809e98..fa95ca056a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -239,6 +239,9 @@ FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6707164207..b7eac4a6e5 100644
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
@@ -1623,20 +1625,6 @@ static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4921,6 +4909,28 @@ TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
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
@@ -5063,10 +5073,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5171,9 +5181,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                     gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
                     break;
-                case 0x82: /* V9 fdtox */
-                    gen_fop_DD(dc, rd, rs2, gen_helper_fdtox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
@@ -5181,9 +5188,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


