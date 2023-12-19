Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FB819082
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWy-0001x1-4l; Tue, 19 Dec 2023 14:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWu-0001v4-Qm
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWr-0001p6-Vz
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:23 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so12475e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013200; x=1703618000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f99Ujt99QMeF21Uqr8srLUFwBNPf96V7ucD7nm9URUA=;
 b=ctw0gsEQz/OI5OUdhqO1VphTQJJMqSdtXqksgTZgr+hGT+APbZMxjrJ9mAHc1BpHfu
 q3mACZiO0Va5bpmejspEobAL2pwwmSQNCgBGQTsq6RIEUFS9CuW+8qv6wCalAu3yJNGu
 eHxliVE8qK0YX520emnjKpjDbsKPv9jX3kxQj4wkREPX2W2A5FFubdt0VMRPtwqk5FF9
 bCIB2pcmnwxpfCGR3akZgnkHyPnE3Ct9DqX6IiSbMmUqal76Dup6u8v4uKXVeN4AzRk2
 yv/IS8g51CIY3yDIxB9zVETtmT2fbGDbU3yysT/qmljlEir9SURUw8NId5rIPCP33+LJ
 ofeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013200; x=1703618000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f99Ujt99QMeF21Uqr8srLUFwBNPf96V7ucD7nm9URUA=;
 b=YfZI4WD4kecYRoiiNICzvr/s1y/VzUzxlIa48dasdj3st1JnjCoRYGjVeJ5w5UaANV
 hn70UuvVdQl6B109PKdvACccgUoWO1n/Yg1V5u8hqvDw2/IkdrrwqTIF/9cnUo0LDJ5N
 CKQmXL36dYtuJkCuLSNFJUMCg5hIwffyZZUPGQohvTHEXC9O1L/Zu10bfaQrFmv2AVZR
 Qc/23OTKWxokexpmVnkdJ3AwsVRh6oWFuelrmymvSaT8IzTEL6TOdhK22X4zkSTaVi7a
 7umwIyr//CBwAPNTAbDeholoTYhwi0CmriLwnxqo+1ErnQMt1310egn6psXaHXW3OSuW
 Vg8w==
X-Gm-Message-State: AOJu0YwIyut0N5lv23/r7ctP1tKvTL0fbqsQAym2OAlj9OZP5YVWukhw
 AI2xY0XuhClxD0e6y230ixG4rmJS0XRnDLJXWPw=
X-Google-Smtp-Source: AGHT+IGYaWU+Qj249BaoGoqAB+pMVY9hc/TRy1G5PWWcpTNkl4OwyxkDfY4vtkQyXdYyE+NBJahNjw==
X-Received: by 2002:a05:600c:43c4:b0:40c:5822:133a with SMTP id
 f4-20020a05600c43c400b0040c5822133amr848826wmn.69.1703013200396; 
 Tue, 19 Dec 2023 11:13:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/43] target/arm/kvm: Have kvm_arm_add_vcpu_properties take a
 ARMCPU argument
Date: Tue, 19 Dec 2023 19:12:48 +0000
Message-Id: <20231219191307.2895919-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Message-id: 20231123183518.64569-4-philmd@linaro.org
[PMM: fix parameter name in doc comment too]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 6 +++---
 target/arm/cpu.c     | 2 +-
 target/arm/kvm.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 50967f4ae9c..3abbef02601 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -148,12 +148,12 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 /**
  * kvm_arm_add_vcpu_properties:
- * @obj: The CPU object to add the properties to
+ * @cpu: The CPU object to add the properties to
  *
  * Add all KVM specific CPU properties to the CPU object. These
  * are the CPU properties with "kvm-" prefixed names.
  */
-void kvm_arm_add_vcpu_properties(Object *obj);
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
 
 /**
  * kvm_arm_steal_time_finalize:
@@ -243,7 +243,7 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
-static inline void kvm_arm_add_vcpu_properties(Object *obj)
+static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index efb22a87f9e..650e09b29c5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1686,7 +1686,7 @@ void arm_cpu_post_init(Object *obj)
     }
 
     if (kvm_enabled()) {
-        kvm_arm_add_vcpu_properties(obj);
+        kvm_arm_add_vcpu_properties(cpu);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 41fffef5ef1..e5a2596890b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -497,10 +497,10 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
 }
 
 /* KVM VCPU properties should be prefixed with "kvm-". */
-void kvm_arm_add_vcpu_properties(Object *obj)
+void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(obj);
     CPUARMState *env = &cpu->env;
+    Object *obj = OBJECT(cpu);
 
     if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
         cpu->kvm_adjvtime = true;
-- 
2.34.1


