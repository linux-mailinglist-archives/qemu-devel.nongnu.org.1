Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A087F6678
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYv-0001gG-Bi; Thu, 23 Nov 2023 13:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYt-0001a8-GN
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:27 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYq-00041V-KM
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so698435f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764582; x=1701369382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+SHiNudBaJoVQ05FaR4tXQE9WbV9fq8fmbm8eyNxHM=;
 b=zvQTdhXiJj6hrfwnu85wFIUp1a8zz5SREPfu7WHTiR42m3MoXSMEEpAbL6yQwy2ToO
 G/6i0usTOpvsj6qXviLfjicgX1E8p4GpOo62Nea18TWt51E5CQkbbkxHL9n6s9V2IOa+
 L2znCPU9Qb8oC6CqsERG1eNcBpfO2RiIU+/Bcv1jY1nH9fmZCBG2Opj8IMkkEtaC8Jq0
 xMXIAUNz+ViYNAheS1CPO0d/Djm3MT2dEzRmyUl9NfgiMRvWUNyVVRrOm9SjiklZfZSR
 lKzn+RYISJIGt90GXxCbvFF9rZnAGWnTC4wzKQ34y36dEQE45ZA4d3qj7okeI1X6gwmB
 750w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764582; x=1701369382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+SHiNudBaJoVQ05FaR4tXQE9WbV9fq8fmbm8eyNxHM=;
 b=qC+acj/Cy5YM2o4Y/x0V2Q5FLPbxAN0kM7Ku90raprFIgTJsqTiqYqO9mVV57EFP/+
 VuQBcMhQAh+5TtGvoih/N91OiwGqFmy17szggSAgpY8st2kyxfDCXse5Qn0vt/0GDMY+
 NSQ3o7PrkbLanxzUwBH8537fgHrIBzQHSlGJduM9Txe/0TwXR6pv+bV4/kAvfmXRMVvz
 2207HlGBun7KMYZcBBhq8vj+u+HL4nwxr6MCGt3sdaJK8KDFAUmrMlRKI4zxXcWPuTOf
 5Ulqm9uye/3D7lRuq8uaLmaPCyuq0GhpEUGy8tliTtvq6jdVnyrNS6aFQQ+MhhEKhlyf
 xXEw==
X-Gm-Message-State: AOJu0YwUAVQirHZMk770lB8nfbjoio/VtWnAoiWgyGPVsjIl74aSoN6d
 N1e6LSNjY88M+w+t0X14ONX9ayFaE5L3bPf5yuA=
X-Google-Smtp-Source: AGHT+IGQXfk+qml3Ss0hlOkQY//xmWL0biF8uHQpwCUZdUFgs8ebq6vM/C+/PFHbdhDwvJD77doXJg==
X-Received: by 2002:a05:6000:1ccd:b0:32d:c792:fcaf with SMTP id
 bf13-20020a0560001ccd00b0032dc792fcafmr2898941wrb.26.1700764581996; 
 Thu, 23 Nov 2023 10:36:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfe881000000b00332c4055faesm2259393wrm.87.2023.11.23.10.36.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:36:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 11/16] target/arm/kvm: Have kvm_arm_vcpu_finalize take
 a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:12 +0100
Message-ID: <20231123183518.64569-12-philmd@linaro.org>
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
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 854e423135..dba2c9c6a9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -80,7 +80,7 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
 
 /**
  * kvm_arm_vcpu_finalize:
- * @cs: CPUState
+ * @cpu: ARMCPU
  * @feature: feature to finalize
  *
  * Finalizes the configuration of the specified VCPU feature by
@@ -90,9 +90,9 @@ static int kvm_arm_vcpu_init(ARMCPU *cpu)
  *
  * Returns: 0 if success else < 0 error code
  */
-static int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
+static int kvm_arm_vcpu_finalize(ARMCPU *cpu, int feature)
 {
-    return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
+    return kvm_vcpu_ioctl(CPU(cpu), KVM_ARM_VCPU_FINALIZE, &feature);
 }
 
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
@@ -1923,7 +1923,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         if (ret) {
             return ret;
         }
-        ret = kvm_arm_vcpu_finalize(cs, KVM_ARM_VCPU_SVE);
+        ret = kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_SVE);
         if (ret) {
             return ret;
         }
-- 
2.41.0


