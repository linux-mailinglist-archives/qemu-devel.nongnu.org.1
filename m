Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8B82AD23
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:14:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssZ-0001Rr-NE; Thu, 11 Jan 2024 06:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssI-0001P3-6t
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:31 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssE-0004Ue-6c
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:24 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cceb5f0918so55495551fa.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971120; x=1705575920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=15rlOByBdh8+iLkfPVBVi/SbZWKpkYx6lLXZPs5/sUg=;
 b=eC6N9UXjVt1qnvvzfr3z9DcPxagmUb08+KiZbKptTUsFpO0rn4qYluWu+aEmP0Krua
 A9EURHtU5j9qcHiFxPZttrH7vZAqkxEY84nBVPPiH50uDW9uI9mUZFTkz7LtbX40oqWA
 6z04TbFOk5KnNpchLM/h1sqzIXGWGXipVI+Dl5Dc4y1kAoWlWNFKt6c7dWyCiOLqa1DH
 HiX+xpMLJXhpXfO8DwuX5ZzgTMRbU3/hwISIGoFJ6XTmKRiUyUJpSH1IeVL9WLH7w7wv
 Dumg9Aqh3sx3Q3w8NwYIrbw21I44NWtVV+Lra0u4vAAAAi8q9wDRO/sVAA3cqHu8aLaT
 yQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971120; x=1705575920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15rlOByBdh8+iLkfPVBVi/SbZWKpkYx6lLXZPs5/sUg=;
 b=xR6HmtnQ7OYNIcK6WhSNAX0uXFNZpzXBQZswEcxkN5EETlAQCX2tLvEdS+HGkFCCqc
 22V4KNsvq3MlNuuZlZRe79RMp7uOeVHiLG8Sr2elQjhsnxIgGGtg0NZMCTyVx2N6VH4j
 rJKmtQzbwLHhUB/QP0f8vx61sH84EtzFrvB3BgMveUEYb9UmKZI74pODjNSX5S5Oxq2M
 FMbtOk2F03BRdp3YbcUTe/hhuLEmtj1A8TwE/VgGapQi0jKKntdamJ6vA+0eH+w2aBs6
 TUtltbKubEA5kGOYp3BfPFxlPivIldnkNB3b/I8vlyIos0gZM9STTw1D6Gixd3o5KJuh
 NiYQ==
X-Gm-Message-State: AOJu0YwGlzeMuPMyO0VzwW+r6mJ2xk5xLJ6cFxyZsT3DjkM0kbKejiv4
 P2fZbvsHSNHNl3mta/IlUIQq+yRz6TWK73HglXaZPMPcxdU=
X-Google-Smtp-Source: AGHT+IHv8xiBzmsEhqKOWYGqby7963J7HeIOKru+tz36fWoRyhG8Vqb61JKwRT1n/au29gk7pUTGbA==
X-Received: by 2002:a2e:9bd9:0:b0:2cc:f41d:8f41 with SMTP id
 w25-20020a2e9bd9000000b002ccf41d8f41mr183499ljj.39.1704971120265; 
 Thu, 11 Jan 2024 03:05:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] target/arm: Handle FEAT_NV2 changes to when SPSR_EL1.M
 reports EL2
Date: Thu, 11 Jan 2024 11:04:54 +0000
Message-Id: <20240111110505.1563291-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

With FEAT_NV2, the condition for when SPSR_EL1.M should report that
an exception was taken from EL2 changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
---
 target/arm/helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 53bd6c85990..b9b3aaf4db7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11328,10 +11328,18 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         aarch64_save_sp(env, arm_current_el(env));
         env->elr_el[new_el] = env->pc;
 
-        if (cur_el == 1 && new_el == 1 &&
-            ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV)) {
-            /* I_ZJRNN: report EL2 in the SPSR by setting M[3:2] to 0b10 */
-            old_mode = deposit32(old_mode, 2, 2, 2);
+        if (cur_el == 1 && new_el == 1) {
+            uint64_t hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_NV | HCR_NV1 | HCR_NV2)) == HCR_NV ||
+                (hcr & (HCR_NV | HCR_NV2)) == (HCR_NV | HCR_NV2)) {
+                /*
+                 * FEAT_NV, FEAT_NV2 may need to report EL2 in the SPSR
+                 * by setting M[3:2] to 0b10.
+                 * If NV2 is disabled, change SPSR when NV,NV1 == 1,0 (I_ZJRNN)
+                 * If NV2 is enabled, change SPSR when NV is 1 (I_DBTLM)
+                 */
+                old_mode = deposit32(old_mode, 2, 2, 2);
+            }
         }
     } else {
         old_mode = cpsr_read_for_spsr_elx(env);
-- 
2.34.1


