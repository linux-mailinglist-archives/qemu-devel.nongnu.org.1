Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC11819098
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX6-000215-Ve; Tue, 19 Dec 2023 14:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zd-40
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWz-0001sl-B9
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336417c565eso4661219f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013208; x=1703618008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ku+7zxeUKUJMUxVPqQDK2gFDtGrYkzffZzuDnYb6rLU=;
 b=iDK1gF4jGdB5k6JhJOxN5/TF156oA8Z6XE24HLxIydKmuLCpsb2rstxORr+qM3vtKg
 17TOAChFMCfX9oCfQECrAJEg6Azf6VdID6mDS5iPcBEYyBKVlzt5c2eCFYqhPI736qmr
 z825Be4G9pNGweMgAyz9+ZEUk9UWwQedHJWMI5gjrDLzojPMEE33qBHWkk4GgjPmDd7x
 7zR7b5ebFfkC+tJGM4beo7u/BZI6XBqta9NkHHAWDqpzISd27gjIEitwo9yVpO1PTljr
 mOTYaQOlmZpY3VbhlpWPOL6VsUMQsx4LjhB0zvVIwr01a10kCGnnkxZDUOMaMtWtEufs
 QCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013208; x=1703618008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ku+7zxeUKUJMUxVPqQDK2gFDtGrYkzffZzuDnYb6rLU=;
 b=SFwVlv6MqNRbjPNCwx6EJ5hbT/KP3Kqq4rBYVTVojD7E8Gjy1xFjvrRZ3vYwJ6UsSf
 fxxHDp48zdJUI1oxwaUc3EH4U/njb/kSTeVb5yAT6kjy9dQFYjFSQ9H3tmYrJFRgZbM3
 3xxzHg++NXV6I/o3qbXSamWvStDq6Lt7BycTNiePiL64zE24XkyBu8yKOZSQNM4q/Qem
 TOsaeMVEQxacnGJP68zQd/fmszuuyHCgLs6yIK+Ds4BNGX94lw0F7DqKpKhV5x633Cfq
 CWeZvWfpger7aqmlw1u7aDIU6HBPZ31XufmENVm9rW+zr4xnSE4ywtzPl8hAi0DL4GCZ
 g6sg==
X-Gm-Message-State: AOJu0YzPLCATRGBHPGSNn151GcAYHY9CmhaEIVx3WeTHCWRgLO9Lnd9I
 bPf9jwY/ZnwHNPXK9cH8bcZQ0Jd8dpUjQmy92a8=
X-Google-Smtp-Source: AGHT+IElnIP5Id16grkP17VHgilK0qg5TH9wnMC2m/E5OIi9DIMGcM52SECJ8yT3fJsjCznt6GBMJA==
X-Received: by 2002:a5d:588a:0:b0:336:6b74:87e9 with SMTP id
 n10-20020a5d588a000000b003366b7487e9mr1335492wrf.14.1703013208003; 
 Tue, 19 Dec 2023 11:13:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/43] target/arm: Restrict TCG specific helpers
Date: Tue, 19 Dec 2023 19:13:03 +0000
Message-Id: <20231219191307.2895919-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231130142519.28417-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c        | 55 --------------------------------------
 target/arm/tcg/op_helper.c | 55 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 39830c7f948..5d4796b99a8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10142,61 +10142,6 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
     }
 }
 
-/* Sign/zero extend */
-uint32_t HELPER(sxtb16)(uint32_t x)
-{
-    uint32_t res;
-    res = (uint16_t)(int8_t)x;
-    res |= (uint32_t)(int8_t)(x >> 16) << 16;
-    return res;
-}
-
-static void handle_possible_div0_trap(CPUARMState *env, uintptr_t ra)
-{
-    /*
-     * Take a division-by-zero exception if necessary; otherwise return
-     * to get the usual non-trapping division behaviour (result of 0)
-     */
-    if (arm_feature(env, ARM_FEATURE_M)
-        && (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_DIV_0_TRP_MASK)) {
-        raise_exception_ra(env, EXCP_DIVBYZERO, 0, 1, ra);
-    }
-}
-
-uint32_t HELPER(uxtb16)(uint32_t x)
-{
-    uint32_t res;
-    res = (uint16_t)(uint8_t)x;
-    res |= (uint32_t)(uint8_t)(x >> 16) << 16;
-    return res;
-}
-
-int32_t HELPER(sdiv)(CPUARMState *env, int32_t num, int32_t den)
-{
-    if (den == 0) {
-        handle_possible_div0_trap(env, GETPC());
-        return 0;
-    }
-    if (num == INT_MIN && den == -1) {
-        return INT_MIN;
-    }
-    return num / den;
-}
-
-uint32_t HELPER(udiv)(CPUARMState *env, uint32_t num, uint32_t den)
-{
-    if (den == 0) {
-        handle_possible_div0_trap(env, GETPC());
-        return 0;
-    }
-    return num / den;
-}
-
-uint32_t HELPER(rbit)(uint32_t x)
-{
-    return revbit32(x);
-}
-
 #ifdef CONFIG_USER_ONLY
 
 static void switch_mode(CPUARMState *env, int mode)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index ea08936a852..9de0fa2d1f6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -121,6 +121,61 @@ void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
     }
 }
 
+/* Sign/zero extend */
+uint32_t HELPER(sxtb16)(uint32_t x)
+{
+    uint32_t res;
+    res = (uint16_t)(int8_t)x;
+    res |= (uint32_t)(int8_t)(x >> 16) << 16;
+    return res;
+}
+
+static void handle_possible_div0_trap(CPUARMState *env, uintptr_t ra)
+{
+    /*
+     * Take a division-by-zero exception if necessary; otherwise return
+     * to get the usual non-trapping division behaviour (result of 0)
+     */
+    if (arm_feature(env, ARM_FEATURE_M)
+        && (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_DIV_0_TRP_MASK)) {
+        raise_exception_ra(env, EXCP_DIVBYZERO, 0, 1, ra);
+    }
+}
+
+uint32_t HELPER(uxtb16)(uint32_t x)
+{
+    uint32_t res;
+    res = (uint16_t)(uint8_t)x;
+    res |= (uint32_t)(uint8_t)(x >> 16) << 16;
+    return res;
+}
+
+int32_t HELPER(sdiv)(CPUARMState *env, int32_t num, int32_t den)
+{
+    if (den == 0) {
+        handle_possible_div0_trap(env, GETPC());
+        return 0;
+    }
+    if (num == INT_MIN && den == -1) {
+        return INT_MIN;
+    }
+    return num / den;
+}
+
+uint32_t HELPER(udiv)(CPUARMState *env, uint32_t num, uint32_t den)
+{
+    if (den == 0) {
+        handle_possible_div0_trap(env, GETPC());
+        return 0;
+    }
+    return num / den;
+}
+
+uint32_t HELPER(rbit)(uint32_t x)
+{
+    return revbit32(x);
+}
+
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
-- 
2.34.1


