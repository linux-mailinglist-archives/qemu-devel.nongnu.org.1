Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207F816C8F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsI-00074r-U0; Mon, 18 Dec 2023 06:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsG-000729-Of
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs7-0003Md-OH
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so35158825e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899198; x=1703503998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W8Km95/I79yd+g2RdegOUvHS7Z7Mlhpw+dHaXH+5iSw=;
 b=hREfcNlFY7opQZfj6oqpy+Gjmzvs6C0oVa+UcgH72cqxZFWR5yLoXPMK9jHau9y0va
 UCe4xG1xSnU1x1JMfziZFO36PQFhzFStHjYGgIDhmKA0JAaFSSj262mO2a7z/+Gtdc/Q
 uFCsgKRp7D7bW1mXtD89p7pi2IBGx/2s621QHL3xnQPOO5X1fzOQR6D091cDHh+xr3e6
 s2oRtgK3nQ6OQV9HRaVA9cFKNAh8BA+woC3qH3FcxbR/APY/nDJRy2p4Zt1k1SPy6i5a
 MmC6zYgxnBXJjAESYPeL8Hsyd0pnoSFwpm2Z4jKM4gYaqYIABJmXC3gCuCYlYFLpb9dQ
 HuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899198; x=1703503998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8Km95/I79yd+g2RdegOUvHS7Z7Mlhpw+dHaXH+5iSw=;
 b=TliJpx6FiOYYjbkfcr2OaJo1d+5fNm3A2qIDoFspTdcR+vgAzC5xvZE0RUBtu6tfr0
 EkfSV5S6rLwAJx3Xs/Uhh2/W21hnp2/XpPT2flSfXnU5zeqISpE1hJ2KydBHUjkS9GpP
 vwLzlI4YLpGWMbhkYsoHaAlHBub2cyh8dWIooSjMt90zMLi+iKYEiDPuq/wXxYqRn0cp
 DdlKhefbg+FYrRg377G9bt68T8iD1YKwp1w1zExlWE9Au/Mg9ZmkqMvFYebsKD2//+Hj
 E+nL5AaA4V9D6hLx2tOytviRCU2jl0LDP9ftXZoSeG/uK11yMQj9sU6ZIIVE/RD2TlRa
 ymeA==
X-Gm-Message-State: AOJu0YxEpW+lp38bKhBzsYhh4MyrYEKhV4qgHldZVIVL9hKRHEc8IEvH
 GTyWWGqPGcroMQnmU5PkeSfvuA==
X-Google-Smtp-Source: AGHT+IHEtLjzQXaN8sNf35RZZyfQ3KxBaKGklT0lMiuyu6UVqOuviHv5f6zBlOPWiZjHnVk2orXu8w==
X-Received: by 2002:a05:600c:319b:b0:40c:2fa2:f6e2 with SMTP id
 s27-20020a05600c319b00b0040c2fa2f6e2mr7536963wmp.190.1702899198319; 
 Mon, 18 Dec 2023 03:33:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 24/35] target/arm: Handle FEAT_NV2 changes to when SPSR_EL1.M
 reports EL2
Date: Mon, 18 Dec 2023 11:32:54 +0000
Message-Id: <20231218113305.2511480-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

With FEAT_NV2, the condition for when SPSR_EL1.M should report that
an exception was taken from EL2 changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 45444360f95..38e16c2f8a5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11405,10 +11405,18 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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


