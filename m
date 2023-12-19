Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A539781908B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXH-00024w-9H; Tue, 19 Dec 2023 14:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001xT-0i
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWt-0001r7-Gn
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:27 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33621d443a7so5046738f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013202; x=1703618002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6zD6GqgpYlUbqN0SJRkAPG9ZDb0+QKHBj7N0uvLGJQI=;
 b=V1pOi+0O69AQzp4EkB/kv8pYe1406kYdJwP8W6t5k9vNJHhBHEfRwS5x6/mA4qhu8M
 h1c7p16fsp3lvsCJ+3QwBlxMzMhz0KXRTTcLL4ghEl59kq9oc76t9psQJ9w9bJaUrJU7
 orA6AUiDoovY6zSTwduqg6EHhKkD33rmAv/b+adbu0g1WoyhMIg2z1GvsAgzynQeR+KO
 xw1XVIh7/t3GrZGH5l+bjFQn+FegmdKmBbUB5gTTDOK1q6cPHJDUpHkcu5jK5r4rpD0p
 R7Z6N/Q1Eo6oBTms7g5Ur4uL2GzJRrtiiG0PD2GkVpT11o4Fuh4RWusNWfySRZWL8uYe
 /SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013202; x=1703618002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zD6GqgpYlUbqN0SJRkAPG9ZDb0+QKHBj7N0uvLGJQI=;
 b=A7iq9QrjddWX4UJox2FkuYuOJ8hdUTkBj5sWmrdADusq2hwJIiuHtZS/2cVIjeRFcr
 raRZlHjn6NZ2ZA9zT96EWiQuyDS2oPSH0zvVVKOzT1YFxP40ACRzq/9Xa2RoqCHxkJqo
 cRVPAu1evGcu/CGY/3w039Vx9X3wEfPcD+sgnvPoafRqxdY8/9OL22rk1wxku3GnBb0j
 xOrTnu8c0434pf0B5CrCaeKR7poTLfLOmFq4Wxh9V02x0MnEuT/gFfZax7wK7uXv+ofA
 7S8fyBauvmdpDgmxppiZoSI2k6VLFDqqaUoMvWiRENInHwB3CtHauzr4c+2099Z71c8O
 ge3A==
X-Gm-Message-State: AOJu0YyHlCDSRuChdzVEryEza9JOXZu4N06KxYDVbUqAcKEBkdE4YNaS
 V4l1G/FnMjmDPO+DXT33MD8TxYY3CcEn8r8zxjY=
X-Google-Smtp-Source: AGHT+IG8w3gd7tr9UxZiRGzz2QmvDhKvvzNYrcgSh1BEoHtXb1p3B9YWLc29xPxKhyd/iSK7qR3r+A==
X-Received: by 2002:adf:e486:0:b0:336:6d7d:71e6 with SMTP id
 i6-20020adfe486000000b003366d7d71e6mr1473502wrm.58.1703013202130; 
 Tue, 19 Dec 2023 11:13:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] target/arm/kvm: Have kvm_arm_pvtime_init take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:52 +0000
Message-Id: <20231219191307.2895919-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Message-id: 20231123183518.64569-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 6 +++---
 hw/arm/virt.c        | 5 +++--
 target/arm/kvm.c     | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index d6d999b1ff8..4404ffeb1e3 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -205,12 +205,12 @@ void kvm_arm_pmu_init(CPUState *cs);
 
 /**
  * kvm_arm_pvtime_init:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @ipa: Per-vcpu guest physical base address of the pvtime structures
  *
  * Initializes PVTIME for the VCPU, setting the PVTIME IPA to @ipa.
  */
-void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
+void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
@@ -268,7 +268,7 @@ static inline void kvm_arm_pmu_init(CPUState *cs)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+static inline void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 {
     g_assert_not_reached();
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018a..b6efe9da4dd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2003,8 +2003,9 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
                 kvm_arm_pmu_init(cpu);
             }
             if (steal_time) {
-                kvm_arm_pvtime_init(cpu, pvtime_reg_base +
-                                         cpu->cpu_index * PVTIME_SIZE_PER_CPU);
+                kvm_arm_pvtime_init(ARM_CPU(cpu), pvtime_reg_base
+                                                  + cpu->cpu_index
+                                                    * PVTIME_SIZE_PER_CPU);
             }
         }
     } else {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e6423d2720b..dbaebe9cd2c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1742,7 +1742,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
-void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PVTIME_CTRL,
@@ -1750,10 +1750,10 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
         .addr = (uint64_t)&ipa,
     };
 
-    if (ARM_CPU(cs)->kvm_steal_time == ON_OFF_AUTO_OFF) {
+    if (cpu->kvm_steal_time == ON_OFF_AUTO_OFF) {
         return;
     }
-    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PVTIME IPA")) {
+    if (!kvm_arm_set_device_attr(cpu, &attr, "PVTIME IPA")) {
         error_report("failed to init PVTIME IPA");
         abort();
     }
-- 
2.34.1


