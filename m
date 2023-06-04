Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62328721614
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 12:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5kzE-00017O-So; Sun, 04 Jun 2023 06:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kzB-00016S-SN; Sun, 04 Jun 2023 06:29:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kzA-0005pm-1k; Sun, 04 Jun 2023 06:29:21 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-652d1d3e040so1455541b3a.1; 
 Sun, 04 Jun 2023 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685874558; x=1688466558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqSUGBzCwFM3BYWfaK+JzwNF/GE/uwEKUodIuU1CLhs=;
 b=P8L20qM/FEP+WnZXi06jOqw/gGd4DhnoLeLRUrDyt2nV1e3WG1U5aueNwQLZWJdCKW
 4jvDYGMoWMBnmDXsAFyXmh5UcKnVOZscRDjLUAJkgAs0QA/yXmeggAqzjasRUa1X6zeX
 ZXXp64crp7GPUyTFJs/RIzIpxJFNnx8rKGtCG2oYmHrvhR7xs8fGZc3xkM1Cu7XyCy9d
 BE4pHHFi0+ZrnKQTOTrK06nIBh27luCSDY/JKJgjS6kKvPPNyS+Dkc+TI73pJ995djyL
 IkTG/L+qoqygODXU3hNidYp3DUywxWdvMwPanjXH2OT8lw7M9W5mBSFUEciFbn1/MwrZ
 GQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685874558; x=1688466558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqSUGBzCwFM3BYWfaK+JzwNF/GE/uwEKUodIuU1CLhs=;
 b=OoVetBFncN1KeYkDetQRfSFW3LNwzaxhpBf9ggsv619LmkFDxktNVwqyLJ5qz2K40B
 f9zopbLeeMueZzgKIgmjjmlcxljA/+QZQRikl2M6fnixChqsP6qKf/A5dvOXXWB500Lx
 HiUT+uflseRhqEr73ocSgsNs1T2cgbvW3dv68wqeykGITUKk7hIy6/t7Ea9tKyNWZUdi
 kJjiXCmCWhKPkJfQkDcDYp2Wm37AnUGeIPa/vQL1Kz4pSbQWc8M+YotryfNuATc9IUx8
 +iUhn9MRMjdYfF+yi8B6hpQ5e96GwP8Mz/UqimcbeTqPK/o2HJM3Q9zqtKQrxtwCtKli
 wsZg==
X-Gm-Message-State: AC+VfDwiRTLo/YxVeHgBk93PAzu7s7hbjuMbf7dmade1uN8k2bu8GPSK
 ntd4VxcEz08JWaakXGbQHXLCMeBO5gk=
X-Google-Smtp-Source: ACHHUZ5V04CT2Cpe72AopXmncBfudugGLKLU76cigNoBKqLwCIlPvz35yXIShQav+P52rbR3HdmiDA==
X-Received: by 2002:a17:903:284:b0:1a9:581d:3efb with SMTP id
 j4-20020a170903028400b001a9581d3efbmr3090494plr.6.1685874557676; 
 Sun, 04 Jun 2023 03:29:17 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 ik8-20020a170902ab0800b001ae0152d280sm4489241plb.193.2023.06.04.03.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 03:29:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 4/4] target/ppc: Rework store conditional to avoid branch
Date: Sun,  4 Jun 2023 20:28:57 +1000
Message-Id: <20230604102858.148584-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230604102858.148584-1-npiggin@gmail.com>
References: <20230604102858.148584-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rework store conditional to avoid a branch in the success case.
Change some of the variable names and layout while here so
gen_conditional_store more closely matches gen_stqcx_.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 65 ++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 77e1c5abb6..cf99e961f7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3812,31 +3812,32 @@ static void gen_stdat(DisasContext *ctx)
 
 static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    TCGv t0 = tcg_temp_new();
-    int reg = rS(ctx->opcode);
+    TCGLabel *lfail;
+    TCGv EA;
+    TCGv cr0;
+    TCGv t0;
+    int rs = rS(ctx->opcode);
 
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
+    t0 = tcg_temp_new();
+
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, memop_size(memop), l1);
+    gen_addr_reg_index(ctx, EA);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, memop_size(memop), lfail);
 
-    t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[reg], ctx->mem_idx,
-                              DEF_MEMOP(memop) | MO_ALIGN);
+                              cpu_gpr[rs], ctx->mem_idx,
+                              memop | MO_ALIGN);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-    tcg_gen_br(l2);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(l1);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-
-    gen_set_label(l2);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
@@ -3890,25 +3891,26 @@ static void gen_lqarx(DisasContext *ctx)
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
-    TCGLabel *lab_fail, *lab_over;
-    int rs = rS(ctx->opcode);
+    TCGLabel *lfail;
     TCGv EA, t0, t1;
+    TCGv cr0;
     TCGv_i128 cmp, val;
+    int rs = rS(ctx->opcode);
 
     if (unlikely(rs & 1)) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
 
-    lab_fail = gen_new_label();
-    lab_over = gen_new_label();
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
 
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, 128, lab_fail);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, 128, lfail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
@@ -3931,15 +3933,10 @@ static void gen_stqcx_(DisasContext *ctx)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-
-    tcg_gen_br(lab_over);
-    gen_set_label(lab_fail);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(lab_over);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.40.1


