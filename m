Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB578F5DE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqak-0003w1-1e; Thu, 31 Aug 2023 18:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaZ-0003vV-MX
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:36 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqaV-0002rA-OP
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:56:35 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so24071511fa.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522589; x=1694127389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu4c9RFtBaI++TDfUfro9qCLzzwcVfWMk2RIqvZtG8c=;
 b=GTfYsgqo7ijh+8jeEQAnVC3XyjzS8eBS3JPUxKmtWU4J0AG/axnP8xLvWJgRYCZ8uT
 sQ0Wlz7kIQZoYTNXE55CsxEuKxDqDBenvJStG2Pl46QEcsENwV3ZdqP041Z1bO7Bn59D
 BdTVsUwSrCu6UlB4KmnHcF7PYdI8higLijkeFmSe3ZTStX7LGNmvDvXcH3LM/HXqd9AW
 RyOniZM2qchb+eqRVXPHV285ZK5q7Vd729AJkm0e9X5Lnc0zLOHkdZLwcubsb1DbqMzt
 2UxuHw0LfH/CbTm2UOBYyCwonzlxRzpOjI29AwqYXkN7J8RAHwlFEuoMZiKYzjJSn5GV
 8Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522589; x=1694127389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qu4c9RFtBaI++TDfUfro9qCLzzwcVfWMk2RIqvZtG8c=;
 b=Guph8hvurGhxx5j/UFtPvLrDzuLnuxUErNVgageNzYWuhlY7VuawyOntAOv3+ymQQM
 qeKWobFHl1bU3oPSe6jVek62/No/gqSOOb6468WGRJLs+Ihvj1OYqWCGdZ2txSCKAM+I
 zUgHBT+3hS989qXvlyVGfHUjTbJldppQtbvY7xpHVP/uBE/rpeOLMabcX/m9LF1oWlya
 UQbKkZTJ+iH/DxKnRp+2pdRn2O5266ItJ4eDaImnvJqODcP3/8M6YgJvgoYGvQPhts02
 s+O9kHlUzRotCA2NA8QoWthM5/eb6IaxLAlXSvbqWzSjGw5IWmIiKpZalXLP6oUU5G+Q
 +AYA==
X-Gm-Message-State: AOJu0YzyHOy7pU02R11pdBhRJoBjMRf9+BBuSa1Er0M7EpmqauKjH6YX
 5B0QUt0myFZabM4W0ig0HLNWvJNzKQS3/v5Gw1U=
X-Google-Smtp-Source: AGHT+IFT2Dn6/lcb5RtCXpGRNwLMahWDUmFbejUyEf6WPp7iYiPWBJ+xMAep1CwL9ed0SALBMGNkXA==
X-Received: by 2002:a05:6512:33d5:b0:4f8:631b:bf77 with SMTP id
 d21-20020a05651233d500b004f8631bbf77mr513403lfg.22.1693522589028; 
 Thu, 31 Aug 2023 15:56:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa7c0c4000000b005232e637c24sm1302592edp.84.2023.08.31.15.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 03/11] target/mips: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:55:58 +0200
Message-ID: <20230831225607.30829-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  target/mips/tcg/nanomips_translate.c.inc:4410:33: error: declaration shadows a local variable [-Werror,-Wshadow]
                        int32_t imm = extract32(ctx->opcode, 1, 13) |
                                ^
  target/mips/tcg/nanomips_translate.c.inc:3577:9: note: previous declaration is here
    int imm;
        ^
  target/mips/tcg/translate.c:15578:19: error: declaration shadows a local variable [-Werror,-Wshadow]
    for (unsigned i = 1; i < 32; i++) {
                  ^
  target/mips/tcg/translate.c:15567:9: note: previous declaration is here
    int i;
        ^
  target/mips/tcg/msa_helper.c:7478:13: error: declaration shadows a local variable [-Werror,-Wshadow]
            MSA_FLOAT_MAXOP(pwx->w[0], min, pws->w[0], pws->w[0], 32);
            ^
  target/mips/tcg/msa_helper.c:7434:23: note: expanded from macro 'MSA_FLOAT_MAXOP'
        float_status *status = &env->active_tc.msa_fp_status;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c             | 8 ++++----
 target/mips/tcg/translate.c              | 8 +++-----
 target/mips/tcg/nanomips_translate.c.inc | 6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 29b31d70fe..391a5fca26 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -7431,15 +7431,15 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
 #define MSA_FLOAT_MAXOP(DEST, OP, ARG1, ARG2, BITS)                         \
     do {                                                                    \
-        float_status *status = &env->active_tc.msa_fp_status;               \
+        float_status *status_ = &env->active_tc.msa_fp_status;              \
         int c;                                                              \
                                                                             \
-        set_float_exception_flags(0, status);                               \
-        DEST = float ## BITS ## _ ## OP(ARG1, ARG2, status);                \
+        set_float_exception_flags(0, status_);                              \
+        DEST = float ## BITS ## _ ## OP(ARG1, ARG2, status_);               \
         c = update_msacsr(env, 0, 0);                                       \
                                                                             \
         if (get_enabled_exceptions(env, c)) {                               \
-            DEST = ((FLOAT_SNAN ## BITS(status) >> 6) << 6) | c;            \
+            DEST = ((FLOAT_SNAN ## BITS(status_) >> 6) << 6) | c;           \
         }                                                                   \
     } while (0)
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9bb40f1849..26d741d960 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15564,10 +15564,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
 void mips_tcg_init(void)
 {
-    int i;
-
     cpu_gpr[0] = NULL;
-    for (i = 1; i < 32; i++)
+    for (unsigned i = 1; i < 32; i++)
         cpu_gpr[i] = tcg_global_mem_new(cpu_env,
                                         offsetof(CPUMIPSState,
                                                  active_tc.gpr[i]),
@@ -15584,7 +15582,7 @@ void mips_tcg_init(void)
                                                rname);
     }
 #endif /* !TARGET_MIPS64 */
-    for (i = 0; i < 32; i++) {
+    for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
 
         fpu_f64[i] = tcg_global_mem_new_i64(cpu_env, off, fregnames[i]);
@@ -15592,7 +15590,7 @@ void mips_tcg_init(void)
     msa_translate_init();
     cpu_PC = tcg_global_mem_new(cpu_env,
                                 offsetof(CPUMIPSState, active_tc.PC), "PC");
-    for (i = 0; i < MIPS_DSP_ACC; i++) {
+    for (unsigned i = 0; i < MIPS_DSP_ACC; i++) {
         cpu_HI[i] = tcg_global_mem_new(cpu_env,
                                        offsetof(CPUMIPSState, active_tc.HI[i]),
                                        regnames_HI[i]);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index a98dde0d2e..d81a7c2d11 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4407,8 +4407,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_BPOSGE32C:
                     check_dsp_r3(ctx);
                     {
-                        int32_t imm = extract32(ctx->opcode, 1, 13) |
-                                      extract32(ctx->opcode, 0, 1) << 13;
+                        imm = extract32(ctx->opcode, 1, 13)
+                            | extract32(ctx->opcode, 0, 1) << 13;
 
                         gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2,
                                               imm << 1);
@@ -4635,7 +4635,7 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_LI16:
         {
-            int imm = extract32(ctx->opcode, 0, 7);
+            imm = extract32(ctx->opcode, 0, 7);
             imm = (imm == 0x7f ? -1 : imm);
             if (rt != 0) {
                 tcg_gen_movi_tl(cpu_gpr[rt], imm);
-- 
2.41.0


