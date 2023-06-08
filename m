Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C5672811E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWX-0003Mc-Bj; Thu, 08 Jun 2023 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6I-0002Jy-Hk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:42 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6G-0006VZ-Nb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:42 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f642a24555so558751e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220958; x=1688812958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6TCvwqDAGxfcAseFytqW5BhRh4D+q19S8dd4eqVH4o=;
 b=ItBm+p+KznccAmpBeOtqjAXaN+KXKIu1sMwUM9UJ76tzs3PPOysPaegzHT0R0jdv+5
 zAZyoxcrGJZpLBfbn2VF8WjIkhGpcOJkTWYB8owmltfLVlfAHt63wWOhxjOlfYWrXTKP
 901bD7XSN41barKBWKKObuax+OUSuOVl8n/P3YlSl62rZzfQMPzKAnoql35QidiIInwG
 t89vUMelPrRElxf86dGl0IRCCRl5UrC73dBEPX8HGV4rRj2uEAoYZPyaPQUXUtkGkFtp
 8CKmBipbxQa1qigbJd1yQgnU/QZeNmhIljZHAqXK6Q/YcbfPSdj4eKRHi1YbQVsh9C2d
 OS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220958; x=1688812958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6TCvwqDAGxfcAseFytqW5BhRh4D+q19S8dd4eqVH4o=;
 b=mGenhYWEo2ovOWitOFZQVsm8lIBqIVSO2y0Sa42vOTqUIj1SOJWdtZMflzMPa5ApLj
 86iYDG8qgEGhC7TLZa/eMVm05wHFG8TlsAbVhP+vAYYShQuF3cbBMSRoid6otB09RZi6
 bkkkTI7iFWFapZkSosNmob/hiqwhTnAr1Y5wCfzDHSOgWhBlFgXOVUFMNCzH2zd58lZk
 hWdYEm157SupVeBg3HCLJn2IjVxAQ36fwflYAQpCbwvRY0EP+rq0DMHWeCcbABbwLErU
 jS9XSPQ5GDc1y6APwFUgBrsvYmQM8ONB5Rjm+QhQExFI0O4Itj1wMa9HfXa8ICTL1m3T
 ih7A==
X-Gm-Message-State: AC+VfDwmg1JjEvfcflRyM9AXv8BIvnQR9qif0XXM94kDnuw8qA8Xx3cQ
 TCFCWLTO9C+3uK4MtjJ8T5YPTx0J7Ak=
X-Google-Smtp-Source: ACHHUZ6l3BrFkbyMid9KreVpyrEnTnU50j/pzqg4YTk69TJhenb+Y9Asw7O7z4WBogMrC/Y5MQYYIg==
X-Received: by 2002:ac2:4a76:0:b0:4f4:aea9:2a2f with SMTP id
 q22-20020ac24a76000000b004f4aea92a2fmr2697847lfp.57.1686220957812; 
 Thu, 08 Jun 2023 03:42:37 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:37 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 12/33] target/mips: Add emulation of MXU D16MADL instruction
Date: Thu,  8 Jun 2023 13:42:01 +0300
Message-Id: <20230608104222.1520143-13-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x135.google.com
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

The instruction is similar to multiply and accumulate
but works with MXU registers set.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index cd93992eed..85f3e47ee3 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -366,6 +366,7 @@ enum {
     OPC_MXU__POOL03  = 0x09,
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU_D16MACF  = 0x0B,
+    OPC_MXU_D16MADL  = 0x0C,
     OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -901,6 +902,84 @@ static void gen_mxu_d16mac(DisasContext *ctx, bool fractional,
     }
 }
 
+/*
+ * D16MADL XRa, XRb, XRc, XRd, aptn2, optn2 - Double packed
+ * unsigned 16 bit pattern multiply and add/subtract.
+ */
+static void gen_mxu_d16madl(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3;
+    uint32_t XRa, XRb, XRc, XRd, optn2, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_gpr(t1, XRb);
+    tcg_gen_sextract_tl(t0, t1,  0, 16);
+    tcg_gen_sextract_tl(t1, t1, 16, 16);
+
+    gen_load_mxu_gpr(t3, XRc);
+    tcg_gen_sextract_tl(t2, t3,  0, 16);
+    tcg_gen_sextract_tl(t3, t3, 16, 16);
+
+    switch (optn2) {
+    case MXU_OPTN2_WW: /* XRB.H*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_LW: /* XRB.L*XRC.H == lop, XRB.L*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t0, t2);
+        break;
+    case MXU_OPTN2_HW: /* XRB.H*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t1, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    case MXU_OPTN2_XW: /* XRB.L*XRC.H == lop, XRB.H*XRC.L == rop */
+        tcg_gen_mul_tl(t3, t0, t3);
+        tcg_gen_mul_tl(t2, t1, t2);
+        break;
+    }
+    tcg_gen_extract_tl(t2, t2, 0, 16);
+    tcg_gen_extract_tl(t3, t3, 0, 16);
+
+    gen_load_mxu_gpr(t1, XRa);
+    tcg_gen_extract_tl(t0, t1,  0, 16);
+    tcg_gen_extract_tl(t1, t1, 16, 16);
+
+    switch (aptn2) {
+    case MXU_APTN2_AA:
+        tcg_gen_add_tl(t3, t1, t3);
+        tcg_gen_add_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_AS:
+        tcg_gen_add_tl(t3, t1, t3);
+        tcg_gen_sub_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_SA:
+        tcg_gen_sub_tl(t3, t1, t3);
+        tcg_gen_add_tl(t2, t0, t2);
+        break;
+    case MXU_APTN2_SS:
+        tcg_gen_sub_tl(t3, t1, t3);
+        tcg_gen_sub_tl(t2, t0, t2);
+        break;
+    }
+
+    tcg_gen_andi_tl(t2, t2, 0xffff);
+    tcg_gen_shli_tl(t3, t3, 16);
+    tcg_gen_or_tl(mxu_gpr[XRd - 1], t3, t2);
+}
+
 /*
  * Q8MUL   XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply
  * Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply
@@ -2761,6 +2840,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D16MACF:
             gen_mxu_d16mac(ctx, true, true);
             break;
+        case OPC_MXU_D16MADL:
+            gen_mxu_d16madl(ctx);
+            break;
         case OPC_MXU_D16MACE:
             gen_mxu_d16mac(ctx, true, false);
             break;
-- 
2.40.0


