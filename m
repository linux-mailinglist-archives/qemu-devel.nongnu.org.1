Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF757D2750
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui0A-0007gC-RV; Sun, 22 Oct 2023 19:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui04-0007T6-Lv
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:52 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui01-0008SC-PQ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:52 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-583552eafd3so1523075eaf.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017808; x=1698622608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k2xSZsz3brl6+UGLkDSwS+pwYDsLRshg5h4W43pUFQ=;
 b=TPpZl5pKf26T77gkz6eIvsKNFdDbzL/vR8zgiohY3YZvXfYtWKrZLaHeVLTXStw9u+
 USVM98tKukk1kAzuXRH78DMiqXGrnwBi3YCBDjfX7MR+31G7wBkB2jV02xHyuPZuhk/p
 g4CpKA7GwWbAHWtRaRzO2HVv4epahVtM5e1C1TiuHLKSl8+PWskTqaOPokBhcSn0AE27
 8Ey+6Oar1PhNE7NdNYtxJy1GmOdASnOhLCH09j4Y4f2K4RXaVhsEXpJumMyGPeaHzY+u
 Bg96iYlkEDS7D9nYwdIWmsh1Cz2HloLyM/ok9JLv5rGiS/b2MLpV4ZmmR+Cng20npSFb
 7lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017808; x=1698622608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9k2xSZsz3brl6+UGLkDSwS+pwYDsLRshg5h4W43pUFQ=;
 b=nnPCo7SS9Wx2rqrfl+H/FO9e5CS8/mfqC9/PQUbEcrzcXPPlbOIAVFpkQTWmKMEUXw
 UU9x+c9VWNDYhfcvvU5WNM8ms9p4KAlqoOtVXcXDGqGKqDEkg1Li1h8QWj/GWUHDSpfE
 1DpEVvJiAxhtKEOfIh5UOpYNmBphjXRW0xxwVNXxrvNnczZgjdJylxMbJPtotsfWNC6q
 Yx23uNlXv8QSYzgxO1T9NJsN93ehTtedYVn1qGpMWwXB5gJmV/3qRpK1bigFS0zk2217
 /YCNINxbvCN9Dgw43wO1VyKQ70CjeowvlXYbPGAgocmJ87awOxsU2DcRS36WPNDtRAtn
 jJVw==
X-Gm-Message-State: AOJu0YykLEfG26A3pfIkPw+oh8t7/YYMsfn5N0TQ+uLticOJ1aBrT7we
 +fUQtfjQt63eqYYuJmzlJMijvVhcZU/6gFcm1ow=
X-Google-Smtp-Source: AGHT+IFus+ZHq4xKIdgzrisLAig92mRNX0HZpnl1elGJNBPdk/JlxAdZYx+HXWHkm+t9m0Dg3xopEw==
X-Received: by 2002:a05:6358:3402:b0:143:3a49:e30d with SMTP id
 h2-20020a056358340200b001433a49e30dmr7983453rwd.12.1698017808380; 
 Sun, 22 Oct 2023 16:36:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 87/94] target/sparc: Move FdTOq, FxTOq to decodetree
Date: Sun, 22 Oct 2023 16:29:25 -0700
Message-Id: <20231022232932.80507-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c76e603f2d..e1f5394d17 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -267,6 +267,7 @@ FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
@@ -275,6 +276,7 @@ FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
 FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 784558cfc5..25f92a749d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -77,6 +77,7 @@
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
@@ -1672,19 +1673,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4810,6 +4798,29 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
+static bool do_env_qd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_D(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FdTOq, ALL, do_env_qd, a, gen_helper_fdtoq)
+TRANS(FxTOq, 64, do_env_qd, a, gen_helper_fxtoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5097,11 +5108,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x83: /* V9 fqtox */
                 case 0xcc: /* fitoq */
                 case 0xcd: /* fstoq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-                    break;
+                case 0x8c: /* V9 fxtoq */
+                    g_assert_not_reached(); /* in decodetree */
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
@@ -5115,10 +5124,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x8c: /* V9 fxtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-                    break;
 #endif
                 default:
                     goto illegal_insn;
-- 
2.34.1


