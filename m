Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2487F6677
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:40:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYT-0008If-E9; Thu, 23 Nov 2023 13:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYL-0008GM-Oe
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:53 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYJ-0003IZ-2d
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so698128f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764549; x=1701369349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbxwUSVkjdWQxr0WbjMFM/ALqAenG4WEeRbrPnMTydM=;
 b=drVCCUgivC4QoUNSe2vDbvsBZD65rNXSpvZjVagLCVQ/wbRcvk2WbqNygGa25QyxYH
 OFs+HOp4TxMT9Lft/Hg+Dov784uzzA+oJxaDMBpjnoPC3fhcQcU8UN0iX0velzzegZyd
 6SLJDi7Djw/X9LKrtOpx8hWC3bHv/hBOFY1TffxQqpKyd7WL2KnvkCRBywKRKIy07kvZ
 l7yG4UpQ/Xpnt2F0D7AhNKXAVg7Sms/W+MQ1Rikrcdj5vJx423EcgXQybwaWCwlx2WFO
 bfVMjuHH5I+aIeuGbPkUkCTWHMz8NS+/MZuBBhA7rUZIWlacg/Z/mDIcVVJz0wL7Hy5N
 lu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764549; x=1701369349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbxwUSVkjdWQxr0WbjMFM/ALqAenG4WEeRbrPnMTydM=;
 b=md/KTU8K81e3KADpm0uLlNHq/j8A5hx7qKKt6JloAWKoVE0zWv/i7wtsjcnYhQMtNT
 j3bPCuAY075irOzI7zCLCcFVQ1lHccC5lUUV5tLLxwNfYyZAVqJ2kVRzl04XaidahqY7
 UIgmfJj8ZWBenSo5XBA5Jau/qparYOqOmxJAEdzSJrzOYxq3eiwQJw4Bjk/8NRxBLs3X
 wqjpuYNmhEZsjUFxM1KRdA4dZppLOT87oTyV6r3JEcYJPcj98LLgxMsXZMv/FNKAFNLf
 yHtrLUMbxBY7Se4KH6Iz2OOOyYUQUog7eLY/sCQsyBSCOLyv3eB3kLNW/ae9NPsDe5uK
 2xhg==
X-Gm-Message-State: AOJu0Yzzx5hrWRB9sODuiNNaOhZ1I4YVzviptyu3g1YurDxkwUmEDFNk
 Dgi3nD6aURHNpLCoeqlCC0swx5YENMYRjnaoTAA=
X-Google-Smtp-Source: AGHT+IHVpBW+fxUIX3fX8nnHCAT1wph7WRPj0AJYgOhwR4F2XpN2KJZ++ptoCV/AV5CvKejHxGVv1Q==
X-Received: by 2002:a5d:4ac8:0:b0:332:e2e5:46a5 with SMTP id
 y8-20020a5d4ac8000000b00332e2e546a5mr37511wrs.7.1700764549059; 
 Thu, 23 Nov 2023 10:35:49 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 f6-20020adfc986000000b0032d829e10c0sm2293981wrh.28.2023.11.23.10.35.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 05/16] target/arm/kvm: Have kvm_arm_sve_get_vls take a
 ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:06 +0100
Message-ID: <20231123183518.64569-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 target/arm/kvm_arm.h | 6 +++---
 target/arm/cpu64.c   | 2 +-
 target/arm/kvm.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6fb8a5f67e..84f87f5ed7 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -129,13 +129,13 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
 
 /**
  * kvm_arm_sve_get_vls:
- * @cs: CPUState
+ * @cpu: ARMCPU
  *
  * Get all the SVE vector lengths supported by the KVM host, setting
  * the bits corresponding to their length in quadwords minus one
  * (vq - 1) up to ARM_MAX_VQ.  Return the resulting map.
  */
-uint32_t kvm_arm_sve_get_vls(CPUState *cs);
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu);
 
 /**
  * kvm_arm_set_cpu_features_from_host:
@@ -278,7 +278,7 @@ static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
     g_assert_not_reached();
 }
 
-static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
+static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1e9c6c85ae..8e30a7993e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -66,7 +66,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
      */
     if (kvm_enabled()) {
         if (kvm_arm_sve_supported()) {
-            cpu->sve_vq.supported = kvm_arm_sve_get_vls(CPU(cpu));
+            cpu->sve_vq.supported = kvm_arm_sve_get_vls(cpu);
             vq_supported = cpu->sve_vq.supported;
         } else {
             assert(!cpu_isar_feature(aa64_sve, cpu));
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 71833a845a..766a077bcf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1803,7 +1803,7 @@ bool kvm_arm_sve_supported(void)
 
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
-uint32_t kvm_arm_sve_get_vls(CPUState *cs)
+uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
 {
     /* Only call this function if kvm_arm_sve_supported() returns true. */
     static uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
-- 
2.41.0


