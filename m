Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80B819091
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:19:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWs-0001rp-3e; Tue, 19 Dec 2023 14:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWn-0001ml-R7
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:17 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWl-0001lz-5p
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:17 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-336755f1688so724789f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013194; x=1703617994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iHG9jQ+eiRWAlCnCIHDh9pSj/+rOdtp/Ld9fbC2kJeA=;
 b=A6J3UUxpGhHtzhA+/72Bf2ngmamo2FKt8HbDNTfLeT3UigJeHpUrotv180qQJyd7u1
 yGFrsCAOrosURaz0s3Tt5dgKmLV3VsGSZ4CpXBRicz9O/6uYOmNi4QH7cecktWTn18O6
 ZjWGLK/XCrJIBoNIH6WKSa5tF7cD3j1SyZJmxffpa9B11Hv7+tE5m6VeUZtBHVQkm1kV
 lbTg6YrZ/zavuuGbReFH4FiSjhlciY8v6i5kwsVvncdLpDeCBoO1KWOb9N4z3DuAmo3t
 XnJ33Lc+Ck+ivOejQeczfFL6yvQN1IIPbycjqArQEQ1k2I0yiZRSAQqIB8LG5E5oN5fC
 Z4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013194; x=1703617994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHG9jQ+eiRWAlCnCIHDh9pSj/+rOdtp/Ld9fbC2kJeA=;
 b=JojaU1xyFZWpk/VKRNpho/RQT1lDOParwxgOH5HH0krN+PwHfqjK5vBgdZZZxnywvQ
 56dbude+NUa6hd+1w1u0ADNg00Sq/+R7qbPIbnmjxz6DvWx175eWM0LDdXwMRJopkaDD
 igmWwTDY21n/wxOUoTFnVPx1odYGkfWU+JsnLEBULEEfcuzBCXTVQD5nb8mTMXxN17Dl
 WmsV0aUEc9UWq9ofHKjCV0CqyS0ReVDw7Jth7GxvORCELRD4aiNQmAriOgBJOsx80GAo
 CcazTfFRMMLt4h7wVrpOImPQfb7rWq6+lQC3md3RZF8Wpsqo1tFa1ntd8+NKffpyZwZS
 iPLw==
X-Gm-Message-State: AOJu0Ywo8IDZeiRkK/sv5dGt8DFqpgX1DX3WFvenNYdwMJvgIWYxpGtB
 R+2wAIZS9QVpUhmi/Ob3jHq2yjJLqcNPJXe511w=
X-Google-Smtp-Source: AGHT+IHFvzaGbuXT4B4QNDWStwF8IjMNByy0zZ0tYTLzNDu0aoJouAd12HpL0xp7F+6VrlXmwq8yFg==
X-Received: by 2002:a05:6000:1c6:b0:336:4297:b25d with SMTP id
 t6-20020a05600001c600b003364297b25dmr5597294wrx.136.1703013193787; 
 Tue, 19 Dec 2023 11:13:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/43] target/arm/kvm: Inline kvm_arm_steal_time_supported
Date: Tue, 19 Dec 2023 19:12:33 +0000
Message-Id: <20231219191307.2895919-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

This function is only used once, and is quite simple.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 13 -------------
 target/arm/kvm64.c   |  7 +------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index e7c32f6ed07..58c087207f5 100644
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
index 6b6db9374c6..fca4864b739 100644
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


