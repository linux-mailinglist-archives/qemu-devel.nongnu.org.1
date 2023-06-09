Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69623729761
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZfQ-0001pf-KD; Fri, 09 Jun 2023 06:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zf4-0001in-44
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:06 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zf1-0001IV-Hb
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:05 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f6255ad8aeso2034923e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307681; x=1688899681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkXS39fMyxDT7PDxjl903VAfYr5/Pxj8Kks7jV8gUII=;
 b=XQC/QydqPl2AZL4/XCjEnOodnq7FTgZ9DMj3v3oPxKokZTgogKBZXtNXFhrF/1Vgw4
 Kh6BFAh21uCImTmIXVjJIDNikGIiMccB65MpJJ5RtGSOShvQrtLI+S52snP6pj2W7ypw
 dnxfd9l60NGLk9X5ro2JqiLntHuDiaZgIGqLUPojDxVRFftEEJD4y3h/fydeMr0VDxIb
 4h/STGFejwCxJ+si5BNoedGYn1tDNM1BbB5NWbCEmH6mjc8zWE2nz8hslKZRRaR1FnBB
 24hsk0BWiCgUtjWI3U3JuPkBUEIZh6mcRh+VzFnpAPT9pjVD7p/elw8XtHZf6QJMBQK8
 GLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307681; x=1688899681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkXS39fMyxDT7PDxjl903VAfYr5/Pxj8Kks7jV8gUII=;
 b=NztTALeu9EaQXFKnwbAkd8sKWHPs0k2ULI/OtMv3HKrePJWKObxMQQZxx2ESoeXwQa
 y9psOtfeHPyq4/6uP4OgfMod8B4Mg1LN2DRoR/VK2QZSrHfMB33qSkAM8TEHKTojl1qQ
 Yqq7KKIzx6GDfvalsOunV67NlCzu+1+YLQ+NfE1ITkM4XlxgdhCkyTc6BEGlkFAHqTN/
 kTp9eROg9xxiD3FIGkVMTCOA8IpM0ZlMuKrkOikoVuyeJPQwRncO+r2uFBBIKYO/EBcQ
 ONjojYsdqf18u89aSpoh8HFlcM0AR4vU6LRFp+/761D9lvaxdOodyN4g77Ugnp5JuIod
 HKLQ==
X-Gm-Message-State: AC+VfDyBEueoQwdH960RMl3th6xdTaGUf2zEFlwCmODMbRr3Vb7gtjOe
 rirrAZ79TP3apc0FUZrMIa79XyTY0t1AmzomtqHKzg==
X-Google-Smtp-Source: ACHHUZ6FpiPzOI+gZWQ+r/n5QeTt+j3LIi5xMSdWxNPB7ASYuB06wPvq6i9VhKUzpSZbOoA+d2nXhQ==
X-Received: by 2002:a05:6512:32ab:b0:4f3:b32d:f744 with SMTP id
 q11-20020a05651232ab00b004f3b32df744mr692164lfe.11.1686307681674; 
 Fri, 09 Jun 2023 03:48:01 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adffd86000000b0030ae87bd3e3sm4110588wrr.18.2023.06.09.03.48.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/22] target/arm/tcg: Expose some iwmmxt methods in
 'translate.h'
Date: Fri,  9 Jun 2023 12:47:02 +0200
Message-Id: <20230609104717.95555-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Expose a few methods and variables before extracting iwmmxt
code from translate.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.h | 6 ++++++
 target/arm/tcg/translate.c | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d1cacff0b2..3d7c55d3b6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -165,6 +165,7 @@ typedef struct DisasCompare {
 } DisasCompare;
 
 /* Share the TCG temporaries common between 32 and 64 bit modes.  */
+extern TCGv_i32 cpu_R[16];
 extern TCGv_i32 cpu_NF, cpu_ZF, cpu_CF, cpu_VF;
 extern TCGv_i64 cpu_exclusive_addr;
 extern TCGv_i64 cpu_exclusive_val;
@@ -298,6 +299,11 @@ static inline int curr_insn_len(DisasContext *s)
 /* CPU state was modified dynamically; no need to exit, but do not chain. */
 #define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
+/* These are TCG temporaries used only by the legacy iwMMXt decoder */
+extern TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
+int disas_iwmmxt_insn(DisasContext *s, uint32_t insn);
+int disas_dsp_insn(DisasContext *s, uint32_t insn);
+
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_update_pc(DisasContext *s, target_long diff);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3238463f13..aaa479521e 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -45,9 +45,9 @@
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
 /* These are TCG temporaries used only by the legacy iwMMXt decoder */
-static TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
+TCGv_i64 cpu_V0, cpu_V1, cpu_M0;
 /* These are TCG globals which alias CPUARMState fields */
-static TCGv_i32 cpu_R[16];
+TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
@@ -1490,7 +1490,7 @@ static inline int gen_iwmmxt_shift(uint32_t insn, uint32_t mask, TCGv_i32 dest)
  * Disassemble an iwMMXt instruction.
  * Returns nonzero if an error occurred (ie. an undefined instruction).
  */
-static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
+int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
 {
     int rd, wrd;
     int rdhi, rdlo, rd0, rd1, i;
@@ -2509,7 +2509,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
  * Disassemble an XScale DSP instruction.
  * Returns nonzero if an error occurred (ie. an undefined instruction).
  */
-static int disas_dsp_insn(DisasContext *s, uint32_t insn)
+int disas_dsp_insn(DisasContext *s, uint32_t insn)
 {
     int acc, rd0, rd1, rdhi, rdlo;
     TCGv_i32 tmp, tmp2;
-- 
2.38.1


