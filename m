Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA077C803E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4u-0003Y2-0T; Fri, 13 Oct 2023 03:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4f-0001t2-Ma
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:09 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4R-0006vG-B6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:09 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bfed7c4e6dso21750131fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183927; x=1697788727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EG1O6Mx5hoCtdrOzDPsTcbmTGnAeTbLpG3HtBfPjsQM=;
 b=QW2mCNqinBasE5dDmIEemnALPcV1xlZwvTU7acm6Ed6bgUkkO05ZTW8WLohPhMHJXM
 0Z2uako59ZtU1J8rYfFgqoZoqrvxQmwQaJj1wAPQI5iSoV7aP9xLLD1I6I7iMW+0goy+
 TRsYom1/Do6fdxX2QshOPctCJVC4gOtcqLYXcrg6545wQQNjYzeByA4x3Hl6m5x1x/Ui
 od/FpYgIdAHexd6Zu+g9ktIGMsJ+Ql498zumIV9lC+F3AcgPAhu5MOgBqrsIpxxn4BkY
 a/PUt7qrJ7ssToqOojQEfER8A7bZzkw6qgHWw9wuEElJvyqHZ1ZATXcQzw4by4mVZcUa
 CyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183927; x=1697788727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG1O6Mx5hoCtdrOzDPsTcbmTGnAeTbLpG3HtBfPjsQM=;
 b=L0jIYsNW+iDQL/enFjxE5xSGWMTKr7aZGZg7u424lfVrWboiAwGFiLr8Afs+sf5kfj
 gPOVp39l6IOVxGFe+X9Mw2pCZBXkVS4joLlpNj+6bAG+PEXAsZpvoBN0k2aUozYncWXv
 /qHs3J+HQkQGcVECMrs/vSMuQUM6jlnUQop32CEWNd8xFFq9qk8Imxd2lK0VUffkvKmm
 5XFQw3vgAV7Qd9jcpzsyH8R6R1T0wgyG02vhQ6Fo3uqDW0eQBqgE9ZDh1g6CIfnh+AHn
 BV5bxnXLrTtDahGhQC5+RpqyK0X4STwWhgSlQS9AouxFGYhhPp6T1O54+YfqEPxM/eyN
 pQ2w==
X-Gm-Message-State: AOJu0Yz2zBjCUCLxyqq9h6cm2IocC6DyO2D4t3aiSwqfaWe4sgKDckm3
 9iVpzh7GV2A6pPSOcKRF9/b6q51DXX6lzILGaO8=
X-Google-Smtp-Source: AGHT+IGUWD5fj3RQMtSVDMgXqgWwJzLE5d3708tyKiGcYqVOrRUlbRAr4MziSNMSLL89sc70E7ntdA==
X-Received: by 2002:a05:6512:1593:b0:503:38ef:eb54 with SMTP id
 bp19-20020a056512159300b0050338efeb54mr25622284lfb.37.1697183926947; 
 Fri, 13 Oct 2023 00:58:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:46 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH v2 27/78] target/riscv: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:54 +0300
Message-Id: <e05d7549f265f8e4d2b250d6dd582979c76e048c.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/riscv/insn_trans/trans_rvi.c.inc   |  2 +-
 target/riscv/insn_trans/trans_rvzce.c.inc | 22 +++++++++++-----------
 target/riscv/translate.c                  |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 25cb60558a..98dd2e3cf6 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -89,61 +89,61 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 static TCGCond gen_compare_i128(bool bz, TCGv rl,
                                 TCGv al, TCGv ah, TCGv bl, TCGv bh,
                                 TCGCond cond)
 {
     TCGv rh = tcg_temp_new();
     bool invert = false;
 
     switch (cond) {
     case TCG_COND_EQ:
     case TCG_COND_NE:
         if (bz) {
             tcg_gen_or_tl(rl, al, ah);
         } else {
             tcg_gen_xor_tl(rl, al, bl);
             tcg_gen_xor_tl(rh, ah, bh);
             tcg_gen_or_tl(rl, rl, rh);
         }
         break;
 
     case TCG_COND_GE:
     case TCG_COND_LT:
         if (bz) {
             tcg_gen_mov_tl(rl, ah);
         } else {
             TCGv tmp = tcg_temp_new();
 
             tcg_gen_sub2_tl(rl, rh, al, ah, bl, bh);
             tcg_gen_xor_tl(rl, rh, ah);
             tcg_gen_xor_tl(tmp, ah, bh);
             tcg_gen_and_tl(rl, rl, tmp);
             tcg_gen_xor_tl(rl, rh, rl);
         }
         break;
 
     case TCG_COND_LTU:
         invert = true;
-        /* fallthrough */
+        fallthrough;
     case TCG_COND_GEU:
         {
             TCGv tmp = tcg_temp_new();
             TCGv zero = tcg_constant_tl(0);
             TCGv one = tcg_constant_tl(1);
 
             cond = TCG_COND_NE;
             /* borrow in to second word */
             tcg_gen_setcond_tl(TCG_COND_LTU, tmp, al, bl);
             /* seed third word with 1, which will be result */
             tcg_gen_sub2_tl(tmp, rh, ah, one, tmp, zero);
             tcg_gen_sub2_tl(tmp, rl, tmp, rh, bh, zero);
         }
         break;
 
     default:
         g_assert_not_reached();
     }
 
     if (invert) {
         cond = tcg_invert_cond(cond);
     }
     return cond;
 }
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 2d992e14c4..f0bcbb4f72 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -116,52 +116,52 @@ static bool trans_c_sh(DisasContext *ctx, arg_c_sh *a)
 static uint32_t decode_push_pop_list(DisasContext *ctx, target_ulong rlist)
 {
     uint32_t reg_bitmap = 0;
 
     if (has_ext(ctx, RVE) && rlist > 6) {
         return 0;
     }
 
     switch (rlist) {
     case 15:
         reg_bitmap |=  1 << (X_Sn + 11) ;
         reg_bitmap |=  1 << (X_Sn + 10) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 14:
         reg_bitmap |=  1 << (X_Sn + 9) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 13:
         reg_bitmap |=  1 << (X_Sn + 8) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 12:
         reg_bitmap |=  1 << (X_Sn + 7) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 11:
         reg_bitmap |=  1 << (X_Sn + 6) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 10:
         reg_bitmap |=  1 << (X_Sn + 5) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 9:
         reg_bitmap |=  1 << (X_Sn + 4) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 8:
         reg_bitmap |=  1 << (X_Sn + 3) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 7:
         reg_bitmap |=  1 << (X_Sn + 2) ;
-        /* FALL THROUGH */
+        fallthrough;
     case 6:
         reg_bitmap |=  1 << X_S1 ;
-        /* FALL THROUGH */
+        fallthrough;
     case 5:
         reg_bitmap |= 1 << X_S0;
-        /* FALL THROUGH */
+        fallthrough;
     case 4:
         reg_bitmap |= 1 << xRA;
         break;
     default:
         break;
     }
 
     return reg_bitmap;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..c99e513221 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -431,26 +431,26 @@ static void gen_set_gpr128(DisasContext *ctx, int reg_num, TCGv rl, TCGv rh)
 static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg_num)
 {
     if (!ctx->cfg_ptr->ext_zfinx) {
         return cpu_fpr[reg_num];
     }
 
     if (reg_num == 0) {
         return tcg_constant_i64(0);
     }
     switch (get_xl(ctx)) {
     case MXL_RV32:
 #ifdef TARGET_RISCV32
     {
         TCGv_i64 t = tcg_temp_new_i64();
         tcg_gen_ext_i32_i64(t, cpu_gpr[reg_num]);
         return t;
     }
 #else
-    /* fall through */
+    fallthrough;
     case MXL_RV64:
         return cpu_gpr[reg_num];
 #endif
     default:
         g_assert_not_reached();
     }
 }
@@ -505,24 +505,24 @@ static TCGv_i64 dest_fpr(DisasContext *ctx, int reg_num)
 /* assume it is nanboxing (for normal) or sign-extended (for zfinx) */
 static void gen_set_fpr_hs(DisasContext *ctx, int reg_num, TCGv_i64 t)
 {
     if (!ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_mov_i64(cpu_fpr[reg_num], t);
         return;
     }
     if (reg_num != 0) {
         switch (get_xl(ctx)) {
         case MXL_RV32:
 #ifdef TARGET_RISCV32
             tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);
             break;
 #else
-        /* fall through */
+        fallthrough;
         case MXL_RV64:
             tcg_gen_mov_i64(cpu_gpr[reg_num], t);
             break;
 #endif
         default:
             g_assert_not_reached();
         }
     }
 }
-- 
2.39.2


