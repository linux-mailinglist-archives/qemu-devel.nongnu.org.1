Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D8819087
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXF-00023u-Jt; Tue, 19 Dec 2023 14:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWx-0001wC-0B
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:27 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWu-0001rI-EW
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c6e2a47f6so51018965e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013202; x=1703618002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYhSIE/aRJaOrscSujAdKlBizLG69eYQKoHwvZcrqCs=;
 b=mfoFwr0yKc4vJH/kxxAylKH5uXOFga41U5k9nRWbzzoMkAHGWmEN3IhuApU7DMDfuI
 OvqSNKF4eIim5/ctz4ZiQhF9VkHKGhUyPb/spG7/ljfwRfRy6VlJVrUUfjfCdjVl2P71
 S+hZCJD2eqRY6n9uz372x+99XiUeQPpR5Qa8+h+n/y1PNXPO3NhCAq/6EGj9ITVBJT6B
 Hs4CBDDVGAUT5h0t5Em/0lr8RsdYlXoq6P0DxVKGz6KK8OvqM1kCmvvCLt1sAk1j+swj
 h/cbWW5MFNp4HByl6jKsTYlssIImGwQDXhdKJ374lm4xhdkvIs57MKUk7OMV7dF63oJ4
 h0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013202; x=1703618002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IYhSIE/aRJaOrscSujAdKlBizLG69eYQKoHwvZcrqCs=;
 b=NUhhBGwQcLbfPitelCe2GvTKUUsJzFko10sOO1gjsbIRBf2zvn3+g5JBJ95h/wfE5N
 RGOZ55uJF2R+KyRkK/z/gfjdX98LAUCdicSBFUuSd/JFvlfESHYP2SaJHHXyADjeOUMu
 Qp1tca5OjIdAy66uRPUxXyyXQmTJUwDBBoL2rpZVcLva1t4trE6zkcM2EbF8gszCZEai
 rHHbXuj5dSSs30vlQuyxZw06vrbNoHVS06TpOEnh4Uwwsi83eE5AWmozt5muScyKLVd2
 Ev1DQRmvPCrv5/cJccm2EZqBWaEs6D1W0JpoeXOjCVCPUnJq+zFgn0TrD3g1EDQlqwKQ
 TE6g==
X-Gm-Message-State: AOJu0YxMCkNoAdFeW1KLpPrhnENbY6i3ZH81CcLQl54/vGRHtKYbHws1
 ydjs+qNbyzQlbb8Zq/IqzZWF26uzRnrb9vE5u/Y=
X-Google-Smtp-Source: AGHT+IEmOmIAnf8rT1bkPC1LXegU30xTzo3molon8+CoWi1x6Vm0aOZMJQopL9PkLmW4b4dpdVgoRg==
X-Received: by 2002:a05:600c:1f8b:b0:40c:601c:fc6 with SMTP id
 je11-20020a05600c1f8b00b0040c601c0fc6mr3208839wmb.245.1703013202544; 
 Tue, 19 Dec 2023 11:13:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/43] target/arm/kvm: Have kvm_arm_pmu_init take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:53 +0000
Message-Id: <20231219191307.2895919-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-id: 20231123183518.64569-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 4 ++--
 hw/arm/virt.c        | 2 +-
 target/arm/kvm.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 4404ffeb1e3..0a79545aa12 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,8 +200,8 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
 
 int kvm_arm_vgic_probe(void);
 
+void kvm_arm_pmu_init(ARMCPU *cpu);
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
-void kvm_arm_pmu_init(CPUState *cs);
 
 /**
  * kvm_arm_pvtime_init:
@@ -263,7 +263,7 @@ static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_pmu_init(CPUState *cs)
+static inline void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b6efe9da4dd..63f3c0b7502 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2000,7 +2000,7 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
                 if (kvm_irqchip_in_kernel()) {
                     kvm_arm_pmu_set_irq(cpu, VIRTUAL_PMU_IRQ);
                 }
-                kvm_arm_pmu_init(cpu);
+                kvm_arm_pmu_init(ARM_CPU(cpu));
             }
             if (steal_time) {
                 kvm_arm_pvtime_init(ARM_CPU(cpu), pvtime_reg_base
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index dbaebe9cd2c..1e52077a9ce 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1709,17 +1709,17 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
     return true;
 }
 
-void kvm_arm_pmu_init(CPUState *cs)
+void kvm_arm_pmu_init(ARMCPU *cpu)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PMU_V3_CTRL,
         .attr = KVM_ARM_VCPU_PMU_V3_INIT,
     };
 
-    if (!ARM_CPU(cs)->has_pmu) {
+    if (!cpu->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(cpu, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
-- 
2.34.1


