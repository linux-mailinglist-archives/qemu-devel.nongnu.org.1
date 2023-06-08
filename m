Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ECE728142
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWr-0003YK-Ci; Thu, 08 Jun 2023 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6g-0002Un-2L
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:06 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6b-0006fX-Ai
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:03 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f6370ddd27so565986e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220979; x=1688812979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3rtuQ8mHqHcvQS6StgNCviZs2g0eGCn8bpnAVuyQks=;
 b=qmAXHCFHeOHLey1eVsDA2tTEcYlaYdUBicthziP0wisc08A0ckMoUA6PYSPGOMOdHx
 HCwJTYEpx9qvobHur4845OH3oMWsxwjw9cYXdjFT2/V5ukJWjRmQKFlIo4B8WkNu4Jcj
 ccShvxMZl8PzHglvDGn4Dd0NTiTcrcPn6q373a6ZTC6zyN/+QOPH3+o7+nFHxnIyD7aJ
 8E1IsRgC8DZbMSEN1M4M4kE1u0aV38yQOnQqvEqIH6YH+I8wyadre0Qpxzps098vQpON
 Z3Dyde4ko5QWoR76/brKan/N0mFQ9HxOPPRCIQFsLrxgPZtAkRj1M+i2Q+e52YYRh0nE
 F+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220979; x=1688812979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3rtuQ8mHqHcvQS6StgNCviZs2g0eGCn8bpnAVuyQks=;
 b=EH0QfGfcmUyE032W3SAHLwhij3dYSNvMKX1trcS6DfSgmj2nlUMUnHacJyEd2Vj2KJ
 EC3LAX0WEOrLHsf75OfpDumXnCAELibqfY2qQAMZOxXf0e8hHKdJMWibcr862309+2qR
 SE0+XGNcNc0hSLM6m1pHocYf8TJ7OYmBJPfWUy71mV+KOtdvZfuVc35YRgyrS3FnHqnl
 7l48Xgl3N1zGhA6kBpShVFHn8I8mliXa5O3cSW+9QFOexPhVlm/dKw+JDNw7x3Fww5Na
 Q1WW/6gheYYyNsUZWvnh52EMx9Pp2tYlaDj4vhAF5UInHQQAiEjoI8jdKUms9GwDIhfc
 D/Ow==
X-Gm-Message-State: AC+VfDyn18OF/l0gVSfyOPmO7Zgm4rzot4caVJB8I7mo/0Qv/sbN4CYR
 mgzvJqqrQmFj/SLegLeILHAt/WewxfM=
X-Google-Smtp-Source: ACHHUZ5V27S21RpG+7lSMYl1Vut+6dO9IPIaR+z618aWAUUZAyKpnm0Kf57sYzfouQ+IeAI9uL/T9Q==
X-Received: by 2002:ac2:44d7:0:b0:4f3:859c:a01d with SMTP id
 d23-20020ac244d7000000b004f3859ca01dmr3137938lfm.69.1686220979401; 
 Thu, 08 Jun 2023 03:42:59 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:59 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 32/33] target/mips: Add emulation of MXU S32SFL instruction
Date: Thu,  8 Jun 2023 13:42:21 +0300
Message-Id: <20230608104222.1520143-33-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:53 -0400
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

The instruction shuffles 8 bytes in two registers by
one of 4 predefined patterns.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index ea2768cd57..1e043908db 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -409,6 +409,7 @@ enum {
     OPC_MXU__POOL21  = 0x3A,
     OPC_MXU_Q16SCOP  = 0x3B,
     OPC_MXU_Q8MADL   = 0x3C,
+    OPC_MXU_S32SFL   = 0x3D,
 };
 
 
@@ -3963,6 +3964,83 @@ static void gen_mxu_q16scop(DisasContext *ctx)
     gen_store_mxu_gpr(t4, XRd);
 }
 
+/*
+ *  S32SFL XRa, XRd, XRb, XRc
+ *    Shuffle bytes according to one of four patterns.
+ */
+static void gen_mxu_s32sfl(DisasContext *ctx)
+{
+    uint32_t XRd, XRc, XRb, XRa, ptn2;
+
+    XRd  = extract32(ctx->opcode, 18, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRa  = extract32(ctx->opcode,  6, 4);
+    ptn2 = extract32(ctx->opcode, 24, 2);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    switch (ptn2) {
+    case 0:
+        tcg_gen_andi_tl(t2, t0, 0xff000000);
+        tcg_gen_andi_tl(t3, t1, 0x000000ff);
+        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_tl(t3, t3, t1, 16, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t0,  8, 8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        break;
+    case 1:
+        tcg_gen_andi_tl(t2, t0, 0xff000000);
+        tcg_gen_andi_tl(t3, t1, 0x000000ff);
+        tcg_gen_deposit_tl(t3, t3, t0, 16, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t0, 16, 8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_shri_tl(t0, t0,  8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_deposit_tl(t3, t3, t1,  8, 8);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1,  8, 8);
+        break;
+    case 2:
+        tcg_gen_andi_tl(t2, t0, 0xff00ff00);
+        tcg_gen_andi_tl(t3, t1, 0x00ff00ff);
+        tcg_gen_deposit_tl(t3, t3, t0,  8, 8);
+        tcg_gen_shri_tl(t0, t0, 16);
+        tcg_gen_shri_tl(t1, t1,  8);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 8);
+        tcg_gen_deposit_tl(t3, t3, t0, 24, 8);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_deposit_tl(t2, t2, t1, 16, 8);
+        break;
+    case 3:
+        tcg_gen_andi_tl(t2, t0, 0xffff0000);
+        tcg_gen_andi_tl(t3, t1, 0x0000ffff);
+        tcg_gen_shri_tl(t1, t1, 16);
+        tcg_gen_deposit_tl(t2, t2, t1,  0, 16);
+        tcg_gen_deposit_tl(t3, t3, t0, 16, 16);
+        break;
+    }
+
+    gen_store_mxu_gpr(t2, XRa);
+    gen_store_mxu_gpr(t3, XRd);
+}
+
 /*
  *                 MXU instruction category: align
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -4961,6 +5039,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_Q8MADL:
             gen_mxu_q8madl(ctx);
             break;
+        case OPC_MXU_S32SFL:
+            gen_mxu_s32sfl(ctx);
+            break;
         default:
             return false;
         }
-- 
2.40.0


