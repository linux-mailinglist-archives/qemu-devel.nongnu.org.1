Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C94A713AB3
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JaQ-0000Uy-PT; Sun, 28 May 2023 12:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaO-0000UQ-RK; Sun, 28 May 2023 12:49:40 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaN-0003ZP-4e; Sun, 28 May 2023 12:49:40 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5555765c6d3so1565658eaf.1; 
 Sun, 28 May 2023 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292577; x=1687884577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTEsFsv+jjoCMUgQQGjYI0LFkAAdIpRXOhMGO4z2oIU=;
 b=YA2LPCug0N9Dr2yds53kgXX8sphuDfSSJQIqqm1feQlbKZ0JWYNyVS3SpupGirGtSM
 pl/1QwjoNTntu9qAJK1+LzB/zdzabd2X7rh7Bs7cJjx7nUySW10kRO2NdRJkNws8b3Lh
 Ndc7naWTNAVVIJITLDvvgAskyCC2HWW4M6DVj2tSvOWmJ+4dTfKSmEu/r7PLx+CuvsGl
 jZHjyU4kDsvVp+dRd5njAmg+7OoXJes8P3sbuHnMWoQL9JclpUUOliJCsSfFXq1AF6dN
 aWCPPI7xsagIdGoB8q1ND0VnrxTqRZRqR3EbjxS50uAAscg71/QxSVW1nFA/Dl7/Znmj
 7x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292577; x=1687884577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTEsFsv+jjoCMUgQQGjYI0LFkAAdIpRXOhMGO4z2oIU=;
 b=YkufnpMbnqn5kRQTLUg3e6yDf9+s0N1u4hQgjBCbspBxevLXCY6hlKVG9OU2NyrOl0
 zZ0xdV0qR7uBN+QqatM6PKZnMn+aO51rZRNmGASED6nVzIIbwrz61/RgntZ4m5omsEaC
 PRFzSUPBI+IWFM8W4M0L1/GnnAj09aobIDgUzyGVc/UpDKfiEts47IDX0pNeNCS2I3zU
 JpmwB+8Prp8/DWfd8gnPWg0aYD4sSgLoxJk6QbyJ73XC+fxvWhOSARzX+DfO/3c+n50+
 /eXBTPJYSfxQEPJk+9rK/N2VNokHV1et1HLrPvGlVhm0r0T6F1/+CgtbgeAiMm7tuAyb
 vJpA==
X-Gm-Message-State: AC+VfDxkZ3QfOqqAx78t3ILzqFup9lpfBIDmabce0F/UKq7TwFEi5Mjw
 I4uHJ7VaUEp8n5A+ickk9Q3eTIhVcFo=
X-Google-Smtp-Source: ACHHUZ4o+M3xdWsV3LVIl4mJrNfb/RVbNvfw8EHkgiOZdYkINZT+tSf4JL1ilDBLT7L+e1Omnu0ebw==
X-Received: by 2002:a4a:5206:0:b0:54f:49ad:1c8f with SMTP id
 d6-20020a4a5206000000b0054f49ad1c8fmr2796358oob.1.1685292576986; 
 Sun, 28 May 2023 09:49:36 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:36 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>
Subject: [PULL 01/10] target/ppc: Fix fallback to MFSS for MFFS* instructions
 on pre 3.0 ISAs
Date: Sun, 28 May 2023 13:49:13 -0300
Message-Id: <20230528164922.20364-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The following commits changed the code such that the fallback to MFSS for MFFSCRN,
MFFSCRNI, MFFSCE and MFFSL on pre 3.0 ISAs was removed and became an illegal instruction:

  bf8adfd88b547680aa857c46098f3a1e94373160 - target/ppc: Move mffscrn[i] to decodetree
  394c2e2fda70da722f20fb60412d6c0ca4bfaa03 - target/ppc: Move mffsce to decodetree
  3e5bce70efe6bd1f684efbb21fd2a316cbf0657e - target/ppc: Move mffsl to decodetree

The hardware will handle them as a MFFS instruction as the code did previously.
This means applications that were segfaulting under qemu when encountering these
instructions which is used in glibc libm functions for example.

The fallback for MFFSCDRN and MFFSCDRNI added in a later patch was also missing.

This patch restores the fallback to MFSS for these instructions on pre 3.0s ISAs
as the hardware decoder would, fixing the segfaulting libm code. It doesn't have
the fallback for 3.0 onwards to match hardware behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230510111913.1718734-1-richard.purdie@linuxfoundation.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/insn32.decode           | 20 +++++++++++++-------
 target/ppc/translate/fp-impl.c.inc | 22 ++++++++++++++++------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index f8f589e9fd..4fcf3af8d0 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -390,13 +390,19 @@ SETNBCR         011111 ..... ..... ----- 0111100000 -   @X_bi
 
 ### Move To/From FPSCR
 
-MFFS            111111 ..... 00000 ----- 1001000111 .   @X_t_rc
-MFFSCE          111111 ..... 00001 ----- 1001000111 -   @X_t
-MFFSCRN         111111 ..... 10110 ..... 1001000111 -   @X_tb
-MFFSCDRN        111111 ..... 10100 ..... 1001000111 -   @X_tb
-MFFSCRNI        111111 ..... 10111 ---.. 1001000111 -   @X_imm2
-MFFSCDRNI       111111 ..... 10101 --... 1001000111 -   @X_imm3
-MFFSL           111111 ..... 11000 ----- 1001000111 -   @X_t
+{
+  # Before Power ISA v3.0, MFFS bits 11~15 were reserved and should be ignored
+  MFFS_ISA207     111111 ..... ----- ----- 1001000111 .   @X_t_rc
+  [
+    MFFS            111111 ..... 00000 ----- 1001000111 .   @X_t_rc
+    MFFSCE          111111 ..... 00001 ----- 1001000111 -   @X_t
+    MFFSCRN         111111 ..... 10110 ..... 1001000111 -   @X_tb
+    MFFSCDRN        111111 ..... 10100 ..... 1001000111 -   @X_tb
+    MFFSCRNI        111111 ..... 10111 ---.. 1001000111 -   @X_imm2
+    MFFSCDRNI       111111 ..... 10101 --... 1001000111 -   @X_imm3
+    MFFSL           111111 ..... 11000 ----- 1001000111 -   @X_t
+  ]
+}
 
 ### Decimal Floating-Point Arithmetic Instructions
 
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 57d8437851..874774eade 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -568,6 +568,22 @@ static void store_fpscr_masked(TCGv_i64 fpscr, uint64_t clear_mask,
     gen_helper_store_fpscr(cpu_env, fpscr_masked, st_mask);
 }
 
+static bool trans_MFFS_ISA207(DisasContext *ctx, arg_X_t_rc *a)
+{
+    if (!(ctx->insns_flags2 & PPC2_ISA300)) {
+        /*
+         * Before Power ISA v3.0, MFFS bits 11~15 were reserved, any instruction
+         * with OPCD=63 and XO=583 should be decoded as MFFS.
+         */
+        return trans_MFFS(ctx, a);
+    }
+    /*
+     * For Power ISA v3.0+, return false and let the pattern group
+     * select the correct instruction.
+     */
+    return false;
+}
+
 static bool trans_MFFS(DisasContext *ctx, arg_X_t_rc *a)
 {
     REQUIRE_FPU(ctx);
@@ -584,7 +600,6 @@ static bool trans_MFFSCE(DisasContext *ctx, arg_X_t *a)
 {
     TCGv_i64 fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     gen_reset_fpstatus();
@@ -597,7 +612,6 @@ static bool trans_MFFSCRN(DisasContext *ctx, arg_X_tb *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -614,7 +628,6 @@ static bool trans_MFFSCDRN(DisasContext *ctx, arg_X_tb *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -631,7 +644,6 @@ static bool trans_MFFSCRNI(DisasContext *ctx, arg_X_imm2 *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -647,7 +659,6 @@ static bool trans_MFFSCDRNI(DisasContext *ctx, arg_X_imm3 *a)
 {
     TCGv_i64 t1, fpscr;
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     t1 = tcg_temp_new_i64();
@@ -661,7 +672,6 @@ static bool trans_MFFSCDRNI(DisasContext *ctx, arg_X_imm3 *a)
 
 static bool trans_MFFSL(DisasContext *ctx, arg_X_t *a)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
     REQUIRE_FPU(ctx);
 
     gen_reset_fpstatus();
-- 
2.40.1


