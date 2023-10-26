Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6717D794E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2v-0007CI-6P; Wed, 25 Oct 2023 20:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2l-00070w-Gq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rd-MV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso2265995ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279363; x=1698884163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HaiE1/bSeMZ+5UImRCGkx6jDgHWHLGDLQF46mh2/Gqw=;
 b=QcIP/gLsRbPQtBEdXR7pbLVjgSigNds3hbemDgm8ZGcXNRS3sCUvICRvrEfobhPlu2
 mz+xryO54onZbeE2be+R5+M8/ilEmO82yR8uGFLpUps9tubVDhQtYsELK+FFsGNkhx6o
 8FKpRjuqNnemKTGx8W9ZU10yldIo0ISN4vJXA4DZS/K8DeSrhhWeZfBacJ3hTSYvQrR4
 EC+4Smjgzw3kBJxtN1gEyajga1rz6h5Cm9pvaYLDIMcPn9gva4QuwLEy0iRkU8p6uenX
 bOXWGSpCPAWzhizEwYe2OYERxR+OM4wy2ngOgcJY3Z1f49vrZeev5M3eC5tUDJbPHtYa
 JeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279363; x=1698884163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HaiE1/bSeMZ+5UImRCGkx6jDgHWHLGDLQF46mh2/Gqw=;
 b=tTMUU/A/GTZWShe6hDxky/4aIQO4DTjB5xlD737iM6b7qtXj4/D7XVuk4VXMCrRrgX
 MaNIzxV7bEJKmGnNOaZFMtGB/8e3jPfq94GzYwebNZnhOkvaz9V4kkAfdIOf7V4bjGj4
 aEBuEVOciF4YeyVFpPr02FJH/6yPV86kBHsQzRwU2Wq+O5JWNord56SI6ddJkQfF+8xx
 STbmrvobupRImXqF+GV8ZONmgnk1YrLSfPxW9RJGgmieLHvdtAZqxw8UtDper78mayzC
 LQ/r8cxqnDCfRnytdPk/A8txGRn/5TbxdGUhXb+5AtOYGHxzLAgug8ImmnIL+bykoHsO
 rXLg==
X-Gm-Message-State: AOJu0YwwEadt33uQVAThCQH+IDt3RmXkPnqKUUkbjHNVd7o51G3mwreC
 niddiHkTByatnHSz2CG2uBJADq3VQCaqeu6z5Jc=
X-Google-Smtp-Source: AGHT+IEgcbN+6UL7zB+oGR+rshTMZ2azQ9FvD3QB5yDsx613bWHceONU7Ow2EesC2Od92aI+AAfAuw==
X-Received: by 2002:a17:903:1212:b0:1c8:92ee:108a with SMTP id
 l18-20020a170903121200b001c892ee108amr16888850plh.23.1698279362933; 
 Wed, 25 Oct 2023 17:16:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 12/94] target/sparc: Move CALL to decodetree
Date: Wed, 25 Oct 2023 17:14:02 -0700
Message-Id: <20231026001542.1141412-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9eb2b7e52f..7ef4c6d4f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -285,6 +285,11 @@ static void gen_address_mask(DisasContext *dc, TCGv addr)
     }
 }
 
+static target_ulong address_mask_i(DisasContext *dc, target_ulong addr)
+{
+    return AM_CHECK(dc) ? (uint32_t)addr : addr;
+}
+
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
@@ -3041,6 +3046,16 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3146,23 +3161,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             break;
         }
         break;
-    case 1:                     /*CALL*/
-        {
-            target_long target = GET_FIELDs(insn, 2, 31) << 2;
-            TCGv o7 = gen_dest_gpr(dc, 15);
-
-            tcg_gen_movi_tl(o7, dc->pc);
-            gen_store_gpr(dc, 15, o7);
-            target += dc->pc;
-            gen_mov_pc_npc(dc);
-#ifdef TARGET_SPARC64
-            if (unlikely(AM_CHECK(dc))) {
-                target &= 0xffffffffULL;
-            }
-#endif
-            dc->npc = target;
-        }
-        goto jmp_insn;
+    case 1:
+        g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
             unsigned int xop = GET_FIELD(insn, 7, 12);
-- 
2.34.1


