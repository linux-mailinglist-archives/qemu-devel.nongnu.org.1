Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61A72B0EC
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gv2-0001Hs-B9; Sun, 11 Jun 2023 04:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Guw-0001B9-CB
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:22 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Guu-0003dA-Lf
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30ae61354fbso2112367f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473959; x=1689065959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL1Zih1O88caRvf7sSFHzFYcTBs6PNvq9qmGaaGGlCI=;
 b=NdbJcpQTWNeNzxUJzNMqzfziVot6wUUXbgri+Zk8hF+ibBKv7X5zt+H/qIXtMuSOOv
 keRxjnlEZHbBys8qFKfytZBhrXZ5f9S/ZMaxMWlzHPHhYP8n6fY+MTvnNSzsiNGm5sT2
 C5ZhjD3pP4kk4f+DtsH2UHMcBxWdFHEpHYmSQpISesoIqNL5ZKM5fRRBn4a6okHXf81d
 r1DwuGryrHkNmkkdupHqcHHBO6QB3DjyBDZo2fiYJsRRepNT/dKFtpb8NjiXsqEy4uLl
 jILkr5osaB3ok2Wji9tUOYjhYfnhLDbrL6hEQJt4rcNpFejQ1DqxREpDy7MilQowDHgF
 57uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473959; x=1689065959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL1Zih1O88caRvf7sSFHzFYcTBs6PNvq9qmGaaGGlCI=;
 b=QGo47h9IF6ynOXOP4Y/vkO+9XXktGQGkW1wuF0BjSNOMAzhKoORToA4GNw42cR+ZUp
 nVAPlgwlwIbExvNJxAtPwxK3RQoWdfd6t1WAZK82N404vgpXq40rcP9MipKPrrCejJy5
 JAB95JcodP4zpc4f7EVj4OWEpZLxbep7dJXJqMMzRhXlKLw/NCTGT6s2jyVMG0IRKF0x
 E6/xSK1FpsP/9hfwMExQAVacFFANxxSxlCEEu1noOcz4og2+3pJ0x1MAdkgUWHB1Myq8
 DrUsb7Iv4OOwHBxKmZfc6R6bwYM8R+4ZwBfzymgMBkEhZQChatW8nJEom5OCVi/6Mqui
 EPGw==
X-Gm-Message-State: AC+VfDx3YeJ2rVnS8aQH5UE2lNS9LFUxBy75zwGhrSRQ5u/xZgMwwVxH
 3ADNpRqj6au/cBlFmFYsCz5wrbXa55QCzuPx95I=
X-Google-Smtp-Source: ACHHUZ7JcG2adSN6O9eCCOcted4zyrvQmu36Z7AMJH27kiAqNVR2L2Gwra0QFxZmPfDrzdzs/B/J6w==
X-Received: by 2002:adf:dd07:0:b0:30f:bf01:b62a with SMTP id
 a7-20020adfdd07000000b0030fbf01b62amr495722wrm.24.1686473959060; 
 Sun, 11 Jun 2023 01:59:19 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 b5-20020adff905000000b0030aedb8156esm8998995wrr.102.2023.06.11.01.59.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/26] target/arm/tcg: Expose some iwmmxt methods in
 'translate.h'
Date: Sun, 11 Jun 2023 10:58:27 +0200
Message-Id: <20230611085846.21415-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Expose a few methods and variables before extracting iwmmxt
code from translate.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


