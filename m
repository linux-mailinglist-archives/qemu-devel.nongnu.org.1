Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A137F6663
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:37:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZB-0002go-RT; Thu, 23 Nov 2023 13:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZ9-0002ST-JU
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:43 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZ6-0004Ut-0S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso8916215e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764598; x=1701369398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9UsbPHxQcdfZLTnOccu24vjYBcOtxtHjR4chUoHDsY=;
 b=SQ+AZFNPQ1n7W/NNNVfEuUAP6huWtqxvSGezFArwucJ2kr9Xe+nWWZVyQmGr7Xviaj
 zA96j2h5v3sTRLz00gKY8u3nC1F5tXiEeB9CN4C1LW98yspeQW9xvLIpO6ypF/5XXsBc
 9zbKlUX8RHoyW8+0OaXy2rfxJe1hTcOUF0fgcbI3d/RMu3ueOCVHIwUlzdNHpXdXGhvM
 KIZDMxb7guclLsOVRPvuk8pmdIKtAP4i6+UcDiL2bhYnqzTfR3nt39GbwvflWoMkqEtQ
 b1d03YX60ifznvU7fTr4G2s2nypgalqJaCsp2QJf8gbrfxVtF3QuC9PZluaSy4nMfOag
 JqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764598; x=1701369398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9UsbPHxQcdfZLTnOccu24vjYBcOtxtHjR4chUoHDsY=;
 b=H6Fe2FoFDzqTZMkcceB5fAwV7smxfpfVXXPPM6SizVKfT9Lzz2uPCi27SD1Une5wLE
 hJPz7VbPZ6NhF8vhvstr6GJ+1Pbni/5Okfmsm+2EnTfmjYSGyuICUkKt6QDXIMHhUW2D
 ijdrqY5a4+tdkfSy/iUlWQxA/vXq7LtGmJMlp08TfPIeZZbXEMhJZUvJzx7zGboUqn/q
 dcSGJPmQaP5F/6EoeVHzbI1T5toBhcOHvALXQf7yQ2LN56Fx8kp7MyrNoLS71yR8i7Q6
 /H8e1rKDMiBQGYZX9KudvkK06fIigTnzb5OL3kENlPdGyYM/D7i6i+Ik9MQMy5vgJfVS
 QiHg==
X-Gm-Message-State: AOJu0YwQQ/tb/RerBE9UJw7tudvOIR0HtTb+rE8r0apvqUvrw2+igP5z
 8Wbim3HeOwhNstLy4e7zYAItoE1GNkYQ00IZXss=
X-Google-Smtp-Source: AGHT+IEJ2lh8WurQcqnItjOupFjCOAnMT36WCiJMaD5yOR1INcukHMgwcm3UIh/Q5/8UZwJUKg3ttA==
X-Received: by 2002:a05:600c:3110:b0:3f5:fff8:d4f3 with SMTP id
 g16-20020a05600c311000b003f5fff8d4f3mr326179wmo.7.1700764598088; 
 Thu, 23 Nov 2023 10:36:38 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c4f9000b0040b38292253sm1316405wmq.30.2023.11.23.10.36.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 14/16] target/arm/kvm: Have kvm_arm_handle_dabt_nisv
 take a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:15 +0100
Message-ID: <20231123183518.64569-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 91773c767b..9f58a08710 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1304,17 +1304,16 @@ static void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
 
 /**
  * kvm_arm_handle_dabt_nisv:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @esr_iss: ISS encoding (limited) for the exception from Data Abort
  *           ISV bit set to '0b0' -> no valid instruction syndrome
  * @fault_ipa: faulting address for the synchronous data abort
  *
  * Returns: 0 if the exception has been handled, < 0 otherwise
  */
-static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+static int kvm_arm_handle_dabt_nisv(ARMCPU *cpu, uint64_t esr_iss,
                                     uint64_t fault_ipa)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     /*
      * Request KVM to inject the external data abort into the guest
@@ -1330,7 +1329,7 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
          */
         events.exception.ext_dabt_pending = 1;
         /* KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS */
-        if (!kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events)) {
+        if (!kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events)) {
             env->ext_dabt_raised = 1;
             return 0;
         }
@@ -1422,6 +1421,7 @@ static bool kvm_arm_handle_debug(CPUState *cs,
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
     int ret = 0;
 
     switch (run->exit_reason) {
@@ -1432,7 +1432,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
     case KVM_EXIT_ARM_NISV:
         /* External DABT with no valid iss to decode */
-        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+        ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
     default:
-- 
2.41.0


