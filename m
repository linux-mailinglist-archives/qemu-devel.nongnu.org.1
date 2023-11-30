Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6147FF1B9
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 15:26:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hz3-0006GO-2J; Thu, 30 Nov 2023 09:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hz0-0006Fi-7T
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:38 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hys-0008Mh-3n
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 09:25:37 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54af0eca12dso1065938a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701354328; x=1701959128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoizzG5xhbCsM7Lv7ogHVV2wsLPjyGAgiELWh60n2G8=;
 b=G70tfHUcbdWVRnXCkTYa4yEENAJPfqnC+uiFMdlCGZElv4+7fpS8R4v6MObwxSxzCk
 YCAn98N6NRRywcnqh6ttgJVQ8do72cpQVsGtD028ch6owsfq8VBPCIamEsvmkC4FlYyW
 Ci6xPfCh1ywBFxQAlSD6ll+AVf2jWNUBS4nAqBPTIzCPavFPMqw4s4QZHlFYxQnJIebi
 aRE3219YnNsTuEX2iVUHGRPXJgl1URW+huYKWRMqqwaWRxCNNjvSQUY8RLvCeUPNINrc
 FG3vwViftJOfVMxBHhmr8VXn9z8MFMLA0g26I0qKHkGtaeVLXDoIM4bDy42+hBV9Mp+X
 Z9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354328; x=1701959128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoizzG5xhbCsM7Lv7ogHVV2wsLPjyGAgiELWh60n2G8=;
 b=YMLdWzFCjHsclyUs2g6mViy9Zh+8HyPQDiI19aByS2e8ZU3IKDzp2rRWb0NdZ5WL9G
 5BucPj8WD5ujrebuPke8efVxnyRL0r6zNYQ4mXjQcdrtWk3a2NFewWM7QO8M77lWJhWP
 SeERMldF9P1OZlYH3iUCD7lt1CKmwVc3Yyy7KQnK9sJyfsY4ndgJGYPxx6hf8M+ssBOw
 /GhuHWU+ZbK5QEgkW5OGTKH+G6wkWomAtFic4jb/qCF1o96kJPxP59QadCjfUV9Wi99w
 ONROJa+T2cl3jCsyxOrFOcPFuVyUGeZefB9FtcbCYeU+AaL13TrA2hd5z0QTic6I2SbY
 wCaQ==
X-Gm-Message-State: AOJu0Yz82Oqp6r5wlKetI7npHTtlXl0XmrsvEKimWjyM4vw6X7OdwHYq
 nykE+0EvH+v+i6G1y0oDAr0JA5XoPj7DJw571ttJrg==
X-Google-Smtp-Source: AGHT+IH962RhB7ahIyV4NlSty6Ff8XSNc6xQjmeZrcwguK5qQwOzDkHdV0RHGEZMl61n08tJsnKvtg==
X-Received: by 2002:a50:cd9d:0:b0:54b:5243:f7d6 with SMTP id
 p29-20020a50cd9d000000b0054b5243f7d6mr9622510edi.32.1701354327887; 
 Thu, 30 Nov 2023 06:25:27 -0800 (PST)
Received: from m1x-phil.lan (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 h13-20020aa7c60d000000b0053e5f67d637sm586275edq.9.2023.11.30.06.25.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 06:25:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/3] target/arm: Restrict TCG specific helpers
Date: Thu, 30 Nov 2023 15:25:17 +0100
Message-ID: <20231130142519.28417-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130142519.28417-1-philmd@linaro.org>
References: <20231130142519.28417-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.c        | 55 --------------------------------------
 target/arm/tcg/op_helper.c | 55 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2746d3fdac..4844cf1d78 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10135,61 +10135,6 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
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
index ea08936a85..9de0fa2d1f 100644
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
2.41.0


