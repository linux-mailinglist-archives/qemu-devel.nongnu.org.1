Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C7728112
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWq-0003XC-Fq; Thu, 08 Jun 2023 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6b-0002SF-5R
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:01 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6Z-0006e5-8k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:00 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f4e71a09a7so585710e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220977; x=1688812977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LIn3wNgu7EGhq1U0nYq9G2gdyuS3dd3r667RMOa7xk=;
 b=s2rFXhT+mNgaDplVVpsjiX8eChLKOF+/Y5jpfGfuSNTg67t2AebVwS41NO1/OwpyIb
 DfzTUwhlZbKl0M4/l41izkgq3wwxYn49nxAYIzz/zMhuQGwnbRKz4L/XFJcXy1m5nU6L
 DDp2uMuGtrO2LaaL2sw4wFHwTr071TFToWOAoHX0SO+F/VWELHKsyqRMtbEHhQrUTpAO
 gP2vDE/PBKkpb+1h9WpVyAevN6UUEpoz0oSi6VIrwlkw4WaTEU4Vmshj3pnj79HwbJSL
 7jyQKrNHdHCYLSV/nW9ArhFpkHG8mODBilSCEXmhYBcHrWFVo0l9K1LVTegkJoZ6GIJk
 5KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220977; x=1688812977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LIn3wNgu7EGhq1U0nYq9G2gdyuS3dd3r667RMOa7xk=;
 b=exWsel2NFFQ/GbaXmOn8v1oFLIQzqR/wni/fcoLTCVY/9arB0WtoUujXUVTcu64FV2
 SH0hab6ZazWU86pLxB4W1SgJClW6mtbkXtfnrAfIRWX+jmbMhriVjGfviolko7L+NZi/
 cZ70XEHqPOk8JA0oFdwu8GeJP1068Uc2xTDxM2Vc2+hCUbKnMzTGyseKa2OMRZc9Bsd+
 WHvarvn8PrvEUAvh1l4bA7nKMLiSYhbmUy8oItOjlPrsau8PWd01Y2jqHYKiJAnvGL7B
 2TSFsSKsVjy2/ZWRQ1o+lQ8hu0yHCSn4PWtT3K1iKs7gfdXaO/M+DFhT7bhDyxpdhV+4
 Zedg==
X-Gm-Message-State: AC+VfDzOoZCISj+rQjdIintwhlBuFrEVV5kUXMWpmgvO9/v3AhQpgYbY
 fAxZUtB/Z6MGQIcLd4A5RPlQ1MgPUj8=
X-Google-Smtp-Source: ACHHUZ6YreAvRT7QyN3PmqIJ0iIN+RO5QARo5mpgTFCUp3brRcA/omoKSbtufABNhpq1uMrLAXb39w==
X-Received: by 2002:a05:6512:b94:b0:4f0:3e1:9ada with SMTP id
 b20-20020a0565120b9400b004f003e19adamr706307lfv.31.1686220977404; 
 Thu, 08 Jun 2023 03:42:57 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:57 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 30/33] target/mips: Add emulation of MXU Q16SCOP instruction
Date: Thu,  8 Jun 2023 13:42:19 +0300
Message-Id: <20230608104222.1520143-31-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12c.google.com
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

The instruction is used to determine sign of four 16-bit
packed data in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index dc985342d6..7970b70fe1 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -407,6 +407,7 @@ enum {
     OPC_MXU__POOL19  = 0x38,
     OPC_MXU__POOL20  = 0x39,
     OPC_MXU__POOL21  = 0x3A,
+    OPC_MXU_Q16SCOP  = 0x3B,
 };
 
 
@@ -3541,6 +3542,7 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *               S32EXTR      S32LUI
  *               S32EXTRV
  *                            Q16SAT
+ *                            Q16SCOP
  */
 
 /*
@@ -3808,6 +3810,86 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
     }
 }
 
+/*
+ *  Q16SCOP XRa, XRd, XRb, XRc
+ *    Determine sign of quad packed 16-bit signed values
+ *    in XRb and XRc put result in XRa and XRd respectively.
+ */
+static void gen_mxu_q16scop(DisasContext *ctx)
+{
+    uint32_t XRd, XRc, XRb, XRa;
+
+    XRd  = extract32(ctx->opcode, 18, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRa  = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv t4 = tcg_temp_new();
+
+    TCGLabel *l_b_hi_lt = gen_new_label();
+    TCGLabel *l_b_hi_gt = gen_new_label();
+    TCGLabel *l_b_lo = gen_new_label();
+    TCGLabel *l_b_lo_lt = gen_new_label();
+    TCGLabel *l_c_hi = gen_new_label();
+    TCGLabel *l_c_hi_lt = gen_new_label();
+    TCGLabel *l_c_hi_gt = gen_new_label();
+    TCGLabel *l_c_lo = gen_new_label();
+    TCGLabel *l_c_lo_lt = gen_new_label();
+    TCGLabel *l_done = gen_new_label();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    tcg_gen_sextract_tl(t2, t0, 16, 16);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_hi_lt);
+    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_b_hi_gt);
+    tcg_gen_movi_tl(t3, 0);
+    tcg_gen_br(l_b_lo);
+    gen_set_label(l_b_hi_lt);
+    tcg_gen_movi_tl(t3, 0xffff0000);
+    tcg_gen_br(l_b_lo);
+    gen_set_label(l_b_hi_gt);
+    tcg_gen_movi_tl(t3, 0x00010000);
+
+    gen_set_label(l_b_lo);
+    tcg_gen_sextract_tl(t2, t0, 0, 16);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_c_hi);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_lo_lt);
+    tcg_gen_ori_tl(t3, t3, 0x00000001);
+    tcg_gen_br(l_c_hi);
+    gen_set_label(l_b_lo_lt);
+    tcg_gen_ori_tl(t3, t3, 0x0000ffff);
+    tcg_gen_br(l_c_hi);
+
+    gen_set_label(l_c_hi);
+    tcg_gen_sextract_tl(t2, t1, 16, 16);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_hi_lt);
+    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_c_hi_gt);
+    tcg_gen_movi_tl(t4, 0);
+    tcg_gen_br(l_c_lo);
+    gen_set_label(l_c_hi_lt);
+    tcg_gen_movi_tl(t4, 0xffff0000);
+    tcg_gen_br(l_c_lo);
+    gen_set_label(l_c_hi_gt);
+    tcg_gen_movi_tl(t4, 0x00010000);
+
+    gen_set_label(l_c_lo);
+    tcg_gen_sextract_tl(t2, t1, 0, 16);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_done);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_lo_lt);
+    tcg_gen_ori_tl(t4, t4, 0x00000001);
+    tcg_gen_br(l_done);
+    gen_set_label(l_c_lo_lt);
+    tcg_gen_ori_tl(t4, t4, 0x0000ffff);
+
+    gen_set_label(l_done);
+    gen_store_mxu_gpr(t3, XRa);
+    gen_store_mxu_gpr(t4, XRd);
+}
 
 /*
  *                 MXU instruction category: align
@@ -4801,6 +4883,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL21:
             decode_opc_mxu__pool21(ctx);
             break;
+        case OPC_MXU_Q16SCOP:
+            gen_mxu_q16scop(ctx);
+            break;
         default:
             return false;
         }
-- 
2.40.0


