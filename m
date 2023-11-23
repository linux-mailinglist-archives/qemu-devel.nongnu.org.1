Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4247F6656
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYb-0000Qk-PG; Thu, 23 Nov 2023 13:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYZ-0000Di-0H
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:07 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYV-0003Zy-46
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:06 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507c5249d55so1658087e87.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764560; x=1701369360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znNmY7edfJI2fYiqN/HJeKsLDF9NhHOuefv0PghAu5M=;
 b=aISRMIb3EXzCHdPYMMYXbXEVzJ4HUSKW/jyB8jDC6rp4ICdohW0swYrkfEgS1PA5aV
 JqEeIviLVD/49XqfDYtI+zBe06+4v87JWwttOVMOi2IPqgXzL/oY7QtDMwoEAzyU8uXO
 3WFVE6a+95R3qU/dzpUSL8rAqOgUhadD7CeLA1Y3MAPhxcakDj1UgCh/O6+9rr4QIjE5
 U7VFtyKO+n/QHzFMtMzDkdR75LZPNhh40bgWn0RUBoFUmVkzOM8sgEsYVeODAZTD3f3q
 vGgOXd3rTrDHIWigrU3hdMndLMbK27fEEzhgvP420JlVqld9hhT0YV+ZJhzkzBUgXatP
 IBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764560; x=1701369360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znNmY7edfJI2fYiqN/HJeKsLDF9NhHOuefv0PghAu5M=;
 b=UXwDgxlFrlt4VyM1iQTacQvyfZOp2e544MMhoptu/8yujFTbTMKiWfExTwFiwN2sn4
 URsdkf1sgki9wRLm3Du2+zrFXxLmHkxmwoDQkuJBQglWEAQxI/kPON4VEf1pE2taisLU
 y+DFhvHrlJu3GR6pT83oI7GyR3FftwQJjeF35nW1YwQ88uZpG8O4+yGaifeZaebmjcY7
 siX2x3i0QcI4pQBY7SH6de/KBhBlLVgR7eeL85CvL+d/z8z4kQiM2LkiDQJ7WQHesGqz
 hCG+3F6K+PXP5VLOepy6AiDwzORwoZ29B6v0f5AU1qL7PzAlfnw8ikUOONqH7Yt3I+My
 k9RQ==
X-Gm-Message-State: AOJu0YzJYKw40T4hvPX04MHqMwQcYLPmresDb22u9VLJ+9UJ1sgCR1Ln
 cZxI4La5FgXv2q0Ul4Srvn1zWWV6fDa/UxpXJQY=
X-Google-Smtp-Source: AGHT+IHwNsCUBI8C+HAtmr6ne5j7ja7Y9f5/nmCmQj8iQdnpHgN1KUrN2rXfn6mGSeu6MN85RsnNzQ==
X-Received: by 2002:a05:6512:39c4:b0:509:4655:d8d5 with SMTP id
 k4-20020a05651239c400b005094655d8d5mr92555lfu.11.1700764559795; 
 Thu, 23 Nov 2023 10:35:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b0032196c508e3sm2352293wrz.53.2023.11.23.10.35.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 07/16] target/arm/kvm: Have kvm_arm_pvtime_init take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:08 +0100
Message-ID: <20231123183518.64569-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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
 target/arm/kvm_arm.h | 6 +++---
 hw/arm/virt.c        | 5 +++--
 target/arm/kvm.c     | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 84f87f5ed7..0e12a008ab 100644
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
index be2856c018..b6efe9da4d 100644
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
index 73f4e5a0fa..82c5924ab5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1744,7 +1744,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
-void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 {
     struct kvm_device_attr attr = {
         .group = KVM_ARM_VCPU_PVTIME_CTRL,
@@ -1752,10 +1752,10 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
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
2.41.0


