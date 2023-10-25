Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AF7D788A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnI2-0001gU-77; Wed, 25 Oct 2023 19:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHz-0001c4-6E
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHx-0005FW-HF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ9ihBCuLP5gkWgiaOnAd8W6UC+9lo4Sb+owWEw1amo=;
 b=TelC+vSpqiz1vMAECs/94OSyMhBL7mAURwWk4UlSZ+w8M0iMDrzpWqJzeFZ6/E6DD/zHqM
 JPR9NZv+T4GD88skF+9k19IVDKnmWBkHjqSLZW1DqNOlOR6YCZMRZ4wXobZ1p5F8V9WRGv
 lr4Yr8a3vc35p4pQHjJNVpk1ITgdYTo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-HBey_i8hPF2CVEwsaBPsHg-1; Wed, 25 Oct 2023 19:27:42 -0400
X-MC-Unique: HBey_i8hPF2CVEwsaBPsHg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cc6c43cdfso4351661cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276461; x=1698881261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQ9ihBCuLP5gkWgiaOnAd8W6UC+9lo4Sb+owWEw1amo=;
 b=bqb92ZMq8nqYEgf8uwQ1SaZDHFjLqdgyuXmDEvCt913mEqyGut3kdWt/cT6nGcYOwF
 8hfR9j4HdL6RqdJD/XhIqdchDP4mX0xDK+PRdSJ5yJnN5p0yjgtd6erwLtaM73Xgs9Kh
 W4JSZTGgXiobWtRnjCZSU2cjWECnvmp13i0dYEq5Jl4lp1j6l2GappSixNWgOip/+O+n
 zupIikI8TnsglyFXlf0ezOZyDO/ptl5UQi31GhiC2kNDsY7MR34tCidf7t0mPJfIRb7T
 64tmbpvGxKicMkIh96ak8+9BkbhFuLw25sMOnR3+0Jkabpz7iUOt1DkqsAyEiHDatoD3
 07GA==
X-Gm-Message-State: AOJu0YxRDjSO9YnjVRGzx4QRaO7sfRMq9FEOVCmSdbehPoqO+t0QN1rD
 CpkF1pY73ZLyfNOfQxa60Hb1290wrLOUZWpKwj2z0jD1O2FuxaUbjXEDU4dSyOd7Mdxe28lqaFn
 RAXOYdq3EGFEk6NHgmmZ0hS4c57kMyoHYzBxO1c9pOoGFZpGHVIIqkws0api+f/1kLS/KsYgjSc
 s=
X-Received: by 2002:a05:622a:1a0a:b0:419:5775:7d6a with SMTP id
 f10-20020a05622a1a0a00b0041957757d6amr21183819qtb.16.1698276461398; 
 Wed, 25 Oct 2023 16:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHaqMu3EYaR+QZ1Te8CvUU2C5xsfeXRSkM21Gq+jIbIbRpqhJO8yPP1wG0XmKCueu/xlSqsw==
X-Received: by 2002:a05:622a:1a0a:b0:419:5775:7d6a with SMTP id
 f10-20020a05622a1a0a00b0041957757d6amr21183802qtb.16.1698276461019; 
 Wed, 25 Oct 2023 16:27:41 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 g3-20020ac870c3000000b0041b3a1462fbsm4554904qtp.37.2023.10.25.16.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 11/24] kvm: require KVM_IRQFD for kernel irqchip
Date: Thu, 26 Oct 2023 01:27:04 +0200
Message-ID: <20231025232718.89428-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

KVM_IRQFD was introduced in Linux 2.6.32, and since then it has always been
available on architectures that support an in-kernel interrupt controller.
We can require it unconditionally.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c         | 13 +++++--------
 accel/stubs/kvm-stub.c      |  1 -
 hw/intc/arm_gicv3_its_kvm.c |  2 +-
 include/sysemu/kvm.h        |  6 +++---
 target/riscv/kvm/kvm-cpu.c  |  2 +-
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0c7b0569da4..be50d47f7b4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -91,7 +91,6 @@ bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_halt_in_kernel_allowed;
 bool kvm_eventfds_allowed;
-bool kvm_irqfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
@@ -2128,10 +2127,6 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
         }
     }
 
-    if (!kvm_irqfds_enabled()) {
-        return -ENOSYS;
-    }
-
     return kvm_vm_ioctl(s, KVM_IRQFD, &irqfd);
 }
 
@@ -2292,6 +2287,11 @@ static void kvm_irqchip_create(KVMState *s)
         return;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
+        fprintf(stderr, "kvm: irqfd not implemented\n");
+        exit(1);
+    }
+
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
@@ -2589,9 +2589,6 @@ static int kvm_init(MachineState *ms)
     kvm_eventfds_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD) > 0);
 
-    kvm_irqfds_allowed =
-        (kvm_check_extension(s, KVM_CAP_IRQFD) > 0);
-
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index bce005adad8..19d58f2778f 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -18,7 +18,6 @@ KVMState *kvm_state;
 bool kvm_kernel_irqchip;
 bool kvm_async_interrupts_allowed;
 bool kvm_eventfds_allowed;
-bool kvm_irqfds_allowed;
 bool kvm_resamplefds_allowed;
 bool kvm_msi_via_irqfd_allowed;
 bool kvm_gsi_routing_allowed;
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 61c1cc7bdb8..f7df602cfff 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -123,7 +123,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
-    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    kvm_msi_via_irqfd_allowed = true;
 }
 
 /**
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 93dccf5dd92..575dee53b39 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -37,7 +37,6 @@ extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
 extern bool kvm_halt_in_kernel_allowed;
 extern bool kvm_eventfds_allowed;
-extern bool kvm_irqfds_allowed;
 extern bool kvm_resamplefds_allowed;
 extern bool kvm_msi_via_irqfd_allowed;
 extern bool kvm_gsi_routing_allowed;
@@ -102,8 +101,10 @@ extern bool kvm_msi_use_devid;
  * Returns: true if we can use irqfds to inject interrupts into
  * a KVM CPU (ie the kernel supports irqfds and we are running
  * with a configuration where it is meaningful to use them).
+ *
+ * Always available if running with in-kernel irqchip.
  */
-#define kvm_irqfds_enabled() (kvm_irqfds_allowed)
+#define kvm_irqfds_enabled() kvm_irqchip_in_kernel()
 
 /**
  * kvm_resamplefds_enabled:
@@ -167,7 +168,6 @@ extern bool kvm_msi_use_devid;
 #define kvm_async_interrupts_enabled() (false)
 #define kvm_halt_in_kernel() (false)
 #define kvm_eventfds_enabled() (false)
-#define kvm_irqfds_enabled() (false)
 #define kvm_resamplefds_enabled() (false)
 #define kvm_msi_via_irqfd_enabled() (false)
 #define kvm_gsi_routing_allowed() (false)
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 090d6176275..26e68c7ab45 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1420,7 +1420,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    kvm_msi_via_irqfd_allowed = true;
 }
 
 static void kvm_cpu_instance_init(CPUState *cs)
-- 
2.41.0


