Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29C728134
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWi-0003Qs-CF; Thu, 08 Jun 2023 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6I-0002Js-FB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:42 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6G-0006Vk-OB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:42:42 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f649db9b25so588734e87.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220959; x=1688812959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+S8dhmOgf4fP0vwFSn+XfASHgw2tPEqLZSr7jov0PI=;
 b=o/Lpe2enwtz8gMzb9YzYhGsc/rshKBAqcAYBWe14kaQG8/OHNEdOdQTzdnD1DXS4DZ
 S46hSsg7nQPF2gJ2cmAx2ikrRVlHqARl24MF85EweAtsLu3pi7ydSaOZx7EPaRe1KPRq
 EwL31YLslGOq8bKyRh/J+WrhID23E02sVjHVPcJnF78SGJkThvT9D94MiTTKu03faLIC
 QDA9KB7i7rjgWDrwOvhc9+lmDreynMQz3O5c/sMjhE5NPRP2ByquRxAQa5bwxDOGjWKW
 fp4r6SALY4eca2aPgxrBjToI68CkBtTjirXbYscvl5MSeEOSdm3C30NfV4hlpKoKXkuj
 O0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220959; x=1688812959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+S8dhmOgf4fP0vwFSn+XfASHgw2tPEqLZSr7jov0PI=;
 b=gbhxGIP2dYGRfFtCkVP4MNrqiTmxL58wfyFUSdLlJT8U5xRUDo+xbofAX99GNug9Jm
 EPSPMLatmdgov/JjYyndNRWjwHhbh0ZDaaBpYV9p4bpveWMfKSQh70k7V/mQiGkchYqO
 VhQ1I89x43NKS+xrIvDS1vy8Ys5WNcBsCfSLCOEjmGqhKUj4TPsGm4DJMFmYoONU9rNt
 pUuj5+uYZZ5X3F/QENt52WGAkWqMhR+GV8MU2FNjqCiLAnCsFPzlfkMnSujoGpOZ6jBs
 X9Kvkzi8p8EUCN1em5/LFEVVZXFlnuLxxKrd8j/LKmtTIfztNERIX4kFkjG01B78HR74
 rhlw==
X-Gm-Message-State: AC+VfDxv9QvIzWwtJugiTIR3XgG5oWln6FxjtwePitMvC5qTcYQubvzX
 cWb2KcWSTog0xJKclYeBGLdgzs9wABA=
X-Google-Smtp-Source: ACHHUZ7B+ekk9uTuYieN2VLzXuIgqQxuHlJ2RtW4u5JSIwHKZ1rw8iHRenGTNXGbXWkpVBWxMHvgkw==
X-Received: by 2002:ac2:53a1:0:b0:4f6:2afd:c17 with SMTP id
 j1-20020ac253a1000000b004f62afd0c17mr3586845lfh.4.1686220958803; 
 Thu, 08 Jun 2023 03:42:38 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:38 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 13/33] target/mips: Add emulation of MXU S16MAD instruction
Date: Thu,  8 Jun 2023 13:42:02 +0300
Message-Id: <20230608104222.1520143-14-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x12b.google.com
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
 target/mips/tcg/mxu_translate.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 85f3e47ee3..c1a38d7a0d 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -367,6 +367,7 @@ enum {
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU_D16MACF  = 0x0B,
     OPC_MXU_D16MADL  = 0x0C,
+    OPC_MXU_S16MAD   = 0x0D,
     OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -980,6 +981,67 @@ static void gen_mxu_d16madl(DisasContext *ctx)
     tcg_gen_or_tl(mxu_gpr[XRd - 1], t3, t2);
 }
 
+/*
+ * S16MAD XRa, XRb, XRc, XRd, aptn2, optn2 - Single packed
+ * signed 16 bit pattern multiply and 32-bit add/subtract.
+ */
+static void gen_mxu_s16mad(DisasContext *ctx)
+{
+    TCGv t0, t1;
+    uint32_t XRa, XRb, XRc, XRd, optn2, aptn1, pad;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    optn2 = extract32(ctx->opcode, 22, 2);
+    aptn1 = extract32(ctx->opcode, 24, 1);
+    pad = extract32(ctx->opcode, 25, 1);
+
+    if (pad) {
+        /* FIXME check if it influence the result */
+    }
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    switch (optn2) {
+    case MXU_OPTN2_WW: /* XRB.H*XRC.H */
+        tcg_gen_sextract_tl(t0, t0, 16, 16);
+        tcg_gen_sextract_tl(t1, t1, 16, 16);
+        break;
+    case MXU_OPTN2_LW: /* XRB.L*XRC.L */
+        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        break;
+    case MXU_OPTN2_HW: /* XRB.H*XRC.L */
+        tcg_gen_sextract_tl(t0, t0, 16, 16);
+        tcg_gen_sextract_tl(t1, t1,  0, 16);
+        break;
+    case MXU_OPTN2_XW: /* XRB.L*XRC.H */
+        tcg_gen_sextract_tl(t0, t0,  0, 16);
+        tcg_gen_sextract_tl(t1, t1, 16, 16);
+        break;
+    }
+    tcg_gen_mul_tl(t0, t0, t1);
+
+    gen_load_mxu_gpr(t1, XRa);
+
+    switch (aptn1) {
+    case MXU_APTN1_A:
+        tcg_gen_add_tl(t1, t1, t0);
+        break;
+    case MXU_APTN1_S:
+        tcg_gen_sub_tl(t1, t1, t0);
+        break;
+    }
+
+    gen_store_mxu_gpr(t1, XRd);
+}
+
 /*
  * Q8MUL   XRa, XRb, XRc, XRd - Parallel unsigned 8 bit pattern multiply
  * Q8MULSU XRa, XRb, XRc, XRd - Parallel signed 8 bit pattern multiply
@@ -2843,6 +2905,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_D16MADL:
             gen_mxu_d16madl(ctx);
             break;
+        case OPC_MXU_S16MAD:
+            gen_mxu_s16mad(ctx);
+            break;
         case OPC_MXU_D16MACE:
             gen_mxu_d16mac(ctx, true, false);
             break;
-- 
2.40.0


