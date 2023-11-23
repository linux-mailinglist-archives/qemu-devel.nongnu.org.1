Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538A7F6652
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYE-0008A6-KC; Thu, 23 Nov 2023 13:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYA-000812-Ma
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:43 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EY8-00032G-4a
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:41 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c8880f14eeso14593391fa.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764538; x=1701369338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUz0XGe6SRMXqOSVJvQiXoUHGpw35/yPoukvsO1/DGo=;
 b=quoyJIPcAfapZdut8H3QrV+VIpNOj2pRTRq6bAnVJ+cG+LbnzS5kUJeLk610k5XlvU
 QRR9630dgl5zed7xbsDVbHw97JI7AUXeWtYXHxAh/8EM9RnyYgJuZrerH7wst73iZQK+
 BKYYrEZG8xLnHyulLpgcQCKNU+hSpZsGAy3B59RdSo1BPEY6ETRI3jVGiYKpiSjjsGa9
 EyxvK4QWVBCNC6ArMs6RHHU98mkP3JOSq8R5sT3f4U/pvb+RGudiQxWIQ52i3gt896gZ
 wSuqJVq561ShqejTNhngMWhfvdYl3NAQYqyQcVvpsteNGtJcIsmoPx9ytnTvCoIegR2I
 irWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764538; x=1701369338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUz0XGe6SRMXqOSVJvQiXoUHGpw35/yPoukvsO1/DGo=;
 b=wO9pESa4rk6M324wdLFWMjWoeo76Y2TmPjk0YdjLNYfc/MlvWg121u6z7odm+HmMT5
 DpuA2EXDWMHNIyDUz9D1KUZvl+RZh8s33UbZGGRffFKvFLI0e3ylDCPQRxFfwozVTDGO
 FktTsSkFQUNygXlNm5jDydG88NAMfhvFcrJW0UcihMCUuU7rzRM50RRn/sq7qaPq+HCi
 aEOpnM/g/MusFT2YFAUwjx7chHvidLkFtb12HWkGLB6LBoiMcJmKHZ6BQ9GoWx8yeZs4
 bj7NcV/EJJtrr03/ArHer1Me40fHVcOoFTZz3y4s8rmVCIj6UYEDUkhTuHER7CUzWsB8
 OclA==
X-Gm-Message-State: AOJu0YzD3NZouLWc1JYUwQ/kbLhftRvnh9N58pPp55u++Y3CAia9rOPB
 oklKp80g3ZgxL4tBFtqcEBvmHrHWiej70WJONWE=
X-Google-Smtp-Source: AGHT+IEuvPz5wMMJnFnPWouwjZrhQZklg8n8Qlh0fxAWkPyyLyC5CqCfflm8sHoGFAVFUlWKAA2E+Q==
X-Received: by 2002:a2e:b00e:0:b0:2c5:70f:614a with SMTP id
 y14-20020a2eb00e000000b002c5070f614amr155623ljk.17.1700764537845; 
 Thu, 23 Nov 2023 10:35:37 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a5d6847000000b0032dab20e773sm2268980wrw.69.2023.11.23.10.35.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 03/16] target/arm/kvm: Have
 kvm_arm_add_vcpu_properties take a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:04 +0100
Message-ID: <20231123183518.64569-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
take a ARMCPU* argument. Use the CPU() QOM cast macro When
calling the generic vCPU API from "sysemu/kvm.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm_arm.h | 4 ++--
 target/arm/cpu.c     | 2 +-
 target/arm/kvm.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 50967f4ae9..6fb8a5f67e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -153,7 +153,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  * Add all KVM specific CPU properties to the CPU object. These
  * are the CPU properties with "kvm-" prefixed names.
  */
-void kvm_arm_add_vcpu_properties(Object *obj);
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
 
 /**
  * kvm_arm_steal_time_finalize:
@@ -243,7 +243,7 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_add_vcpu_properties(Object *obj)
+static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 25e9d2ae7b..97081e0c70 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1686,7 +1686,7 @@ void arm_cpu_post_init(Object *obj)
     }
 
     if (kvm_enabled()) {
-        kvm_arm_add_vcpu_properties(obj);
+        kvm_arm_add_vcpu_properties(cpu);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6e3fea1879..03195f5627 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -495,10 +495,10 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
 }
 
 /* KVM VCPU properties should be prefixed with "kvm-". */
-void kvm_arm_add_vcpu_properties(Object *obj)
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(obj);
     CPUARMState *env = &cpu->env;
+    Object *obj = OBJECT(cpu);
 
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
         cpu->kvm_adjvtime = true;
-- 
2.41.0


