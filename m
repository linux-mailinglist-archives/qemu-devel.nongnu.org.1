Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B739378EE2C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:10:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLT-0008BH-Ji; Thu, 31 Aug 2023 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHU-0005kf-7b
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHN-0006Uw-AD
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso7129215e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486807; x=1694091607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBqrh3+OwbRO0FKJwz0pOQZiq7Hglu3XVSiWyrHauk4=;
 b=jwS/5IOwS7px3CF7UdLJXiNGi0KzHBTBrNC3LNr1yrKDqhQx7fm3CUw4PBMeKW4J1H
 jc1OBsWy4pZKscTGUgc96/BfumC5sIiVKA5KpA7agOKtnX9Z3GCBWmbbX9DJi7nSswyr
 g5CQzniYwRsFnM7KXcYMLDaRq5++/3A8p7tqiEvw5FwqAe+ovuwV5WXBc3YWm5UwObqD
 Q6lYKRb6zjlV4HIDhZQCPc5DQErAWV4vfZ390BvPC9USoGs5L6m+FabLrs7g2XZPw0j3
 awlETQmsyds6nj0Wh7DUw3/KJS5ok5b9lhC14HhenTs48OV7AHP+Tky/SfWMHoA3+wf8
 paMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486807; x=1694091607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBqrh3+OwbRO0FKJwz0pOQZiq7Hglu3XVSiWyrHauk4=;
 b=aD7Q/MAljKoXAcY4gBEtPtdXCJV3P5Ce+Zc9kojKQ6AllmTK1XweoSIrYRkJ7NDSBl
 OUlzXf5AVgxTbU7csxyUmsYEzA1RY5YIIHlylhv/TZfkn/lm/y7ek5NXv8C6lXmyt8do
 CH3tjCZ2BM6Xr+y8htAbFg1TOrPoS1NUL7L/M/NJWZUc5x4GbkBeSIUuOiOztBvLG2Ok
 sHqSQDIJHb7El/CcmM3dOTKK9ri4aY8TYdakcr8d0GdW8UDJKRtZP6zpRug0Ez2XulGq
 SlE+LAcxZWJHzQzZk26jU7gXzw5+gSiVfgwmPHZEjFgH1DcFGPCoXIGoqQhUoeyS6SC+
 R05w==
X-Gm-Message-State: AOJu0Yxo3lJ2TZ3w6xj6mz7/7Y++ktJKCxpkjk3O4Fr8FBLGknfMRUx4
 RPvUaEytjQmp4/it9L9rkGGxWRUvma903D57ilE=
X-Google-Smtp-Source: AGHT+IHFtn1g4oVr4OxUDyOHvfLkdRRms95A80KEEeJytluOw9x87dJtzVPYJS4DW6y4OFRSEbfikw==
X-Received: by 2002:adf:e5cf:0:b0:317:e542:80a8 with SMTP id
 a15-20020adfe5cf000000b00317e54280a8mr3780210wrn.15.1693486807461; 
 Thu, 31 Aug 2023 06:00:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 i16-20020adffc10000000b0031c5ee51638sm2147619wrr.109.2023.08.31.06.00.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 kvm@vger.kernel.org
Subject: [PULL 33/41] hw/i386: Remove unuseful kvmclock_create() stub
Date: Thu, 31 Aug 2023 14:56:35 +0200
Message-ID: <20230831125646.67855-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We shouldn't call kvmclock_create() when KVM is not available
or disabled:
 - check for kvm_enabled() before calling it
 - assert KVM is enabled once called
Since the call is elided when KVM is not available, we can
remove the stub (it is never compiled).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230620083228.88796-2-philmd@linaro.org>
---
 include/hw/kvm/clock.h | 10 ----------
 hw/i386/kvm/clock.c    |  4 +++-
 hw/i386/microvm.c      |  4 +++-
 hw/i386/pc_piix.c      |  2 +-
 hw/i386/pc_q35.c       |  4 +++-
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
index 7994071c4f..3efe0a871c 100644
--- a/include/hw/kvm/clock.h
+++ b/include/hw/kvm/clock.h
@@ -13,16 +13,6 @@
 #ifndef HW_KVM_CLOCK_H
 #define HW_KVM_CLOCK_H
 
-#ifdef CONFIG_KVM
-
 void kvmclock_create(bool create_always);
 
-#else /* CONFIG_KVM */
-
-static inline void kvmclock_create(bool create_always)
-{
-}
-
-#endif /* !CONFIG_KVM */
-
 #endif
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index df70b4a033..0824c6d313 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -332,8 +332,10 @@ void kvmclock_create(bool create_always)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
-    if (!kvm_enabled() || !kvm_has_adjust_clock())
+    assert(kvm_enabled());
+    if (!kvm_has_adjust_clock()) {
         return;
+    }
 
     if (create_always ||
         cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7227a2156c..6b762bc18e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -180,7 +180,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->ioapic2 = ioapic_init_secondary(gsi_state);
     }
 
-    kvmclock_create(true);
+    if (kvm_enabled()) {
+        kvmclock_create(true);
+    }
 
     mms->virtio_irq_base = 5;
     mms->virtio_num_transports = 8;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce1ac95274..3de8e0d741 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -192,7 +192,7 @@ static void pc_init1(MachineState *machine,
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    if (pcmc->kvmclock_enabled) {
+    if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37c4814bed..a95c5d046e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -183,7 +183,9 @@ static void pc_q35_init(MachineState *machine)
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
-    kvmclock_create(pcmc->kvmclock_create_always);
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
 
     /* pci enabled */
     if (pcmc->pci_enabled) {
-- 
2.41.0


