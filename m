Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C36819077
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:16:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXB-00022y-OC; Tue, 19 Dec 2023 14:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWv-0001vf-Jc
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWs-0001qh-UG
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:25 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33668163949so2809088f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013201; x=1703618001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h3V71XAx3UDA0zBtoUkIA2yNtSzC2BWFrBTkEOk1jT4=;
 b=rHYclgNF2FmdSJqPqjaIx07zD4O4ZilkQt7JXensIj6uWK65XUsWO0Uks8F1QS8+tM
 qHZpxqRtM9Asp2OfrtTJEAAXPeBwD2cT5tD0ip0eOkwKW0IZAOi61yoT0Xg7oxx46qZJ
 dLPdwfYgiJeUNbZ/gAbD6I7YBbIF2VJXE65zDU5a9zEobnVLlu6RjFTdYZfT00ZHphvr
 /97PEVaLD49/aKP+NMxVEdkihUwEYU2bWxMxBFmhqtGqDKd3N0tgAhub9JL6twMgwtyh
 Uxik1paI07dTGkbnAVrrnfi3krgSZ3mvGmIbr1+7Iv7LksIyTaNyHkJ/tuSFxbRd/zTD
 UYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013201; x=1703618001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3V71XAx3UDA0zBtoUkIA2yNtSzC2BWFrBTkEOk1jT4=;
 b=oZM2JABsmT4JDxlfST8S7jFD64qPR3Y3ymhNQsC0zloetkmq7XNrutg3Q8+ebupxic
 SKBng26yK6ilwgEZIF0WwlDEOxucvsQv+tXdImEuCF86lun1CB3HujiovwBWBPDBeC1R
 AWbr7ec1LVDtzKb81tf+XznPCTPKFJwaaOS5Jy9jDt6Iq1dUZn3w9K9yvXGzw4LXLyM+
 qyoWfyddcO1117UwMKoxlsnPARaZm/UJcMgGMlF996fyhsdsAQamBhHdZJKD9RwZNQZW
 u8qQ6pGX4XVtJM/6SfEEIZFqLkbbZt5b6nH41pop1S8n2OexP1+p70JXaJdFQFLCP59c
 bvmg==
X-Gm-Message-State: AOJu0YzKuXiBjARyX54bH9wQFte06wLusmr9RT+yIUWbgYeWm4XNTZCE
 +vEud7iqEzN/TXFOojF7oxzOvXxI6Heb7ttzIhQ=
X-Google-Smtp-Source: AGHT+IE7IQCmULk4WrzZ0HxkPqv0tYHYAbWSaueyrg+Fcl/Rcr3RKFJlAk1SpNWI96zkjlWPSaOY0A==
X-Received: by 2002:a05:6000:1f0f:b0:336:6dad:2698 with SMTP id
 bv15-20020a0560001f0f00b003366dad2698mr1003805wrb.82.1703013201313; 
 Tue, 19 Dec 2023 11:13:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/43] target/arm/kvm: Have kvm_arm_sve_get_vls take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:50 +0000
Message-Id: <20231219191307.2895919-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20231123183518.64569-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 6 +++---
 target/arm/cpu64.c   | 2 +-
 target/arm/kvm.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 3abbef02601..d6d999b1ff8 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -129,13 +129,13 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
 /**
  * kvm_arm_sve_get_vls:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Get all the SVE vector lengths supported by the KVM host, setting
  * the bits corresponding to their length in quadwords minus one
  * (vq - 1) up to ARM_MAX_VQ.  Return the resulting map.
  */
-uint32_t kvm_arm_sve_get_vls(CPUState *cs);
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
 
 /**
  * kvm_arm_set_cpu_features_from_host:
@@ -278,7 +278,7 @@ static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
     g_assert_not_reached();
 }
 
-static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
+static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1e9c6c85aec..8e30a7993ea 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -66,7 +66,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
      */
     if (kvm_enabled()) {
         if (kvm_arm_sve_supported()) {
-            cpu->sve_vq.supported = kvm_arm_sve_get_vls(CPU(cpu));
+            cpu->sve_vq.supported = kvm_arm_sve_get_vls(cpu);
             vq_supported = cpu->sve_vq.supported;
         } else {
             assert(!cpu_isar_feature(aa64_sve, cpu));
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e9c6e2e17c1..132a1b47d04 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1801,7 +1801,7 @@ bool kvm_arm_sve_supported(void)
 
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
-uint32_t kvm_arm_sve_get_vls(CPUState *cs)
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
 {
     /* Only call this function if kvm_arm_sve_supported() returns true. */
     static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
-- 
2.34.1


