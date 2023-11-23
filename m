Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B77497F6679
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:40:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EYW-0008U2-2f; Thu, 23 Nov 2023 13:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYS-0008O2-CH
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:36:00 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6EYO-0003QU-Dl
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:35:58 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c876e44157so14096091fa.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700764554; x=1701369354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APkzUJ5V8QYL4MOU/zl88wqY6eeEqD/ibNzL1bZO05g=;
 b=hoeKflBFH0s3aCxlmYwKPvp7nRxUQiZqOir7ZHUppR4UXWxuJ4CCQXyTWje5Yr4noj
 St37h+1uNT1nbScTH+GbexSlosqNkS+0KmaolOyAHrDiQA4lvU8ny2cXcsywJjWcIv2C
 Pv9sRmIcuk6MdVxRubau2e/gpyWJ0+pHGD1ZGvkmz1fPA2AgUdyJ95wx1HaQY80ckNFa
 chOyKxq0PcwyxU+mVL0HE/rddbJGjpnIOXzBQYg3h7pknWYFJBoUcm0lIhUwq02Omolb
 HB36kMXFeRNzyNzRXOZ/tyek4tWUcoXnpEqiaAu2NhM9gHvwbl4Gy/s89bn81UP288HJ
 OTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700764554; x=1701369354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APkzUJ5V8QYL4MOU/zl88wqY6eeEqD/ibNzL1bZO05g=;
 b=GV644NDplnwPIm36bbg3H7ocSId/sr3dbhj+ASdzGFPTvCzIvClzP3wNef3omwQ9Rh
 IUC6JeRqmfKMDBYYr8t7+OMZLn6s7ZxgAWa/dicgWFbJrEpxzXmK4iA+GzjKSUiOc8v4
 SNK+i6195Av6KSvICklEqtcynpcwA0MOzCzWAwMz7iOTtjbcKTi9U0GjxYfMsq4v8A5Q
 zLm675R03nm619M2O8Gf0foJUuuNNHiOfz6rFcoUQlBM1zueVs2a/3f0/VuYGXJxAP+s
 kjUI42h/XdMnlz3kOX8wHWapol8jjGxb00SNH0BgiJzyH3Y5PoFCCTOlBee6OczBMn6j
 Riog==
X-Gm-Message-State: AOJu0YxYQZsoaLZKhXoYa9QSt+c/d2652Ut9Zsf+crzhv4GpszK1m4Qw
 SUX+Kt12TvYq6JDLoyAWM/8F6qVszTI6/i8izmY=
X-Google-Smtp-Source: AGHT+IEMHSuxheCHpy3+JITp+0heG5juBUPBJg9h7cDu77hpzkqvd1orzB6IYTMkszJ7lWDnZPfVaA==
X-Received: by 2002:a2e:9e09:0:b0:2bc:e330:660b with SMTP id
 e9-20020a2e9e09000000b002bce330660bmr180065ljk.9.1700764554485; 
 Thu, 23 Nov 2023 10:35:54 -0800 (PST)
Received: from m1x-phil.lan ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 bg11-20020a05600c3c8b00b0040b2c195523sm3477497wmb.31.2023.11.23.10.35.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Nov 2023 10:35:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 06/16] target/arm/kvm: Have kvm_arm_set_device_attr
 take a ARMCPU argument
Date: Thu, 23 Nov 2023 19:35:07 +0100
Message-ID: <20231123183518.64569-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
References: <20231123183518.64569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
 target/arm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 766a077bcf..73f4e5a0fa 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1691,18 +1691,18 @@ void kvm_arch_remove_all_hw_breakpoints(void)
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
@@ -1721,7 +1721,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -1738,7 +1738,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
@@ -1755,7 +1755,7 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
     if (ARM_CPU(cs)->kvm_steal_time == ON_OFF_AUTO_OFF) {
         return;
     }
-    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
+    if (!kvm_arm_set_device_attr(ARM_CPU(cs), &attr, "PVTIME IPA")) {
         error_report("failed to init PVTIME IPA");
         abort();
     }
-- 
2.41.0


