Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C5978F416
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qboJb-00007z-07; Thu, 31 Aug 2023 16:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJV-000076-8r
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qboJP-0002dU-T4
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:30:48 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso519741366b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693513838; x=1694118638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xt4mTysv3p0TkH7ZBMFPgfml88juYpaBcKIPdaYgYYg=;
 b=hcfKZ7K+63yiFSgzsMCHnh6HiSzFm2T7/USVRdwE2RSwv6/ENxRBkP1Oeya0ebG/pY
 kfZPjTj+Bc5jdhMB1G4lDjqIaERdVnYkfwOKgxt/n78stsWDju3gJgAyZvac86fhu2/T
 KGVubAKpu1LLyssDQXoMT7uniCJQTYhV9it0mquPOXGgrUa3ma5wg2xGPgFnSbOVZD/B
 ApUe1yW3R2JDej+ERr8Z36KhMIEqqhNXoKJi5q6yg+zSvdqmqW2zswJ882PBuE2svCsf
 uEFKd8L6nF2Khd+FndOFkiP9MVprf+Kp81wCrOqDaHIEAg0kghioRbLz0B9+IdWTXqfN
 CXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513838; x=1694118638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xt4mTysv3p0TkH7ZBMFPgfml88juYpaBcKIPdaYgYYg=;
 b=NWHlN8xSyDmg0JZOIcTpMUT7TS7vamAp2VK8a77R+W/STm/iqlgVTTneDx8Sy72r0D
 eE+wK8WILjt1bI5ysFp5dlQ0IN12dGphYKmq/pn08NGEl+HSy2INwVqmUU2r5qWzMTIF
 Nz+wL0S8ZQNY4+MMuhqYUXMYEkqvQFqDrsbIzMmEme2wIU9+zKv3HCx9diW45rQ5Zibj
 1FXY1mA3qb0/Z5w0UzZewxajjlUpn19CUaSaI6dZ3f11svwrwR5daSPJAloossMfizdU
 e0ErCNpw2OEZWxG9+tPr2hCFX20PgPdjaLLjDqC1h4oqpCvnKdp1GMTnMAtHE2Q/9NVx
 vU8A==
X-Gm-Message-State: AOJu0YwR7tOdf7b88Ta+oj9zdKd6jv06VGwPI48euqjKIfmvZ5T61jqp
 SugVcoscRV0MzDJaY1nY19K6KgvDKCmqr8/xu20=
X-Google-Smtp-Source: AGHT+IEDRZHV4j8f/uBO2b9RKCDr6ziAb58wZygrXB0JMvFGJCXd6nYrRZEsdOptAtD77dKXgGcEJg==
X-Received: by 2002:a17:906:518d:b0:9a1:b33a:e464 with SMTP id
 y13-20020a170906518d00b009a1b33ae464mr1054017ejk.31.1693513837722; 
 Thu, 31 Aug 2023 13:30:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 lo6-20020a170906fa0600b0099bd453357esm1113064ejb.41.2023.08.31.13.30.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 13:30:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/7] target/mips: Re-introduce OPC_ADDUH_QB_DSP and
 OPC_MUL_PH_DSP
Date: Thu, 31 Aug 2023 22:30:18 +0200
Message-ID: <20230831203024.87300-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831203024.87300-1-philmd@linaro.org>
References: <20230831203024.87300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is no issue having multiple enum declarations with
the same value. As we are going to remove the OPC_MULT_G_2E
definition in few commits, restore the OPC_ADDUH_QB_DSP and
OPC_MUL_PH_DSP definitions and use them where they belong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/translate.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index e0a76b9432..19e73aea60 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -390,16 +390,14 @@ enum {
     OPC_ADDU_OB_DSP    = 0x14 | OPC_SPECIAL3,
     OPC_ABSQ_S_PH_DSP  = 0x12 | OPC_SPECIAL3,
     OPC_ABSQ_S_QH_DSP  = 0x16 | OPC_SPECIAL3,
-    /* OPC_ADDUH_QB_DSP is same as OPC_MULT_G_2E.  */
-    /* OPC_ADDUH_QB_DSP   = 0x18 | OPC_SPECIAL3,  */
+    OPC_ADDUH_QB_DSP   = 0x18 | OPC_SPECIAL3,
     OPC_CMPU_EQ_QB_DSP = 0x11 | OPC_SPECIAL3,
     OPC_CMPU_EQ_OB_DSP = 0x15 | OPC_SPECIAL3,
     /* MIPS DSP GPR-Based Shift Sub-class */
     OPC_SHLL_QB_DSP    = 0x13 | OPC_SPECIAL3,
     OPC_SHLL_OB_DSP    = 0x17 | OPC_SPECIAL3,
     /* MIPS DSP Multiply Sub-class insns */
-    /* OPC_MUL_PH_DSP is same as OPC_ADDUH_QB_DSP.  */
-    /* OPC_MUL_PH_DSP     = 0x18 | OPC_SPECIAL3,  */
+    OPC_MUL_PH_DSP     = 0x18 | OPC_SPECIAL3,
     OPC_DPA_W_PH_DSP   = 0x30 | OPC_SPECIAL3,
     OPC_DPAQ_W_QH_DSP  = 0x34 | OPC_SPECIAL3,
     /* DSP Bit/Manipulation Sub-class */
@@ -557,7 +555,6 @@ enum {
     OPC_MULQ_S_PH      = (0x1E << 6) | OPC_ADDU_QB_DSP,
 };
 
-#define OPC_ADDUH_QB_DSP OPC_MULT_G_2E
 #define MASK_ADDUH_QB(op)           (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
@@ -11663,8 +11660,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     gen_load_gpr(v2_t, v2);
 
     switch (op1) {
-    /* OPC_MULT_G_2E is equal OPC_ADDUH_QB_DSP */
-    case OPC_MULT_G_2E:
+    case OPC_ADDUH_QB_DSP:
         check_dsp_r2(ctx);
         switch (op2) {
         case OPC_ADDUH_QB:
@@ -12347,11 +12343,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
     gen_load_gpr(v2_t, v2);
 
     switch (op1) {
-    /*
-     * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
-     * the same mask and op1.
-     */
-    case OPC_MULT_G_2E:
+    case OPC_MUL_PH_DSP:
         check_dsp_r2(ctx);
         switch (op2) {
         case  OPC_MUL_PH:
@@ -13887,7 +13879,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
          * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1.
          */
-        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MULT_G_2E)) {
+        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MUL_PH_DSP)) {
             op2 = MASK_ADDUH_QB(ctx->opcode);
             switch (op2) {
             case OPC_ADDUH_QB:
-- 
2.41.0


