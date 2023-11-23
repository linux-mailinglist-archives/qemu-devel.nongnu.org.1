Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF737F6671
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:39:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYH-0008E6-G1; Thu, 23 Nov 2023 13:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYG-0008Dp-06
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYD-00038Q-6T
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b399a6529so437185e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764543; x=1701369343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UF32mbiOniogqxmnEO/G/4hA+3MFqbkOICeJQxcwIQ=;
 b=Vnn7iKeZrXS1iwb59lu64o7mg1AY1LIi/CBkCgOReeR5D2fYm/DgRKgmiXlB0jCJq2
 G/6O+KZbRqpc8mFunZOYjTLppQ5et7pdO4RYGGj70HyHqvMlUVLhwU3vOEYza4ihtcB8
 FrxLpuEuJXuNYZZTaGmB4hlonyFO3HBOUT8hrXYkDi1ol49HtZmoSG0Oo5mlw3CO6EKZ
 keBBr6hFkh9wRLjQcIeZKTK1LkHpfC0b+n4Sz6GOzdNL78TDjCfK/P2r833UXEMYRxk2
 P2uNQYndYDn6tJiWKezknt18QrxtyvEkrRYrUhI4+cZhCAnx2Wp/lES58UBeaH2dUMQo
 BHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764543; x=1701369343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UF32mbiOniogqxmnEO/G/4hA+3MFqbkOICeJQxcwIQ=;
 b=FCaLeX3ReXk8CvplieNz8sOSXPTVbUtjujevW2GzgBoQLLWXKfFVoLDp3faxxk53IM
 y88sOf2DmxDI6ZAmtv8MGV7Vd46GUR/eFTxHuXGq4hZePKhjLvmWDwQGUJRmeOddBK8R
 nhF9/D9LB2y8LxRXuTAp1gD/6m2KtjbWnYPg7O5NN4iUtzXtjn9jIIcwSH8SWbs/k/Ud
 j6ZZwAqIH50HUV8KzVKXcviW2vYDsauTRborf42DDbrRy1eGBFBNwWolS65StvSUS2D/
 PLFGllTVzBMlCrxMsJbFepCkShlO4WtpT+sL/nE7+7yIl955jpvfccEyhQiNOs13nv67
 wM+Q==
X-Gm-Message-State: AOJu0YyJ5NYqOpe7mamvqgeBlFXlmzg1q4mL3JZsqhAX7r73oP1eB9wa
 TV6fBvkpS7eulppWP3VIAApCJ+vXAc5CWFiLgiA=
X-Google-Smtp-Source: AGHT+IGltS3KwJOeq5TCm3ydg30w+N35sZn3hV62TeTHE6Z8rqYBJAB1D8TeLnzmMQ7S92iGYMJJ4Q==
X-Received: by 2002:adf:e981:0:b0:332:c9f5:e5b5 with SMTP id
 h1-20020adfe981000000b00332c9f5e5b5mr54137wrm.0.1700764543126; 
 Thu, 23 Nov 2023 10:35:43 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a5d628f000000b0031ad5fb5a0fsm2315722wru.58.2023.11.23.10.35.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 04/16] target/arm/kvm: Have kvm_arm_sve_set_vls take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:05 +0100
Message-ID: <20231123183518.64569-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 target/arm/kvm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 03195f5627..71833a845a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1857,14 +1857,13 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
     return vls[0];
 }
 
-static int kvm_arm_sve_set_vls(CPUState *cs)
+static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS] = { cpu->sve_vq.map };
 
     assert(cpu->sve_max_vq <= KVM_ARM64_SVE_VQ_MAX);
 
-    return kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_VLS, &vls[0]);
+    return kvm_set_one_reg(CPU(cpu), KVM_REG_ARM64_SVE_VLS, &vls[0]);
 }
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
@@ -1921,7 +1920,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arm_sve_set_vls(cs);
+        ret = kvm_arm_sve_set_vls(cpu);
         if (ret) {
             return ret;
         }
-- 
2.41.0


