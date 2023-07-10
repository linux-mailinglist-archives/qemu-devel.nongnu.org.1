Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6BD74E108
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:28:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzMB-0004yi-P5; Mon, 10 Jul 2023 18:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzM9-0004kn-OO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzM7-0001qv-TH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so5091044f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028062; x=1691620062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2cFjMtcI1fhdAdPikpinVWIlu5aYzG/8DNZsPsFkiQ=;
 b=M6p/UPn6Yr3W8Bmv36Db/H0UFpv+NvYrIluwAuqDA/NavUtg55tNm2PTne+gZBEvMA
 wMoqiZadsKuWVZ66wrBgGX8493hnC+b86oASlSX69BTCdSGWwXbmPAg4ZKrP/nYFxigD
 5i4F1LnDlQXcRAEpWCje5tORTIyI7jzeQJLDwBkFBh11i8zCypgxz/LZ5vkYoIfq0pv8
 m61BPrjQ0CIrljk1a5w/WcFumCm3pChdznXoqcn2cPEDFGclhKvsLxdIE14CrOxOMZMh
 3jM0NJPKV3aGOBQ1jCw0X6EyC0mKK8PRHZhEW0Jn+QXp5C8WIylOpp/XYmSXqmobnR1m
 yC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028062; x=1691620062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2cFjMtcI1fhdAdPikpinVWIlu5aYzG/8DNZsPsFkiQ=;
 b=XATwrOdR8GDGeL0rJvEM6wR/R4xgT4sUEMSuzuU97ap09dtXnsg5/gjkYyDsmX8ZUV
 NKVap5CRsSTqRVDJzoqHqX7Y3KeIV8ty/U7O0kw+mpa3BK2gIAyWJcNt5AbmlFXXhjJC
 k1hWQjXAm4krAh37Tb/YbBmjrN8TAmOld2xmStU7yp981okt97zZng4A+XdUmoB/dIUz
 IHrZO3KQD1dbsYszqK+dyYi1o7SEXQRsT2x9v/K0MXQ9X6T2F2jvRAlPmsxYQXEstYEV
 vI95JoEz4wCwP+AxIuJal2trapBo3Ea6iH/P6F4M2kQi3+zuqmVNGBTF8nfoDk/LneTd
 gFxw==
X-Gm-Message-State: ABy/qLZ4WA71GY5GznXbfwzThEHa96vGb1zvXZYd9XYWdn35yCwYBj0F
 GOw6GIbHAd2bNS9BgplkvLExxFTQq/JgtTQcwfuOlg==
X-Google-Smtp-Source: APBJJlFq+dRng2+Ak2K0du4k0e0vqTjZGdFMrG2u/AekExK5YSG/brLP1GV/ubSZTMcL4oAaaingmA==
X-Received: by 2002:adf:f949:0:b0:313:f4f5:2ddc with SMTP id
 q9-20020adff949000000b00313f4f52ddcmr12676398wrr.62.1689028062520; 
 Mon, 10 Jul 2023 15:27:42 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 q10-20020adfdfca000000b003144b95e1ecsm507049wrn.93.2023.07.10.15.27.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:27:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 16/44] target/mips/mxu: Add S16MAD instruction
Date: Tue, 11 Jul 2023 00:25:43 +0200
Message-Id: <20230710222611.50978-17-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Siarhei Volkau <lis8215@gmail.com>

The instruction is similar to multiply and accumulate
but works with MXU registers set.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-14-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 202e1c6d35..88d5d659c6 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -365,6 +365,7 @@ enum {
     OPC_MXU_D16MAC   = 0x0A,
     OPC_MXU_D16MACF  = 0x0B,
     OPC_MXU_D16MADL  = 0x0C,
+    OPC_MXU_S16MAD   = 0x0D,
     OPC_MXU_D16MACE  = 0x0F,
     OPC_MXU__POOL04  = 0x10,
     OPC_MXU__POOL05  = 0x11,
@@ -978,6 +979,67 @@ static void gen_mxu_d16madl(DisasContext *ctx)
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
@@ -2841,6 +2903,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1


