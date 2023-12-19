Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A1819085
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX5-00020p-Sp; Tue, 19 Dec 2023 14:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWz-0001yT-Tz
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:33 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWw-0001s0-KK
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so49391895e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013205; x=1703618005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DxeuhpipM3BEPBaMclMGluLt2DuQa6fF5XvciTbwcOc=;
 b=jPP4v1YFt8FfLAPiWsSUpcKCpTCeuZa+i2Pb7sbkqp1HTKtsQF3Jt0THmhoN0FNsai
 ZIcEGJXVHv+4pZ/4VV/A9hgozdaQFBvEVHAV7B5Cl9vCPNNVmLW0ek02riSL0hUKclin
 pXelxT4NE7QCLhWFtcsTafzdMxDUpPy+rXJl460TPF2XE+OKmj+XIFrrvRY0tjnQ1Njc
 xPDcVjwxKkKlIXaEQfXXpfsq4OuF47uQr899WOXEzP4UblNOZeT2Blkn4/SY5kp4zGeZ
 EZ3nNJKRJqkuN9uaOYc9WcLcg4uXevoIIEGCe+qoEvNsYBdRUtCpDnOk8jFcYjI0vNL4
 GAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013205; x=1703618005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxeuhpipM3BEPBaMclMGluLt2DuQa6fF5XvciTbwcOc=;
 b=D02BE4GD0KyNAyr4hzJhIRhU6fL7ozE1N+7kOtDdMPAwsHK6pDRByyY9EWkMIxzc/G
 dqEHKqEyEbt3Q0GmOcYBgbwVN+7xUUlT0zdvbFMqVsWRMbzul4ALyD1CUJZq+JJCVzWK
 6VfhZfSxlVBENVp4aQaoXtpx3B16T1l1dK4L1fGI2mnyDaj3fMDexuhcuSjtNFR6UjcS
 YaVYKddMm7Smg4C0Ly6hb3H3h8qYIhRbts+vdI+IFZOXFMlaPMMXBVfhmY3u3o7Tw1mh
 f8QBxwxJhPnXdhLvpfyWbeBfWkgeul+pC1YE/fPhwlgpM+hZfWen9ezY/TVuMUs8554G
 CNCg==
X-Gm-Message-State: AOJu0YzxGfIpaby5yfRwrzbY+rtEcbrM9MBsL1rUL2TC144K718fUeQ2
 Dn+EV3YsOskFD6rGvJUEnoL3+iS57ZbxaJFWi6U=
X-Google-Smtp-Source: AGHT+IHyRfHk0j75hzvrHN6b2AHyayX2ZXxz2idLKZNf3Gpu3HNa/lGcR0wBhDZ9J91NI0H8jl9j9A==
X-Received: by 2002:a05:600c:b41:b0:40c:2a41:4a35 with SMTP id
 k1-20020a05600c0b4100b0040c2a414a35mr9594728wmr.130.1703013205339; 
 Tue, 19 Dec 2023 11:13:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/43] target/arm/kvm: Have kvm_arm_[get|put]_virtual_time take
 ARMCPU argument
Date: Tue, 19 Dec 2023 19:12:57 +0000
Message-Id: <20231219191307.2895919-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Message-id: 20231123183518.64569-13-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a2370bc5747..5973fbedde1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1034,20 +1034,19 @@ static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
 
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
@@ -1058,20 +1057,19 @@ static void kvm_arm_get_virtual_time(CPUState *cs)
 
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
@@ -1289,16 +1287,15 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 
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
@@ -1879,7 +1876,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-- 
2.34.1


