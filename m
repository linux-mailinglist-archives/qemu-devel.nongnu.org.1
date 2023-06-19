Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF07735B5D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH2w-0003ev-R4; Mon, 19 Jun 2023 11:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2u-0003Yx-Em
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2r-000180-Go
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31109cd8d8cso3342367f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189436; x=1689781436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL1Zih1O88caRvf7sSFHzFYcTBs6PNvq9qmGaaGGlCI=;
 b=F3p1GJvOBzRYX+oQcB4KOcPwohuyiC/NwphpH6cw202L2pMbS/VpDmgY0p9ntiSoPm
 7iBr5Yt/+X/1JTQxkgHktCCQIbvK9hDw756Z1mpFNWAaugidIedFX+LMI7XVNNwiJE8j
 UxjMYvKurjlVt+c62jImob2r2Y75v7hsUxFhKG8JF76gy4BTfO1POG+UIeBw7XoE/vA0
 r24EhkVeS3tAZLRbIanQVylhuRfPoH0Vj3shMc8/sfRRf/gnBjf37QgWp2FbD7mTjjqM
 xe/hxAQheHw8wfNE/CwunRb0Mc5NxtT4ZPCn3UZvMsb/B9zVfRjzv8CNSHVBkdM6E5vC
 DHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189436; x=1689781436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL1Zih1O88caRvf7sSFHzFYcTBs6PNvq9qmGaaGGlCI=;
 b=fEOHxBcx7qNl2v/WcOeKMnHuKxArhyOE5QIPJILaBAueIPd/YTuZbW0WmFS+YAEPaM
 7jRwz34zCQDEnO61V3OEdTHmFw91cieTF5KVpbFjIIUoyRW51CyJTEnMjX6Xrsoi+Hn6
 iB2wQWvH/g7oOWN3AW43x35Gh9r7xdnY5EW8tTTUPqkLMwB2u2QEGhHlZrWs6K4H/Bsz
 aE0hW8S6m9ozQMtxybvcJyxMJDkXNnatbZGmU6qknQqGkee3AnxlB/lT3K6o2cNIjZNe
 ICzwN7a1x/G3Fo15FyN/25iXh2W+SixMYb1lwEETx4g366Fw3ofVyDR3BETHBAfSricT
 745Q==
X-Gm-Message-State: AC+VfDylZW6pS/qJqIpFOqSOW4aOVvpuW82UgTbZkXDHjsAEA4THDLYA
 35TknebSDMOneO4SXbVw3Qtri12yyviUfRffQstgfQ==
X-Google-Smtp-Source: ACHHUZ5mU/Nmlsulsj63qnvP5wU2uDsKDNCD3p4yp30v73MWWmVZW+aZKnG4fMf1KNg1jVN7ztql6w==
X-Received: by 2002:adf:f203:0:b0:30f:b65a:e5a1 with SMTP id
 p3-20020adff203000000b0030fb65ae5a1mr7603171wro.38.1687189435752; 
 Mon, 19 Jun 2023 08:43:55 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4643000000b0030fd23381ffsm12913966wrs.11.2023.06.19.08.43.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:43:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/34] target/arm/tcg: Expose some iwmmxt methods in
 'translate.h'
Date: Mon, 19 Jun 2023 17:42:33 +0200
Message-Id: <20230619154302.80350-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


