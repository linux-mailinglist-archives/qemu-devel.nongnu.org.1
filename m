Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3181907D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWr-0001qP-R8; Tue, 19 Dec 2023 14:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001mm-RI
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:17 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWm-0001mV-4T
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:17 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3365752934bso3970994f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013195; x=1703617995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8U4Zs7qJxd6knz6FwIYeN/wpMsd6G/tgH0Hh4NzLuf8=;
 b=hFRYK+EZzJlMEj1vJrSHIrtegxjCqDKtl6c0uvqwddXz/q1ktdKV8VWbH3Ip3vC15d
 uGV8lVfcoeG4O66uVIiyyYXjdEmA64db/JRidmZ5PZzlrpSnCvQ5MFYEkJGOaCLwcPHG
 Gqz6t6K6y9qz4DIdiIxOdtuayLO600pLzjNCMTt3arFxr67++8VLAK8eTVbBSuZQi8aY
 syvUIAXsM7Yb5Eqk/xnxMyxDSumTnq/4oCkZ+6BT6LJqbDuu1FD6emHkkZZYMpIybmD0
 N9TptXU+xeOmtQ8/8EZtnDTlHMZ9ad/qLLSGIsQseGJA+RGZu73x0ikdE+LRsy0kVJ0V
 7KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013195; x=1703617995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8U4Zs7qJxd6knz6FwIYeN/wpMsd6G/tgH0Hh4NzLuf8=;
 b=XkzaPZFgN2lY+S2qwPDbpRruXB7SwIWoZCZR41eOqCYVy5orWPXgHfsNq8K4rh9oUa
 +JKZy/TrWMn02yYvffiOp2nTow28yu/aF6dGHXxxBcZh2heAkwKGxM2+J1BmzVXzMbFc
 V74s9NQPWnk8g152eEKUsxWGoPpg0lH6az534otr+auu/3VFnQsJKUyMkYAJEcDH3GFF
 ktcDBs8PKnm/RLV0A5t/PZmzrHyrl9L/fasOBf+ZhJaIGnJg8oR8Fza3a1C02dhono5P
 IeVFJj4NoXLD4Kaypm98sbq5pVvCWRE3ZyXfJ8n3sMYh7MDQDMfEawr4RWA5QKeLjbyE
 ihsw==
X-Gm-Message-State: AOJu0Yy1g7f8qJmfhRxRJH8/FamPCrXkDb1QgvpVc+1F016bz5Z7V9tR
 8d9oQQ8y3FYXpYcP+aRyTaPi/v/gqbEI1eN+H1U=
X-Google-Smtp-Source: AGHT+IH1/cCtSrt/d+C0VIqOntWMnfw5yxhYE4kNINzg+jk1tFk4qMwl8c8YTfYhk+axkaG+yExtOg==
X-Received: by 2002:a5d:4c4a:0:b0:336:7793:6ab2 with SMTP id
 n10-20020a5d4c4a000000b0033677936ab2mr297538wrt.143.1703013194661; 
 Tue, 19 Dec 2023 11:13:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/43] target/arm/kvm: Use a switch for kvm_arm_cpreg_level
Date: Tue, 19 Dec 2023 19:12:35 +0000
Message-Id: <20231219191307.2895919-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use a switch instead of a linear search through data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 504526b24c9..61fb9dbde0e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -361,32 +361,18 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-typedef struct CPRegStateLevel {
-    uint64_t regidx;
-    int level;
-} CPRegStateLevel;
-
-/* All system registers not listed in the following table are assumed to be
- * of the level KVM_PUT_RUNTIME_STATE. If a register should be written less
- * often, you must add it to this table with a state of either
- * KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
- */
-static const CPRegStateLevel non_runtime_cpregs[] = {
-    { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
-    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
-};
-
 int kvm_arm_cpreg_level(uint64_t regidx)
 {
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(non_runtime_cpregs); i++) {
-        const CPRegStateLevel *l = &non_runtime_cpregs[i];
-        if (l->regidx == regidx) {
-            return l->level;
-        }
+    /*
+     * All system registers are assumed to be level KVM_PUT_RUNTIME_STATE.
+     * If a register should be written less often, you must add it here
+     * with a state of either KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
+     */
+    switch (regidx) {
+    case KVM_REG_ARM_TIMER_CNT:
+    case KVM_REG_ARM_PTIMER_CNT:
+        return KVM_PUT_FULL_STATE;
     }
-
     return KVM_PUT_RUNTIME_STATE;
 }
 
-- 
2.34.1


