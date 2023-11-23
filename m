Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECC7F577A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YJ-0006aL-Dg; Wed, 22 Nov 2023 23:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xv-0006NO-50
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:36 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xs-00069f-RK
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:34 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b84478dd51so342529b6e.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714550; x=1701319350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okagnWg4RiqPvXVssy7I/tpmDkLttXZFA5jqAhyzY9s=;
 b=jNbJDXQJc0jmuTonRgh96lNAnP9Hv27YUQKbSoUWjCxOkhZzRx2nJNsuTZzUzKBwPw
 EVy2IeulkJYJPSVwSOpFR6uzlLV8lgB4O+aUkWaYmTrq5mjT8dVCPi3ZP5nVn9Xz01ig
 b9d8roIdQJhekLCkUPRFa/G1KkulxuJ5sXv7Dkv14Hy4KFxIHevk1UxxFrjEgWkky2Hj
 Zo1E/yUy54v7fDa09wCDf/GQPKYqNnm9ZN1fNBdlMckwjQRvCKjrRwrQJiqkqyc4LW/q
 FjNR7yJxQshPbpyeKEGp2B0TXXTBWZcXAtiDcK+PvTtf9A1h4hjlLTpJJEkfuAFL34He
 Kaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714550; x=1701319350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okagnWg4RiqPvXVssy7I/tpmDkLttXZFA5jqAhyzY9s=;
 b=UHzLF6zAw1v+vDA5Py3TlZ4PFvDS2EAh0daRTfJTHzrZgMEq/8M0SF/88b16stVzJR
 ACR00nc21fIvjj1PARvTTkpqDtfPB87/czzF3uPoH25LpbTib3zfxK5kJ6C65Hk7X7gU
 cXd8Hk4xVo1SAI0YZ++6nBt9H+DdX+jH0Y2CPfO0Fmie5bURQek0nyA2AYXTRkWvRHmF
 F8PB7CQPXu5H3Q+t7DCtkTwUBEnTX4H/2En3FeZzuwBBMBbC37heaRpoUg16c7l6YFzo
 ubk/0Jok9a5QoBxg2xO4YwDSm2X841GOCGeDxdhyvnQr7YMXCFrn7sZI2BFbvmE1OvKh
 KfZw==
X-Gm-Message-State: AOJu0YxJjtYTEZglcycB11IC4QesWR6XINFPl+hS7G3oqQYK8SLbk1Ua
 Ha09iY5bmNUb9b3l+3dNfalbDwlGzqrbDyRjADSYN1CW
X-Google-Smtp-Source: AGHT+IF93zMCXqyvsOQOx2lRNsxTrOHczh/TvItBy4wjKyyykbBJ3Mg7h6nR648z/u7mATHCzSfa2g==
X-Received: by 2002:a05:6808:b1c:b0:3b5:6462:3191 with SMTP id
 s28-20020a0568080b1c00b003b564623191mr4849132oij.48.1700714550558; 
 Wed, 22 Nov 2023 20:42:30 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 09/21] target/arm/kvm: Inline kvm_arm_steal_time_supported
Date: Wed, 22 Nov 2023 22:42:07 -0600
Message-Id: <20231123044219.896776-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This function is only used once, and is quite simple.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 13 -------------
 target/arm/kvm64.c   |  7 +------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c32f6ed0..58c087207f 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -274,14 +274,6 @@ void kvm_arm_add_vcpu_properties(Object *obj);
  */
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
 
-/**
- * kvm_arm_steal_time_supported:
- *
- * Returns: true if KVM can enable steal time reporting
- * and false otherwise.
- */
-bool kvm_arm_steal_time_supported(void);
-
 /**
  * kvm_arm_aarch32_supported:
  *
@@ -374,11 +366,6 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
-static inline bool kvm_arm_steal_time_supported(void)
-{
-    return false;
-}
-
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6b6db9374c..fca4864b73 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -399,7 +399,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_arm_steal_time_supported();
+    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
@@ -437,11 +437,6 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
-bool kvm_arm_steal_time_supported(void)
-{
-    return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
-}
-
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(CPUState *cs)
-- 
2.34.1


