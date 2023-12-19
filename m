Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E45781908A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:18:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX4-0001yL-Lh; Tue, 19 Dec 2023 14:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWv-0001vg-LV
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:25 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWt-0001qy-2D
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:25 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33678156e27so178473f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013201; x=1703618001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ZO8ztgowbV18Gzw4fuVGRHf6IPf5T0BjvZrFbeykXA=;
 b=vXgcGQWmfrBruQ/kvTrDkWEGI3P3ke1OMkWnJ9ftiOQsHW0VHL1j51+TKuOe5Jh97w
 kliqETcH9P48F0A/QLXiWNQa6E6kIN/1FeVjI38YLj0DXy2zBpiP1rOra+0Rl7kP8wEI
 3pnr7PAhQjda/ktJFkDsfwZh++zgY2lQn6QYUUsmonvRPFiyVDe0b3sQfxzsxdABvo2U
 9DmhnND767aHk/YbX/s01mVfXNNYNZaNjHts2Fzj0WD5jtqdT6Kg3NcHYSipp7OrCqw9
 Kn3/3vprg/rKnCzCATuS72rdAVun60Ze4FbglpSQiaHHlK2AFGa72y0syBe8FI2kG4Un
 KBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013201; x=1703618001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZO8ztgowbV18Gzw4fuVGRHf6IPf5T0BjvZrFbeykXA=;
 b=YZNnAHD1O4sDBzoUN0kemSsVCQaUUr3TCoDctmtNI9/qjEiC9Lv0ybCzWcnGGvd6TE
 4/zTs828fuL8O7fL2y92OUHLWmzkM6TSal16darEd3kK60hV4rcshsQGroA+WFy2FIzo
 OYWJyPL95Z7+I0fb+WHEh03MU8RraFZ9hMpQkuC5G08e5LkjtJmajrabmbAeSKx45NMs
 EQiruJT8CbrOITSw5Jt2NMGsaE5XBswHGezDdIRWllRS6xix/5RxHkXSaa6jqB0bwMb0
 G2oMQfVsy2BLE4do3Ry/HYk2wTdWwCQ9wquEfxMdpIYc+k56SOhQLe3p71b7Bp6h5Z31
 8F+Q==
X-Gm-Message-State: AOJu0YyjuQ9Lspev2hE+IlhsDdKLo379VwHejm1kF+sgxxI5sIyLOGaZ
 C78tel1YCTPqpxImwqs2yKWUQ4QFgfGuYsIl/J8=
X-Google-Smtp-Source: AGHT+IGzHH59rQE88CK2q5qM/F60Tgrb1A80O07c7/rCPo0h8UV5Ik/pgnjoxZUyaxwiH2SDjhr7XA==
X-Received: by 2002:a5d:4e4f:0:b0:336:647c:cef1 with SMTP id
 r15-20020a5d4e4f000000b00336647ccef1mr2801569wrt.44.1703013201713; 
 Tue, 19 Dec 2023 11:13:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/43] target/arm/kvm: Have kvm_arm_set_device_attr take a
 ARMCPU argument
Date: Tue, 19 Dec 2023 19:12:51 +0000
Message-Id: <20231219191307.2895919-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20231123183518.64569-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 132a1b47d04..e6423d2720b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1689,18 +1689,18 @@ void kvm_arch_remove_all_hw_breakpoints(void)
     }
 }
 
-static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
+static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
                                     const char *name)
 {
     int err;
 
-    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
         error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
-    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
         error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
@@ -1719,7 +1719,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -1736,7 +1736,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
@@ -1753,7 +1753,7 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
     if (ARM_CPU(cs)->kvm_steal_time == ON_OFF_AUTO_OFF) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PVTIME IPA")) {
         error_report("failed to init PVTIME IPA");
         abort();
     }
-- 
2.34.1


