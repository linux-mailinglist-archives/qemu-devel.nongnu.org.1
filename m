Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263D81909C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXM-00025s-DD; Tue, 19 Dec 2023 14:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWz-0001yR-D4
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWv-0001rW-AD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:29 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33666fb9318so2874799f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013203; x=1703618003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oMXiDjXN47Sje7EpZy9Ne96GwzFBEmIGwHarjbgxxck=;
 b=fYUZ6NC8iiTKbEWfR8FYbLyK/jzP1PqHOIXwqOc5Td0EKx8Z1Kws8cqeAU4cpZ1Cgz
 at3LFqko+lkIrRHTo4HxAdHzQmQpoBn5lObChBmku0XlI+NzUuxD+lto9bPrNRWiLl2Y
 7SJlQyL4oBs8lL15Q1V1TMAPj7ZD14RgD8U4UYtRSsZwis1xNdqLkGDEv0go2ZHyySN1
 /9rRy6gozORQIFK1NPiGvKfL0C8rE0Tql9QQJ4NW5I+k5g3pRYAkXX1zVbD2DFV3f+gK
 97NPQwtqzEuhV+XDlzHeJcLRjDzuOilA9Gyg+eSa8YqNAXGNEfm4Je7f0dgmq5kwAfGW
 +k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013203; x=1703618003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMXiDjXN47Sje7EpZy9Ne96GwzFBEmIGwHarjbgxxck=;
 b=rwaWtuKcMXW3HVDuKP9WcSeHWF5pNt3zRrYPL0IQhN1X76iRR5Az+KqP1FEZprVpX3
 /WRyt+vgaXLgICPA1Ot6Gal8oDC1W+d6JGa2g43Jw+c7gWv9tzYNSDia2TShfscu0/GE
 zPylknYDFw7CFOYmRPSZRKKuP9YBA9kvuKCUVXT1r4GP07CHmbgR3xOhdwTROtpKOGZf
 p+KyT303CUZl2DbaHqbQWjNb4J+cx7ZEyLk4ppoxK4zGnUXaID6qQ6R2mBJXK/KGJn0i
 sW+fETkr9wQcByYlQQbConOai3RQpCeEx1HApWjommJRQWMDzxaL+rQDeZh+ftiD1Yzu
 ZGwA==
X-Gm-Message-State: AOJu0YwZcNGdDwGeoplPpE0MS0c+24OTQl6nDB/HyZK6umdfP1Pxoppn
 1qSUuIBC9bI5u6WyJN6ZwOV82osvrJNBH91Hvj8=
X-Google-Smtp-Source: AGHT+IEmwcMJnKXaFoFSp7Pcz4h5MMF37zFYzqVnnkKAg1itCVT+HYdhm2dhGQ5dMQFMAZaebMLLXA==
X-Received: by 2002:a5d:6088:0:b0:336:7474:61a6 with SMTP id
 w8-20020a5d6088000000b00336747461a6mr771970wrt.64.1703013202975; 
 Tue, 19 Dec 2023 11:13:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] target/arm/kvm: Have kvm_arm_pmu_set_irq take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:54 +0000
Message-Id: <20231219191307.2895919-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-id: 20231123183518.64569-10-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 4 ++--
 hw/arm/virt.c        | 2 +-
 target/arm/kvm.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 0a79545aa12..cfaa0d9bc71 100644
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
index 63f3c0b7502..040ca2d7948 100644
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
index 1e52077a9ce..45ee491a56b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1725,7 +1725,7 @@ void kvm_arm_pmu_init(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
+void kvm_arm_pmu_set_irq(ARMCPU *cpu, int irq)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
@@ -1733,10 +1733,10 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
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
2.34.1


