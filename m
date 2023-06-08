Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F168B728111
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWn-0003RK-72; Thu, 08 Jun 2023 09:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6N-0002MB-QW
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:47 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6L-0006Xo-Sy
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:47 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so569992e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220964; x=1688812964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HTXM142XOt3xLh080EVxLsR+ehuZHjG8WrVgo2UK88=;
 b=QRK0FTom8niSj4tCbEiBmQskTW08/20u8Lucafx2FKUQ4IchWEVDWaNMw2hdOpix48
 QEUHazT0/8WVl0HAn3K9XTyaImg3aeuKdkyEFLFabGoUXrwzsr0pAu6rfHE/RaAUFNWq
 1ecMfNzRlECt/Rv6VeyW6k65orlNqG+zQjeSYd+0k+i+XYxaqtQWKDhYWoiGkSqPAJao
 ULeaPcEWdyhCPd1G0a02kZSGXbT9eOcDsYafolcTqdOn3xI1kH6wqZ40JOSBb7Rd1TFm
 Ea7Wxel8gVYmmpqg08PjDKx+Wvyqy8GTHYQUwqLdHjLfazPPJtRN4Ot78rhgjsL60wr3
 vobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220964; x=1688812964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HTXM142XOt3xLh080EVxLsR+ehuZHjG8WrVgo2UK88=;
 b=Zp7fncuIgnON3u7S793GCP8ltC8bFk9ucUs0PEtDFdkGo2gUOFxdsbeKv37ZVmOv94
 tGsAfialB58F6cfuWoQElt313H9rTAPWTSHHCyrg/CvUs4K3Tk9vqCxQuIWQbwpkqwgV
 uBMvGz5Uzj89EM9oXt9VLtnFRFtqysN7nX1kv9G66U1M8Gs1MQ8Po5LDxMgCUeWy7Ehf
 OuMb2OeeMrwe507SNh9cg+fBVUxeCanl7m7NRyQ8X2HJ/UKday1vwN23JBd6nj7vrEbV
 F33/s7XbFLZn2t35c/o7m0Is3/idFJbwZBmx5HGirEnFw59YyjRaNhN02fdeSKBgICeK
 wzLw==
X-Gm-Message-State: AC+VfDyL99mDJh2O8nPP/r6yYjxa1HG1y4j9nK180kviegzkCdJqOrtY
 v4C06e/7/rm3+4gu0XAPWfh+p/9If9o=
X-Google-Smtp-Source: ACHHUZ44JYIifj0WpDWdUpGc63K578Z0sq/7iKRLANr2u2+aRYi0aAH6MH9Gaqd+3EtxYzX4+T+4iw==
X-Received: by 2002:a19:ac43:0:b0:4f4:dd5d:f3e0 with SMTP id
 r3-20020a19ac43000000b004f4dd5df3e0mr3439816lfc.51.1686220964059; 
 Thu, 08 Jun 2023 03:42:44 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:43 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 18/33] target/mips: Add emulation of MXU Q16ACC Q16ACCM
 D16ASUM instructions
Date: Thu,  8 Jun 2023 13:42:07 +0300
Message-Id: <20230608104222.1520143-19-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These instructions are all dual 16-bit addition/subtraction in
various combinations. The instructions are grouped in pool13,
see the opcode organization in the file.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 228 +++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 2b677407d5..73edf24229 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -279,7 +279,7 @@
  *          │                               23..22
  *          ├─ 011011 ─ OPC_MXU__POOL13 ─┬─ 00 ─ OPC_MXU_Q16ACC
  *          │                            ├─ 01 ─ OPC_MXU_Q16ACCM
- *          │                            └─ 10 ─ OPC_MXU_Q16ASUM
+ *          │                            └─ 10 ─ OPC_MXU_D16ASUM
  *          │
  *          │                               23..22
  *          ├─ 011100 ─ OPC_MXU__POOL14 ─┬─ 00 ─ OPC_MXU_Q8ADDE
@@ -380,6 +380,7 @@ enum {
     OPC_MXU__POOL11  = 0x17,
     OPC_MXU_D32ADD   = 0x18,
     OPC_MXU__POOL12  = 0x19,
+    OPC_MXU__POOL13  = 0x1B,
     OPC_MXU_S8LDD    = 0x22,
     OPC_MXU__POOL16  = 0x27,
     OPC_MXU__POOL17  = 0x28,
@@ -451,6 +452,15 @@ enum {
     OPC_MXU_D32ASUM   = 0x02,
 };
 
+/*
+ * MXU pool 13
+ */
+enum {
+    OPC_MXU_Q16ACC    = 0x00,
+    OPC_MXU_Q16ACCM   = 0x01,
+    OPC_MXU_D16ASUM   = 0x02,
+};
+
 /*
  * MXU pool 16
  */
@@ -2260,6 +2270,198 @@ static void gen_mxu_q16add(DisasContext *ctx)
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t0, t1);
 }
 
+/*
+ * Q16ACC XRa, XRb, XRc, XRd, aptn2 - Quad packed
+ * 16-bit addition/subtraction with accumulate.
+ */
+static void gen_mxu_q16acc(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv s3 = tcg_temp_new();
+    TCGv s2 = tcg_temp_new();
+    TCGv s1 = tcg_temp_new();
+    TCGv s0 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_extract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_extract_tl(t2, t3,  0, 16);
+    tcg_gen_extract_tl(t3, t3, 16, 16);
+
+    switch (aptn2) {
+    case MXU_APTN2_AA: /* lop +, rop + */
+        tcg_gen_add_tl(s3, t1, t3);
+        tcg_gen_add_tl(s2, t0, t2);
+        tcg_gen_add_tl(s1, t1, t3);
+        tcg_gen_add_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_AS: /* lop +, rop - */
+        tcg_gen_sub_tl(s3, t1, t3);
+        tcg_gen_sub_tl(s2, t0, t2);
+        tcg_gen_add_tl(s1, t1, t3);
+        tcg_gen_add_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_SA: /* lop -, rop + */
+        tcg_gen_add_tl(s3, t1, t3);
+        tcg_gen_add_tl(s2, t0, t2);
+        tcg_gen_sub_tl(s1, t1, t3);
+        tcg_gen_sub_tl(s0, t0, t2);
+        break;
+    case MXU_APTN2_SS: /* lop -, rop - */
+        tcg_gen_sub_tl(s3, t1, t3);
+        tcg_gen_sub_tl(s2, t0, t2);
+        tcg_gen_sub_tl(s1, t1, t3);
+        tcg_gen_sub_tl(s0, t0, t2);
+        break;
+    }
+
+    if (XRa != 0) {
+        tcg_gen_add_tl(t0, mxu_gpr[XRa - 1], s0);
+        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_extract_tl(t1, mxu_gpr[XRa - 1], 16, 16);
+        tcg_gen_add_tl(t1, t1, s1);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], t1, t0);
+    }
+
+    if (XRd != 0) {
+        tcg_gen_add_tl(t0, mxu_gpr[XRd - 1], s2);
+        tcg_gen_extract_tl(t0, t0, 0, 16);
+        tcg_gen_extract_tl(t1, mxu_gpr[XRd - 1], 16, 16);
+        tcg_gen_add_tl(t1, t1, s3);
+        tcg_gen_shli_tl(t1, t1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRd - 1], t1, t0);
+    }
+}
+
+/*
+ * Q16ACCM XRa, XRb, XRc, XRd, aptn2 - Quad packed
+ * 16-bit accumulate.
+ */
+static void gen_mxu_q16accm(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t2, XRb);
+    gen_load_mxu_gpr(t3, XRc);
+
+    if (XRa != 0) {
+        TCGv a0 = tcg_temp_new();
+        TCGv a1 = tcg_temp_new();
+
+        tcg_gen_extract_tl(t0, t2,  0, 16);
+        tcg_gen_extract_tl(t1, t2, 16, 16);
+
+        gen_load_mxu_gpr(a1, XRa);
+        tcg_gen_extract_tl(a0, a1,  0, 16);
+        tcg_gen_extract_tl(a1, a1, 16, 16);
+
+        if (aptn2 & 2) {
+            tcg_gen_sub_tl(a0, a0, t0);
+            tcg_gen_sub_tl(a1, a1, t1);
+        } else {
+            tcg_gen_add_tl(a0, a0, t0);
+            tcg_gen_add_tl(a1, a1, t1);
+        }
+        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_shli_tl(a1, a1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRa - 1], a1, a0);
+    }
+
+    if (XRd != 0) {
+        TCGv a0 = tcg_temp_new();
+        TCGv a1 = tcg_temp_new();
+
+        tcg_gen_extract_tl(t0, t3,  0, 16);
+        tcg_gen_extract_tl(t1, t3, 16, 16);
+
+        gen_load_mxu_gpr(a1, XRd);
+        tcg_gen_extract_tl(a0, a1,  0, 16);
+        tcg_gen_extract_tl(a1, a1, 16, 16);
+
+        if (aptn2 & 1) {
+            tcg_gen_sub_tl(a0, a0, t0);
+            tcg_gen_sub_tl(a1, a1, t1);
+        } else {
+            tcg_gen_add_tl(a0, a0, t0);
+            tcg_gen_add_tl(a1, a1, t1);
+        }
+        tcg_gen_extract_tl(a0, a0, 0, 16);
+        tcg_gen_shli_tl(a1, a1, 16);
+        tcg_gen_or_tl(mxu_gpr[XRd - 1], a1, a0);
+    }
+}
+
+
+/*
+ * D16ASUM XRa, XRb, XRc, XRd, aptn2 - Double packed
+ * 16-bit sign extended addition and accumulate.
+ */
+static void gen_mxu_d16asum(DisasContext *ctx)
+{
+    uint32_t aptn2, XRc, XRb, XRa, XRd;
+
+    aptn2 = extract32(ctx->opcode, 24, 2);
+    XRd   = extract32(ctx->opcode, 18, 4);
+    XRc   = extract32(ctx->opcode, 14, 4);
+    XRb   = extract32(ctx->opcode, 10, 4);
+    XRa   = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t2, XRb);
+    gen_load_mxu_gpr(t3, XRc);
+
+    if (XRa != 0) {
+        tcg_gen_sextract_tl(t0, t2,  0, 16);
+        tcg_gen_sextract_tl(t1, t2, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (aptn2 & 2) {
+            tcg_gen_sub_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        } else {
+            tcg_gen_add_tl(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
+        }
+    }
+
+    if (XRd != 0) {
+        tcg_gen_sextract_tl(t0, t3,  0, 16);
+        tcg_gen_sextract_tl(t1, t3, 16, 16);
+        tcg_gen_add_tl(t0, t0, t1);
+        if (aptn2 & 1) {
+            tcg_gen_sub_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+        } else {
+            tcg_gen_add_tl(mxu_gpr[XRd - 1], mxu_gpr[XRd - 1], t0);
+        }
+    }
+}
+
 /*
  * D32ADD XRa, XRb, XRc, XRd, aptn2 - Double
  * 32 bit pattern addition/subtraction, set carry.
@@ -3114,6 +3316,27 @@ static void decode_opc_mxu__pool12(DisasContext *ctx)
     }
 }
 
+static void decode_opc_mxu__pool13(DisasContext *ctx)
+{
+    uint32_t opcode = extract32(ctx->opcode, 22, 2);
+
+    switch (opcode) {
+    case OPC_MXU_Q16ACC:
+        gen_mxu_q16acc(ctx);
+        break;
+    case OPC_MXU_Q16ACCM:
+        gen_mxu_q16accm(ctx);
+        break;
+    case OPC_MXU_D16ASUM:
+        gen_mxu_d16asum(ctx);
+        break;
+    default:
+        MIPS_INVAL("decode_opc_mxu");
+        gen_reserved_instruction(ctx);
+        break;
+    }
+}
+
 static void decode_opc_mxu__pool16(DisasContext *ctx)
 {
     uint32_t opcode = extract32(ctx->opcode, 18, 3);
@@ -3282,6 +3505,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL12:
             decode_opc_mxu__pool12(ctx);
             break;
+        case OPC_MXU__POOL13:
+            decode_opc_mxu__pool13(ctx);
+            break;
         case OPC_MXU_S8LDD:
             gen_mxu_s8ldd(ctx);
             break;
-- 
2.40.0


