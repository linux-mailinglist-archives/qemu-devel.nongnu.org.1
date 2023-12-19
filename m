Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B406819083
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXB-00022x-OP; Tue, 19 Dec 2023 14:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWy-0001yG-Hy
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWu-0001re-SU
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso58238635e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013203; x=1703618003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WTa4ndbkRJ7n5XD1OTvmDhz9DP3vcZ/79akTztoRHzs=;
 b=sGbsg/U7pvR9aNO1v4Rh0A0wMYw2MqtTLlTka/yk3/wC2I1aTYTOvHgKnni1tsiJ7M
 PBqbKK6AsmhBv6xub4jJu62Nu7sQ9ubXp/U9mx7DP9MCwGK1/hyrGbKIv5MzQ+A7ac6N
 4c6ya0tXFTJeKF0WNIrKmDBzESzwz71eJr+ZqU5Xjqt64KW1xQib2yWA3QBSg4mFGa+h
 7gccOqvMl6K9mTlaU6lFv03gH+nbvxgSIkan9QLS3sHcxtZxN4wyoQHyGgXnIwrId2GE
 mtJlfsxLS5t9hFlswpD6Ch0oSyUJRNu2USzgWFwILbD1IukwQrRknE7E+hOfPnqYq5A2
 SlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013203; x=1703618003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTa4ndbkRJ7n5XD1OTvmDhz9DP3vcZ/79akTztoRHzs=;
 b=of0/NW8gJGWyKEc5FWb2qaMI9fkEmFolSg0WOKC38tfGP1bcRxzQJkqVRSldRxRG5k
 FE8gSQiiPmYe7OPCvYefi/soVrGnJj98ug8tjtJwkuNVS0EKHf1w8gs6d8daV8R7YhsS
 atnLvqkRQU5W4ECMJK9RC+d7BJDHQhS9PdsFJoxizRaRMpLcIKH99F3WOvho1yehm9UF
 PGrpHXwgc1I3UrBQkcK0qGJbBQebZdBV27vAwH3pG0vRqWYy1mOSTPiThoaUt96pVmoA
 5PzNrXIb+6UkYU+mu+r2gNn+v5kJae9WPTaidNxENd+M0LynmdIAxQyhPsmwM5uGpVLb
 h24Q==
X-Gm-Message-State: AOJu0YyaGw9UqdIef0IsZUlvHLGMhEi8MOkxr7OQmwQBIpgqi8PGrURG
 JQE6/kWZLBQxC961MeCm5+NzCu2qpipa9eKP+SI=
X-Google-Smtp-Source: AGHT+IG3jkrLOBKv6FCgqWGtd5k5HaiMPcVFx7t/M42lS6WakImqEMo3vUWYya+NO/rmB4k8h6NtNw==
X-Received: by 2002:a05:600c:2296:b0:40c:3103:2ecb with SMTP id
 22-20020a05600c229600b0040c31032ecbmr10220394wmf.43.1703013203534; 
 Tue, 19 Dec 2023 11:13:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/43] target/arm/kvm: Have kvm_arm_vcpu_init take a ARMCPU
 argument
Date: Tue, 19 Dec 2023 19:12:55 +0000
Message-Id: <20231219191307.2895919-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-id: 20231123183518.64569-11-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 45ee491a56b..9540d3cb618 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -62,7 +62,7 @@ static ARMHostCPUFeatures arm_host_cpu_features;
 
 /**
  * kvm_arm_vcpu_init:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Initialize (or reinitialize) the VCPU by invoking the
  * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
@@ -70,15 +70,14 @@ static ARMHostCPUFeatures arm_host_cpu_features;
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_init(CPUState *cs)
+static int kvm_arm_vcpu_init(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     struct kvm_vcpu_init init;
 
     init.target = cpu->kvm_target;
     memcpy(init.features, cpu->kvm_init_features, sizeof(init.features));
 
-    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_INIT, &init);
 }
 
 /**
@@ -982,7 +981,7 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     /* Re-init VCPU so that all registers are set to
      * their respective reset values.
      */
-    ret = kvm_arm_vcpu_init(CPU(cpu));
+    ret = kvm_arm_vcpu_init(cpu);
     if (ret < 0) {
         fprintf(stderr, "kvm_arm_vcpu_init failed: %s\n", strerror(-ret));
         abort();
@@ -1912,7 +1911,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /* Do KVM_ARM_VCPU_INIT ioctl */
-    ret = kvm_arm_vcpu_init(cs);
+    ret = kvm_arm_vcpu_init(cpu);
     if (ret) {
         return ret;
     }
-- 
2.34.1


