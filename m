Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B88190A5
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:22:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWv-0001u6-4a; Tue, 19 Dec 2023 14:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWs-0001ss-0X
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWp-0001oD-Dk
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so11265e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013198; x=1703617998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t6m3lX5Sl9TdeDH1xGZK0J7bT0+H3YIVfUxVvxyivcw=;
 b=GpdPtBWy+sV+ur2LStTT0t9l8WpS9VNTqaqFDtsGLwqPB+pKjOLH469DjPuP49gMfy
 zFtbUkLNPrtre3oKDxRGUUhEt+lAJUM2UB7PyUQUxzKP1fWmhCJ7qBbSrMOmPQ6hVhGo
 htvT8CqSIAZ9lM5CkM4a8kHzkxM+q+XV4YQWkpI+C5SHwwy05p4AByT2g9+c0bn+YqEl
 obaNpowto8bPKI9EA+GnKzIkUDfXONR8yjkRlbOd3Qem/lQAl3SLetIpnCqYTka4VE2c
 Q6nl9Hto+rkfjAVo1dht+fB+ulBh2FVg5AeuzAPUVDJWnwSyZwom1IIjulALlA2PjMMc
 NMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013198; x=1703617998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6m3lX5Sl9TdeDH1xGZK0J7bT0+H3YIVfUxVvxyivcw=;
 b=DpbWWcKLB3g0hJfbfiYotgplc6IZCtUBUWUNj5eUT2CnlbPlFcxD4uXXMPWnHQnbGX
 9J/GiafugKCt8yYKvGou7H9FNQ1RaDuMJzGEBa9HcG8d/LRD2XrqqLLVOmEw+jm6FEOI
 Gv3y7bzbcyz7BhIcQgdOpm9EYW9dR1IRMe79Nk/55/58+oya6B3bpmbNgV2W/KX1vOaQ
 54XQOseFB5arNlfmLtCHqb3sGHfY1a2DWgMq2wbMCnH7s6HVH0j9ydvMAN53n3AzOsSN
 cTc4p0w7cHW6yVtvt86g+WdIF3SQ0WLGgbR2haY+CvRk7ppX1fPe0iPAyvcdNe1sMhNg
 m+Ug==
X-Gm-Message-State: AOJu0Yzaf6yKMmlUeXgV5TQ9sllZfUz0TexV6wRIrBsPjKXR/W2xq9S6
 EtLq/8xmnSWEMWrUfzQvQfls0SFE1lrFT9NtUTk=
X-Google-Smtp-Source: AGHT+IFBRh7WoL3I3SAgEbDTNFnWZKN5Sej3GrK2Yln7K4tLvB+6VqnQ5dB4S73xhip/+36nDt9+jw==
X-Received: by 2002:a05:600c:1c91:b0:40c:415f:cc48 with SMTP id
 k17-20020a05600c1c9100b0040c415fcc48mr804525wms.40.1703013198034; 
 Tue, 19 Dec 2023 11:13:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/43] target/arm/kvm: Init cap_has_inject_serror_esr in
 kvm_arch_init
Date: Tue, 19 Dec 2023 19:12:42 +0000
Message-Id: <20231219191307.2895919-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

There is no need to do this in kvm_arch_init_vcpu per vcpu.
Inline kvm_arm_init_serror_injection rather than keep separate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h |  8 --------
 target/arm/kvm.c     | 13 ++++---------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 350ba6cb967..1ec2476de7b 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -98,14 +98,6 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-/**
- * kvm_arm_init_serror_injection:
- * @cs: CPUState
- *
- * Check whether KVM can set guest SError syndrome.
- */
-void kvm_arm_init_serror_injection(CPUState *cs);
-
 /**
  * kvm_get_vcpu_events:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d87d3e53e02..4a5553864a0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -98,12 +98,6 @@ static int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
 }
 
-void kvm_arm_init_serror_injection(CPUState *cs)
-{
-    cap_has_inject_serror_esr = kvm_check_extension(cs->kvm_state,
-                                    KVM_CAP_ARM_INJECT_SERROR_ESR);
-}
-
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
@@ -564,6 +558,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    /* Check whether user space can specify guest syndrome value */
+    cap_has_inject_serror_esr =
+        kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
+
     if (ms->smp.cpus > 256 &&
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
@@ -1946,9 +1944,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    /* Check whether user space can specify guest syndrome value */
-    kvm_arm_init_serror_injection(cs);
-
     return kvm_arm_init_cpreg_list(cpu);
 }
 
-- 
2.34.1


