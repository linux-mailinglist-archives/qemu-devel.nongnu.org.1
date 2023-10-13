Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE117C80FA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqU-00009U-Gc; Fri, 13 Oct 2023 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq1-0007jW-H4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpy-0000sm-Nt
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4066241289bso19485895e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186880; x=1697791680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0K1jBtbYPIofNLezlaYbU4Faf8tCiIn006y8XKJFbk=;
 b=z7d1uWotc+PQe8iLevP6XQiOc0ku1IyjxuhOxKRHxWOBHjB03O0Zt+zxBb7bu1XXF6
 IjRSJix4ubJLAgQDs0k3zSGBV3JGAAEVuRtKX48pwXflHJpgz5R6EvgzObxHJk7hQHnA
 Ax4iaeNAzKznwSbgVoD19Q88obcH4dZojJXufB+XtRB8tvr2sTo8aPGxk+qTFFaaPUiy
 BzVgbbn3lzqCdbBlgVFmaKlXh0UzlyONnrd7ta+Tk4k1zeEcAWT2FS2+n9XQ6q25wi6P
 x67e2+RReUuo+gTlrdTuiB2EZ35/YjKp04ZPjolqhVvNesWvdZcoG18jwXURdn+OYrJA
 wHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186880; x=1697791680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0K1jBtbYPIofNLezlaYbU4Faf8tCiIn006y8XKJFbk=;
 b=fkVOnlRyb2enpuJW8WiNOgrWFonhwuwiq9NNZkTStCRNaJIyJB+wdwwpQLHTsH1qoC
 hLtFuvfnAqfgyj7jqtxzFk740dbdUfxRR+xVQPiMIGlsXqDNDatjNofcUINSjaHkokUy
 nJtf5TKT/GFjfvyIDbyS4zXDTpn0K7JrND9TIseUUQP7Ox95Hy/jmq8S48oiocpC2IVR
 AL+ZceBctnSROHQH7Z/Jp11F2jp4s2xZLCoq+HASn5TpehqnOTm0RngAFlxdP2l7WZ6J
 huwx+dpVyeKCHY5EheejDi8/gTGjkEATuPMtWMKeYBNwBvBMCtB06NTi7L/v9RDNugxL
 ENOA==
X-Gm-Message-State: AOJu0Yw/BBPDclO4TCclyD/t7ti8A/zYaInWNpnSMioKEtk8SuUizrbN
 Vv5Xou8+38lzsFgdLy37PIIdPq00NzfQfg6dGzo=
X-Google-Smtp-Source: AGHT+IEwQ5nnKODekA9VH5wIXZrx+Wv04cX44o2I7QwwozzwhXaREmi4b93sFzbPWXjBMXVUedZazg==
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr22058512wmg.31.1697186880701; 
 Fri, 13 Oct 2023 01:48:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:00 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [RFC PATCH v3 27/78] target/riscv: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:55 +0300
Message-Id: <b387a1f2114c71be3c88c5bc9d8acb7f53c3b441.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
@@ -122,7 +122,7 @@ static TCGCond gen_compare_i128(bool bz, TCGv rl,
 
     case TCG_COND_LTU:
         invert = true;
-        /* fallthrough */
+        fallthrough;
     case TCG_COND_GEU:
         {
             TCGv tmp = tcg_temp_new();
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 2d992e14c4..f0bcbb4f72 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -125,37 +125,37 @@ static uint32_t decode_push_pop_list(DisasContext *ctx, target_ulong rlist)
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
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f0be79bb16..c99e513221 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -446,7 +446,7 @@ static TCGv_i64 get_fpr_hs(DisasContext *ctx, int reg_num)
         return t;
     }
 #else
-    /* fall through */
+    fallthrough;
     case MXL_RV64:
         return cpu_gpr[reg_num];
 #endif
@@ -516,7 +516,7 @@ static void gen_set_fpr_hs(DisasContext *ctx, int reg_num, TCGv_i64 t)
             tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);
             break;
 #else
-        /* fall through */
+        fallthrough;
         case MXL_RV64:
             tcg_gen_mov_i64(cpu_gpr[reg_num], t);
             break;
-- 
2.39.2


