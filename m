Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7B7F6676
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZ1-0001mX-2K; Thu, 23 Nov 2023 13:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYy-0001ls-1B
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:32 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYv-0004As-CW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:30 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso645334f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764587; x=1701369387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFeYHB+Hwgz28c/uPKH/ogtnPZczZab/kLjBCnJSUvs=;
 b=QtSQwl5xPrMQc4Swr3wxWer0KY7f2I2T/l0tD9Jc3Euolo+15/E+O2l8JqfAHB9ij6
 fmPuw7Sp3cJRHHTdG0rcOLuX1DW7spaQB1Lxpml/XxXlk8lt0SZcNo/ZYwxW47EeVNgh
 7jDBlqP4KpfzDuuwquckpjK2UbWIKrxLCO0Azq02HjyYCxVqMq2FVIUeMLgtdd2UMtaA
 CnSE5EcGOjx3Caq0Jv+pXGQ+h8VawTXbHhdP4nb/LQtGVKxh5hPh+QS6pKwhTLsf+1E2
 XcZkYH0YAhs4jkwQIUxpYS+s4mFluQ+0UQodifaSAu9URQUl1Hm0kqAnENeI47pKcsj1
 +r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764587; x=1701369387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFeYHB+Hwgz28c/uPKH/ogtnPZczZab/kLjBCnJSUvs=;
 b=aZgtmYTRFj55W3KaM12OGFN3/MyeLclqLNghaTtbIlJbITrFQ89R4vaZldXJc+dVkd
 1MkfiZHfbeOf8W1C4y1d6bKu8K2D/DhLmGImkLVB34JACvhBCz+KZgueZgTkTcnZpIEI
 w0JkCm7rLaPxLU3Nybq6qHGImCRBR1easMe+nu5VhP7A2cYyr2VOAhTKi8Ip50PgAnaW
 I4LLqQjhyThmIVuyJdQo51M9Ap53xbMRG0Wg0tuAWpbKbIsBd4JXhan5dayvCE9I5yIy
 7sWJPp8TNKrCN+83ywzcBGu3H90VuGG11SluFFVHUP9p9ucJBstP7rg0b4OtDJCUAGqa
 IEGQ==
X-Gm-Message-State: AOJu0YyApKfa7dyCTXq5KbDTXapMuwbUaETIjHXgYfOw8kHvnt3J9XIm
 k5eWwnz61mKo22DUZxchMP31G/6bWaaU2O1LZtY=
X-Google-Smtp-Source: AGHT+IELxbckK8uZXazOGgHv1fiTUgL1Ik/QjVMUZesvDWJ1t4LowVH54N1HBPUHto+6Kfzb13zJ1g==
X-Received: by 2002:a5d:5690:0:b0:332:e65a:4a07 with SMTP id
 f16-20020a5d5690000000b00332e65a4a07mr231040wrv.32.1700764587343; 
 Thu, 23 Nov 2023 10:36:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 s11-20020adfeccb000000b00332c6c5ce82sm2325696wro.94.2023.11.23.10.36.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 12/16] target/arm/kvm: Have
 kvm_arm_[get|put]_virtual_time take ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:13 +0100
Message-ID: <20231123183518.64569-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 target/arm/kvm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index dba2c9c6a9..57615ef4d1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1036,20 +1036,19 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
 
 /**
  * kvm_arm_get_virtual_time:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Gets the VCPU's virtual counter and stores it in the KVM CPU state.
  */
-static void kvm_arm_get_virtual_time(CPUState *cs)
+static void kvm_arm_get_virtual_time(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     int ret;
 
     if (cpu->kvm_vtime_dirty) {
         return;
     }
 
-    ret = kvm_get_one_reg(cs, KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
+    ret = kvm_get_one_reg(CPU(cpu), KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
     if (ret) {
         error_report("Failed to get KVM_REG_ARM_TIMER_CNT");
         abort();
@@ -1060,20 +1059,19 @@ static void kvm_arm_get_virtual_time(CPUState *cs)
 
 /**
  * kvm_arm_put_virtual_time:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Sets the VCPU's virtual counter to the value stored in the KVM CPU state.
  */
-static void kvm_arm_put_virtual_time(CPUState *cs)
+static void kvm_arm_put_virtual_time(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     int ret;
 
     if (!cpu->kvm_vtime_dirty) {
         return;
     }
 
-    ret = kvm_set_one_reg(cs, KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
+    ret = kvm_set_one_reg(CPU(cpu), KVM_REG_ARM_TIMER_CNT, &cpu->kvm_vtime);
     if (ret) {
         error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
         abort();
@@ -1291,16 +1289,15 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
 static void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
 {
-    CPUState *cs = opaque;
-    ARMCPU *cpu = ARM_CPU(cs);
+    ARMCPU *cpu = opaque;
 
     if (running) {
         if (cpu->kvm_adjvtime) {
-            kvm_arm_put_virtual_time(cs);
+            kvm_arm_put_virtual_time(cpu);
         }
     } else {
         if (cpu->kvm_adjvtime) {
-            kvm_arm_get_virtual_time(cs);
+            kvm_arm_get_virtual_time(cpu);
         }
     }
 }
@@ -1881,7 +1878,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-- 
2.41.0


