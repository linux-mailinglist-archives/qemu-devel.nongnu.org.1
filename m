Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 673457F6657
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYj-00015p-9a; Thu, 23 Nov 2023 13:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYg-0000t8-5p
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:14 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYe-0003sA-Fn
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:13 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332ce50450dso741804f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764570; x=1701369370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSjIUExNNTZZyxxju0j+hfpNF1ayVJnEfjEBE24u3Js=;
 b=ipoqtP5ygKqADHCz6TCmOWMiWZ1tApjhbS6zxF2O4AH+eI2jWxSleWpFdJr/TW1tdc
 NkVz6UNwV1gVuCWpoAPyhwzsA605RCdeI5h8/dttswixltb7JoE8vYk/l+c0C9fEMtqh
 u9Rh5/DX6+W2Kfvf+AZrdx/rNrVevusHji4UCUu1yj0K874kc3STE1bEsj85xnArjVuf
 U8Ej8WXvaPQcfn0ETLWD7NVzXi8WpwN/7NcrF9xDB9Bbs3ZA5fOe2mXzDorkB+I/dnUr
 5vt+Hniffzy0+qAeAKvht0ZjDLov3HIwXVlvGHDLICmVFa4BdoUCicRMkhZFQqwXiPhO
 5LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764570; x=1701369370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSjIUExNNTZZyxxju0j+hfpNF1ayVJnEfjEBE24u3Js=;
 b=lmHsLKi0h7pgKnNjPTjoU4Z0CiLYXhnNB944LIzFtM3JvkjKkAd2zrd6LW//Zb++eI
 rWLxXyg3t4vJC2zngTd2Av6mrgKleR2lqJ9nuZKZWPQtNDHQxr1j0gJAKRZprahhBeBx
 yLYR4oMpcL84ZnfYb4dSm2u0mDdO4Eena8YFKTAVe3femYW/u1Hh+M1tdTV97VWn2PwX
 2e4RfvfG1nN/DjkxMtSEYAQOC4FA3sQXdhmPj90QSxwep24nCW2FyNPJrrLvI+a9KiBF
 usL9vsmtuvgfKmaU/YFlGWz/ISnPsq+8TZgabLX5sZ9bmcLQkoWFgOkJKRdm5I+G1Hry
 vxNQ==
X-Gm-Message-State: AOJu0Ywce9JoxMaYngOP5y4bOwxd/IVqG4c1LQK76tdFbiknqVgOrem9
 hS8hQgPvomw86GezdsAnJ72AOUAtiqsQlImzaTU=
X-Google-Smtp-Source: AGHT+IFgzxS1rMr+4vJyVHw8yTL7+XlGZ+6k9Z3h/Y0p6Y8WoWsGCe6GudKC213LdZDrUfDjX2soLA==
X-Received: by 2002:a5d:6152:0:b0:332:e75e:f39a with SMTP id
 y18-20020a5d6152000000b00332e75ef39amr228741wrt.35.1700764570576; 
 Thu, 23 Nov 2023 10:36:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d67c8000000b00332e84210c2sm259285wrw.88.2023.11.23.10.36.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 09/16] target/arm/kvm: Have kvm_arm_pmu_set_irq take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:10 +0100
Message-ID: <20231123183518.64569-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 hw/arm/virt.c        | 2 +-
 target/arm/kvm.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index fde1c45609..55fcc35ed7 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -201,7 +201,7 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
 int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_init(ARMCPU *cpu);
-void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
+void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq);
 
 /**
  * kvm_arm_pvtime_init:
@@ -258,7 +258,7 @@ static inline int kvm_arm_vgic_probe(void)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+static inline void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
 {
     g_assert_not_reached();
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 63f3c0b750..040ca2d794 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1998,7 +1998,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
             if (pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
                 if (kvm_irqchip_in_kernel()) {
-                    kvm_arm_pmu_set_irq(cpu, VIRTUAL_PMU_IRQ);
+                    kvm_arm_pmu_set_irq(ARM_CPU(cpu), VIRTUAL_PMU_IRQ);
                 }
                 kvm_arm_pmu_init(ARM_CPU(cpu));
             }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e7cbe1ff05..f17e706e48 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1727,7 +1727,7 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
@@ -1735,10 +1735,10 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
         .attr = KVM_ARM_VCPU_PMU_V3_IRQ,
     };
 
-    if (!ARM_CPU(cs)->has_pmu) {
+    if (!cpu->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
-- 
2.41.0


