Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7872810B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWn-0003RM-RM; Thu, 08 Jun 2023 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6c-0002U7-5I
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:02 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6a-0006el-Cx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:01 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso550956e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220978; x=1688812978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaYwJWRlrN+WhGZVGQ5O0ml1E95BvIlUrXb4RAKN81s=;
 b=V2ooxEAjcgrSn7R+Ukk9ZK1GDp4qZlyFwT/M0vG4x4K0gECZuXCftvW1pQVZ53MNLl
 Xb8OFKwitI4jGj82OLpoMio8LfMC70QN8hfDdC03Lwdg0E4QyXAmHxHXuvv2hJAl97PA
 clxHd9DcXKJlPw3Pe4qEIr16G5Y1BzHikM93tjcGaV68xGWEFDSvK33fKII3Xs5G5V/B
 ybY6eywWssM2p0AC6WNqLtIPi81/aHwUhoemyDItAYnh80OyFywNVhnnC8MN9uVw5FVO
 QmkdD/aJfmE3F0TV+93Fay1F7iiisZikx5O4fX9LGGaf60MOhiq8PLgWVKd4niaTuIkh
 IFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220978; x=1688812978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaYwJWRlrN+WhGZVGQ5O0ml1E95BvIlUrXb4RAKN81s=;
 b=CaIAIwNUFnljUeS6TEhw+ZzT/B1PJxKxckz2qocPywKEwHVzuJIoK/wYDJKZxSm8RC
 xaqSAPOygzU8hGiCUMUXBptJMpOmXdwlixg7vRe/6h+P7U0hzpH8wj0/kMYXINLzFX/4
 bb5IAwS195+eUJhpBMWSUBQQk6FFBGJhtHV8DMlJFh09PJIxq9PtKd+gkkZSsaac48DG
 kGf8KixJkjIColhng7s7eZul5DaonA315r7TJwYD+XK0EcPV3LMH4VrpSBuHGXZHO4my
 98j1F/r5BNTBr2OBRAyGsHo6UUhxgiFBwh9epbqHsLSObOaIqmV0ZOuw5+UmbcK4p6R4
 IvIg==
X-Gm-Message-State: AC+VfDz8gmy2kbkVJSnwezCTlibTZ4gqrsIU5Nt2KienM+MzUn5nnVuV
 rmb9SXE/lbzsSzO2BEyfP9hbaTS7rqQ=
X-Google-Smtp-Source: ACHHUZ4AMc0l+T5nku941uHS1q/hRsBy5146+Yr8ANajnL0LCii7CJtggZ+Vurcv2fOnfyqB/sApTw==
X-Received: by 2002:ac2:42c6:0:b0:4f1:4468:ee65 with SMTP id
 n6-20020ac242c6000000b004f14468ee65mr2820943lfl.30.1686220978425; 
 Thu, 08 Jun 2023 03:42:58 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:42:58 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 31/33] target/mips: Add emulation of MXU Q8MADL instruction
Date: Thu,  8 Jun 2023 13:42:20 +0300
Message-Id: <20230608104222.1520143-32-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x129.google.com
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

The instruction is used to parallel multiply and accumulate
four 8-bit data.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 7970b70fe1..ea2768cd57 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -408,6 +408,7 @@ enum {
     OPC_MXU__POOL20  = 0x39,
     OPC_MXU__POOL21  = 0x3A,
     OPC_MXU_Q16SCOP  = 0x3B,
+    OPC_MXU_Q8MADL   = 0x3C,
 };
 
 
@@ -1425,6 +1426,77 @@ static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
     gen_store_mxu_gpr(t1, XRa);
 }
 
+/*
+ * Q8MADL  XRd, XRa, XRb, XRc
+ *   Parallel quad unsigned 8 bit multiply and accumulate.
+ *   e.g. XRd[0..3] = XRa[0..3] + XRb[0..3] * XRc[0..3]
+ */
+static void gen_mxu_q8madl(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    uint32_t XRa, XRb, XRc, XRd, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_gpr(t3, XRb);
+    gen_load_mxu_gpr(t7, XRc);
+
+    tcg_gen_extract_tl(t0, t3,  0, 8);
+    tcg_gen_extract_tl(t1, t3,  8, 8);
+    tcg_gen_extract_tl(t2, t3, 16, 8);
+    tcg_gen_extract_tl(t3, t3, 24, 8);
+
+    tcg_gen_extract_tl(t4, t7,  0, 8);
+    tcg_gen_extract_tl(t5, t7,  8, 8);
+    tcg_gen_extract_tl(t6, t7, 16, 8);
+    tcg_gen_extract_tl(t7, t7, 24, 8);
+
+    tcg_gen_mul_tl(t0, t0, t4);
+    tcg_gen_mul_tl(t1, t1, t5);
+    tcg_gen_mul_tl(t2, t2, t6);
+    tcg_gen_mul_tl(t3, t3, t7);
+
+    gen_load_mxu_gpr(t4, XRa);
+    tcg_gen_extract_tl(t6, t4, 0, 8);
+    tcg_gen_extract_tl(t7, t4, 8, 8);
+    if (aptn2 & 1) {
+        tcg_gen_sub_tl(t0, t6, t0);
+        tcg_gen_sub_tl(t1, t7, t1);
+    } else {
+        tcg_gen_add_tl(t0, t6, t0);
+        tcg_gen_add_tl(t1, t7, t1);
+    }
+    tcg_gen_extract_tl(t6, t4, 16, 8);
+    tcg_gen_extract_tl(t7, t4, 24, 8);
+    if (aptn2 & 2) {
+        tcg_gen_sub_tl(t2, t6, t2);
+        tcg_gen_sub_tl(t3, t7, t3);
+    } else {
+        tcg_gen_add_tl(t2, t6, t2);
+        tcg_gen_add_tl(t3, t7, t3);
+    }
+
+    tcg_gen_andi_tl(t5, t0, 0xff);
+    tcg_gen_deposit_tl(t5, t5, t1,  8, 8);
+    tcg_gen_deposit_tl(t5, t5, t2, 16, 8);
+    tcg_gen_deposit_tl(t5, t5, t3, 24, 8);
+
+    gen_store_mxu_gpr(t5, XRd);
+}
+
 /*
  * S32LDD  XRa, Rb, S12 - Load a word from memory to XRF
  * S32LDDR XRa, Rb, S12 - Load a word from memory to XRF
@@ -4886,6 +4958,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_Q16SCOP:
             gen_mxu_q16scop(ctx);
             break;
+        case OPC_MXU_Q8MADL:
+            gen_mxu_q8madl(ctx);
+            break;
         default:
             return false;
         }
-- 
2.40.0


