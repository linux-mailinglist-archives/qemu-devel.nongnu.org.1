Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D37D81906F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXN-0002FE-At; Tue, 19 Dec 2023 14:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX4-0001zY-2d
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:34 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWx-0001sA-EU
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:30 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33678aeda3fso62945f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013206; x=1703618006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mV1FstJ24t/zgC1MccTigP3pcwPlKu6JPGqh4aMLl+Y=;
 b=HSBpxcnkmyTbOdmUQln6188XXPSyqQ+CHpalRvB+U6gLMcQLDapAe1c+msanSmVXT5
 kdyJcciSkwfJ/IPop4CQC53QwP85SjXbIpsIWbEq0DPRHfxapT6PJJghFxTOsg332iKK
 i/7O0ResTrXdJVDfP0RpsPZKd7GWETOQXDu1GvuM+hf1z7SyCXzZ7GWqkboVdnFvAQDb
 1hKN5bealGE27DKrzw08wQ54JSlSbXzmf+ctMhB1yJF6ZpGf7dABpqqrYO1pjGQtZhU5
 qEzHuAuI93ft5pFoi7Uyd4ieY91kJIp/JT1+2SH7jP5478s1ql53j6pEcUMPg+6P0yAT
 8IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013206; x=1703618006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mV1FstJ24t/zgC1MccTigP3pcwPlKu6JPGqh4aMLl+Y=;
 b=SoYFlBiapuSRjLEBq9TdsA4aWfodG6nbo9S9abzIVl36Vs0cyy/+KwAUcVantXqYDQ
 G4PYnlUZTqD7aJghxKuwrUG66LKwGDlLiYmI47fkVyq61Yhtvr6HPg/wUfk8Okf/KILI
 TakCDUGoTSscxr8J9wxBq95O2D/zkKh/3mU5CaDdxdoq6HNIOZLzTOJHmcsriE5j/YqH
 l9FPBnKDaqyVXrb9+CaMZvX+jNjcMNRiaEO1F1StJui6FuLVQJXUht4EuQYl1uWNH3d7
 p4fPths/ClfHu3hnK7MHmQBdt5hRJ7/C6RNhACpHYtFg8SwaTKFyxKIQaixUjbDhZatK
 afpQ==
X-Gm-Message-State: AOJu0Yzk6nx92NeeqnBghBH9kJwM8mUqLC5HbVwUNoyjU8iWaYVyWKnV
 f2e4AchunDRcT0+UOYXdCSHbzxNFZbdiMdzgrDs=
X-Google-Smtp-Source: AGHT+IHmb9G6NaboR28VNtAHRvWPXbu14TTMDuSKBtU0p/rPdlmE+mulVpSab+9yqGSGYTSgijAWNw==
X-Received: by 2002:a5d:6641:0:b0:336:5be9:adfd with SMTP id
 f1-20020a5d6641000000b003365be9adfdmr3515616wrw.68.1703013206162; 
 Tue, 19 Dec 2023 11:13:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] target/arm/kvm: Have kvm_arm_handle_dabt_nisv take a
 ARMCPU argument
Date: Tue, 19 Dec 2023 19:12:59 +0000
Message-Id: <20231219191307.2895919-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
Message-id: 20231123183518.64569-15-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index e4cd21caefc..075487e62f1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1302,17 +1302,16 @@ static void kvm_arm_vm_state_change(void *opaque, bool running, RunState state)
 
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
@@ -1328,7 +1327,7 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
          */
         events.exception.ext_dabt_pending = 1;
         /* KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS */
-        if (!kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events)) {
+        if (!kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events)) {
             env->ext_dabt_raised = 1;
             return 0;
         }
@@ -1420,6 +1419,7 @@ static bool kvm_arm_handle_debug(CPUState *cs,
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
     int ret = 0;
 
     switch (run->exit_reason) {
@@ -1430,7 +1430,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         break;
     case KVM_EXIT_ARM_NISV:
         /* External DABT with no valid iss to decode */
-        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+        ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
     default:
-- 
2.34.1


