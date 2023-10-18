Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F47CE309
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YP-0000wr-0R; Wed, 18 Oct 2023 12:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YI-0000wC-SA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YH-0007Nn-9O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouuDmH5LRXhpOLGzIT0yUziDNV9zDFXE5DW4RMtCLhc=;
 b=OfNsy5zidnWyY0BcMAz5aQHN4tDpDBwvML/w1EfQPpAhzHZbnRllrScN2jxUUXvnZ8e8/w
 hTWboLGQc7muyFDYxzLjeaVFaqjA7YS6MbJ5tYAbH2NRIX7o76aK8eNq1it3elMToBXjmL
 H4D4JRhHIr0eGFu4skW7NL6Pqs1bmZ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-MI1FNrJAMvCmMeoyUbIf5A-1; Wed, 18 Oct 2023 12:37:40 -0400
X-MC-Unique: MI1FNrJAMvCmMeoyUbIf5A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae7663e604so307180566b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647057; x=1698251857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouuDmH5LRXhpOLGzIT0yUziDNV9zDFXE5DW4RMtCLhc=;
 b=qzFGGJYld1h2pSGiJDQgRDMZYgdZuLPqH8uuMyHk+rJsypmNYsnmeZZU5d4O34GpaC
 InxHmBqXIVyhr2Uo9Z7EC16TSLZyz92zzmerSRcFRjOXOid2GSPG8RcRLwOoL2yG+guo
 tTILyR+eFPcK5mNVX3qb1T/8V908VHn6CgJran98RS+j2pgmYdZZSmXOudb5H4Xiw7ZX
 i0WcdvBFKyh0Yp5u8W0taOXkv6wAtMmGx1RSN75qh4zN22yjShtxUyGFoHJMOcD6r3zK
 /uw3iZZ0WyikyAo1CUwAlUKdiwMBOy81RtpFFra6iL2ADitQgUQdcmVjON5t5v8/k8PU
 IhMg==
X-Gm-Message-State: AOJu0YzmzqQdisJfko/+J2//scwJu14rRf2lBbBdBAvFnrgoPC+Mx4ly
 3os1a6CQT0jC9vBoACdDnNL5qNCLkwZ+kpeBsgQAWRZZGwzAslHg9ytQoW5ALCd9O/xTvYse3rC
 conSCOdjpAWi1eBOpaPmztQDkDl0yDAXaHGgU5bRfq7/vTvL+lxU5dNYXupi35DmmkG0ruC3+h0
 g=
X-Received: by 2002:a17:906:9c84:b0:9a1:680e:8c54 with SMTP id
 fj4-20020a1709069c8400b009a1680e8c54mr4531002ejc.71.1697647057496; 
 Wed, 18 Oct 2023 09:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwqnqFKFWSIznf+vTmV4FWwkWoskwg4iYqw68mDALQLcf2pk23jYhWJIbIesxUNLzfu11Vlg==
X-Received: by 2002:a17:906:9c84:b0:9a1:680e:8c54 with SMTP id
 fj4-20020a1709069c8400b009a1680e8c54mr4530989ejc.71.1697647057161; 
 Wed, 18 Oct 2023 09:37:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 mc8-20020a170906eb4800b0098d2d219649sm2006094ejb.174.2023.10.18.09.37.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/17] kvm: require KVM_CAP_IRQFD for kernel irqchip
Date: Wed, 18 Oct 2023 18:37:15 +0200
Message-ID: <20231018163728.363879-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

KVM_CAP_IRQFD is always available on architectures that support an in-kernel
interrupt controller, and was introduced in Linux 2.6.32.  We can require
it unconditionally.

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
index 7eda9fb86ea..178f6d7de90 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -124,7 +124,7 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
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


