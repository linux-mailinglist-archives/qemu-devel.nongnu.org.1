Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E597F665C
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYh-0000o5-31; Thu, 23 Nov 2023 13:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYb-0000Sq-5c
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:09 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYZ-0003kT-1w
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b399f0b6fso471235e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764565; x=1701369365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJjfIOalwsvZmq2fy7v7JKs3hNC/WaTRJ81yhz4vDXw=;
 b=Prpr/+535ghApSNq6W8KTKA8AW/mEtDE94INo/NEkasATn8LW8OtPuvCVJLSYFfqty
 XKMQmIOoTrZw89y38yO8f4Pz+FB8Yyr5fIYlBJxlAw4inDw7N5S4h0nA0kZzr9iO7t7N
 2FBLXtAlV6nNga9hojKjdgHL8Thg7XBd7rYkaPyYlRr+Nr+YzeQBHHGskLYPn7b1UKp9
 89UvOZrQTYhQ65TrBmpn4J72zrSyk9e9MbS6LvVyvEJXd7T0Wr5LHi5XGoaamiJoXNMv
 c/xB99hxaeVHKPJP2VHeyxFtJ37pJhhIIspMlIA+JwO3gvBYsEi6gh40BoaX/zW4Iw+H
 DKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764565; x=1701369365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJjfIOalwsvZmq2fy7v7JKs3hNC/WaTRJ81yhz4vDXw=;
 b=lHqxpg/sQdgSUKdm9KlvD+l10liogfqrqHNGH6/wSkFOpQPukndbTde68xMDbwI33t
 3KqTKSrg9mIYfdhfSXDsLS27G5RI2wc/gSgyyZUhW5vU4K7YhmOLLjx9nsac7oQaTcP2
 0GeQd49F+e0j/aKqCcPfJXECyq/CKK+VNUO+A48T+ZtL3Mb2uws7gN1Zyjurfs0768HB
 LNKfZQoTYiyCheRUPSn0vh1/MmW0Aoc2FR4HueyLXjHzqzuTLqv3ByzmSlZHz3iDy7LG
 8TJNRKNzaEheb3Wo0cSo7/kDOVNHGXf4UJ8GIEXRLTxA63wLV+hqpW+hDBRWIJ9hiDAk
 9e2w==
X-Gm-Message-State: AOJu0YxH+qlXwIMMXopzrPPiWf8H00prqChPZDpQXc8M2xvzPp9SXWHx
 fvIzTtOUq7Gct/93qeOIp5dq+MUidAPhfQV4ESg=
X-Google-Smtp-Source: AGHT+IELE79MyLBbOsT4/Sz7U570tGHdhzEvWk2p61WIGplYDA6HA/ukUNXBzijqXiExJ/9+xOAMnQ==
X-Received: by 2002:a05:600c:1c12:b0:407:612b:91fb with SMTP id
 j18-20020a05600c1c1200b00407612b91fbmr290352wms.30.1700764565221; 
 Thu, 23 Nov 2023 10:36:05 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c19cb00b0040a507f546fsm3526409wmq.8.2023.11.23.10.36.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 08/16] target/arm/kvm: Have kvm_arm_pmu_init take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:09 +0100
Message-ID: <20231123183518.64569-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
index 0e12a008ab..fde1c45609 100644
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
index b6efe9da4d..63f3c0b750 100644
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
index 82c5924ab5..e7cbe1ff05 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1711,17 +1711,17 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
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
2.41.0


