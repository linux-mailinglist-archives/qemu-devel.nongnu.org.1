Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A27F6662
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:37:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EZ8-0002F3-5e; Thu, 23 Nov 2023 13:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZ5-00026K-M2
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EZ2-0004ML-SY
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f613272so7873875e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764593; x=1701369393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Otvbi712uFgYyup+pTZVJRpTHa74RGjJF86YXo2+tew=;
 b=z6WX0/37kVj4Ytbt5JWMflQ8rjgC/o80znwUT8H2IEr6kE87burufmPJKlJYgbnoqh
 C7D0n6jagVKNGeZV2hPneXxRqrqHjbkl8t+uNVQOGrw+NgFclu+xgSCxRg0vk4OuPQ2M
 US75btifb40rQAzensdIL2ojviXQjEhgffS6WNqjNbhtW48gXi6gV74FRTwboSHh/0iY
 4d+F4I/CCaWkrdf9BTdL20cR7ZR1axvKoNAB05yUb2mBsCOJjfJZiZn09ct5z6nMh6Fx
 qaQRLTmtsFLIi9A88gV5Vy6ezFpoWdn1xv42rNyI7wvgaeziq/qy55rL+wj+64gVb6cA
 HAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764593; x=1701369393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Otvbi712uFgYyup+pTZVJRpTHa74RGjJF86YXo2+tew=;
 b=AshJVk8L77CjECyqz9xZ98cGqzNRpdjAbflSNQLQfLxNPVbDujAOTsExpLmQnVfX1u
 X0Y81N03VU5s4pVElNnSkl32iE965q35+6jYl33F21UI+sd4aetrGvqCLnnbFU0h1K2Q
 +Is9SBnHrvUCZcZzPBahETeaYd7DAckxekEh78zuKGEuySRrB7dLN6vWW3KRZQDFSiqT
 /Cvg1QU2RS8AG6TFRsaNMtig3g+2sB0YaTC7wFq2GYt98F7Gb23cd8JGfevCx7eZEU8F
 sjQak/U4cQmvcr54/6d1NHNNlQ2MFDKrH2qWWD5GWkNAuzPPZnbzIOmc6ddyD2AMxGe2
 b/Gw==
X-Gm-Message-State: AOJu0YzQkEVsvEFGYjBjjGDHIIf7K9RKYwpG6DrPjXwHLaZ+KWCzuZHy
 tvB8nMYt/EOPbwcOQ38KfjZzGlyvI+yST0XP2t8=
X-Google-Smtp-Source: AGHT+IEUBNzl5yBDCfKyFqc+ys+ZzNDGN5X1VuZj0wqdqnY4mEGUORfFfHklyOF+YrYSPYd7f1KZag==
X-Received: by 2002:a05:600c:1ca6:b0:40b:2a69:6c1d with SMTP id
 k38-20020a05600c1ca600b0040b2a696c1dmr367611wms.4.1700764592790; 
 Thu, 23 Nov 2023 10:36:32 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b003143867d2ebsm2344690wrz.63.2023.11.23.10.36.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 13/16] target/arm/kvm: Have
 kvm_arm_verify_ext_dabt_pending take a ARMCPU arg
Date: Thu, 23 Nov 2023 19:35:14 +0100
Message-ID: <20231123183518.64569-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 57615ef4d1..91773c767b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1172,18 +1172,18 @@ static int kvm_get_vcpu_events(ARMCPU *cpu)
 
 /**
  * kvm_arm_verify_ext_dabt_pending:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Verify the fault status code wrt the Ext DABT injection
  *
  * Returns: true if the fault status code is as expected, false otherwise
  */
-static bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+static bool kvm_arm_verify_ext_dabt_pending(ARMCPU *cpu)
 {
+    CPUState *cs = CPU(cpu);
     uint64_t dfsr_val;
 
     if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
-        ARMCPU *cpu = ARM_CPU(cs);
         CPUARMState *env = &cpu->env;
         int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
         int lpae = 0;
@@ -1220,7 +1220,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
          * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
          */
         if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
-            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
+            unlikely(!kvm_arm_verify_ext_dabt_pending(cpu))) {
 
             error_report("Data abort exception with no valid ISS generated by "
                    "guest memory access. KVM unable to emulate faulting "
-- 
2.41.0


