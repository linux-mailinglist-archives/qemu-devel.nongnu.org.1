Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA542969C45
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 13:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slRyY-00042a-Tk; Tue, 03 Sep 2024 07:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slRyD-0003i7-Fi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 07:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slRy3-0006IG-A4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 07:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725363841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=r0as5Ez9pDXfQjAecZyDf6B3cpNpbSgXo6vc2nKXViw=;
 b=HZfNjisC9uINCGfHtfBaSqunNmgebalF3Bg0v39z5olcsz+DhjEfWLNBteN2OwufbjtOwm
 ZWSa5A4Xk4cHGzTrRSSvkCgW56dBd653DE23QCJRvJkxmctVLBzH+P4oERJLYZyT8EknKZ
 CwaSpLEKNNVq6ad+ATmcdx6cjaoo79s=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-qm8KctWOM0uIT8S33oW6vg-1; Tue, 03 Sep 2024 07:34:38 -0400
X-MC-Unique: qm8KctWOM0uIT8S33oW6vg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-278249679a1so261397fac.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 04:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725363277; x=1725968077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0as5Ez9pDXfQjAecZyDf6B3cpNpbSgXo6vc2nKXViw=;
 b=eff4feRqvKkGUbNPQNUc+9QlyV7ERh1tISXDYnVb90sbM54DFKAgddDTLnyl/dzWlD
 ulP0aOt8tMxSWPOfc9r5YRtIJSsMpWEZxobAYMT5xzCiy/VKXSlhdZAt0DpA+vbhMarj
 XcVTTFxX/y2SfAi0bufb9IBhqUPOi2L0cz8VM7mAbZkB2dgflhW4xzi3L3CAqzmVkBtH
 jsK3y3Z5PBeEKI7UyxFykjCYqLrB6O8rcOQbBULzEJ24rCHH12Rlwc8uMSHB+WGL8Hx5
 0Q7y8TB9udY+gO557MbXohcO50aXTZrLhFiJWyx4uHfKOhuyRaztFbk69d7Czal577G8
 hsvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6cjnadx147i3ZokgviGR/6UDE1Hyp12qK5S8N1UM1uXwWlzvnhgpu3ipmryXmKu+Yt1/YTgIP2Pjl@nongnu.org
X-Gm-Message-State: AOJu0YyD3iF3o/N3rCjhPd/VPVjbaNvN54NsG+mEzd8XmeVIbk/YV0bp
 FaQ3QzepQWDNqUdrb/3bIhUMj76rEh7BD4aQR8YK8A07OGyGdpwL2PAac2ksCLDTheXaqp4sZ+D
 93vaVmEPHk9pcWwpHIz5Kdqn/YG3S3fkDBknRe5spbRg2zdkkMe1L
X-Received: by 2002:a05:6871:7609:b0:277:fb54:5a5 with SMTP id
 586e51a60fabf-277fb550429mr3919667fac.38.1725363277511; 
 Tue, 03 Sep 2024 04:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaGWLyBSAnXCK3P78dLgV5cAuVSi6AUh0JT2oC6Wwy7fDVKNusUJIynBQX8YSzwj/2SyJyBA==
X-Received: by 2002:a05:6871:7609:b0:277:fb54:5a5 with SMTP id
 586e51a60fabf-277fb550429mr3919648fac.38.1725363277128; 
 Tue, 03 Sep 2024 04:34:37 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-715e569e746sm8565257b3a.97.2024.09.03.04.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:34:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] kvm/i386: refactor kvm_arch_init and split it into smaller
 functions
Date: Tue,  3 Sep 2024 17:04:18 +0530
Message-ID: <20240903113418.38475-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

kvm_arch_init() enables a lot of vm capabilities. Refactor them into separate
smaller functions. Energy MSR related operations also moved to its own
function. There should be no functional impact.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 337 ++++++++++++++++++++++++++----------------
 1 file changed, 211 insertions(+), 126 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 503e8d956e..574c62c21a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2997,10 +2997,197 @@ int kvm_arch_get_default_type(MachineState *ms)
     return 0;
 }
 
+static int kvm_vm_enable_exception_payload(KVMState *s)
+{
+    int ret = 0;
+    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
+    if (has_exception_payload) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable exception payload cap: %s",
+                         strerror(-ret));
+        }
+    }
+
+    return ret;
+}
+
+static int kvm_vm_enable_triple_fault_event(KVMState *s)
+{
+    int ret = 0;
+    has_triple_fault_event = \
+        kvm_check_extension(s,
+                            KVM_CAP_X86_TRIPLE_FAULT_EVENT);
+    if (has_triple_fault_event) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable triple fault event cap: %s",
+                         strerror(-ret));
+        }
+    }
+    return ret;
+}
+
+static int kvm_vm_set_identity_map_addr(KVMState *s, uint64_t *identity_base)
+{
+    /*
+     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
+     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
+     * Since these must be part of guest physical memory, we need to allocate
+     * them, both by setting their start addresses in the kernel and by
+     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
+     * so this value allows up to 16M BIOSes.
+     */
+    *identity_base = 0xfeffc000;
+    return kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, identity_base);
+}
+
+static int kvm_vm_set_nr_mmu_pages(KVMState *s)
+{
+    uint64_t shadow_mem;
+    int ret = 0;
+    shadow_mem = object_property_get_int(OBJECT(s),
+                                         "kvm-shadow-mem",
+                                         &error_abort);
+    if (shadow_mem != -1) {
+        shadow_mem /= 4096;
+        ret = kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
+    }
+    return ret;
+}
+
+static int kvm_vm_set_tss_addr(KVMState *s, uint64_t identity_base)
+{
+    /* Set TSS base one page after EPT identity map. */
+    return kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base);
+}
+
+static int kvm_vm_enable_disable_exits(KVMState *s)
+{
+    int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
+/* Work around for kernel header with a typo. TODO: fix header and drop. */
+#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
+#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
+#endif
+    if (disable_exits) {
+        disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
+                          KVM_X86_DISABLE_EXITS_HLT |
+                          KVM_X86_DISABLE_EXITS_PAUSE |
+                          KVM_X86_DISABLE_EXITS_CSTATE);
+    }
+
+    return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
+                             disable_exits);
+}
+
+static int kvm_vm_enable_bus_lock_exit(KVMState *s)
+{
+    int ret = 0;
+    ret = kvm_check_extension(s, KVM_CAP_X86_BUS_LOCK_EXIT);
+    if (!(ret & KVM_BUS_LOCK_DETECTION_EXIT)) {
+        error_report("kvm: bus lock detection unsupported");
+        return -ENOTSUP;
+    }
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X86_BUS_LOCK_EXIT, 0,
+                            KVM_BUS_LOCK_DETECTION_EXIT);
+    if (ret < 0) {
+        error_report("kvm: Failed to enable bus lock detection cap: %s",
+                     strerror(-ret));
+    }
+
+    return ret;
+}
+
+static int kvm_vm_enable_notify_vmexit(KVMState *s)
+{
+    int ret = 0;
+    if (!kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
+        error_report("kvm: notify vmexit unsupported");
+        return -ENOTSUP;
+    }
+
+    if (s->notify_vmexit != NOTIFY_VMEXIT_OPTION_DISABLE) {
+        uint64_t notify_window_flags =
+            ((uint64_t)s->notify_window << 32) |
+            KVM_X86_NOTIFY_VMEXIT_ENABLED |
+            KVM_X86_NOTIFY_VMEXIT_USER;
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_NOTIFY_VMEXIT, 0,
+                                notify_window_flags);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable notify vmexit cap: %s",
+                         strerror(-ret));
+        }
+    }
+    return ret;
+}
+
+static int kvm_vm_enable_userspace_msr(KVMState *s)
+{
+    int ret;
+
+    if (!kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
+        error_report("kvm: userspace MSR not supported");
+        return -ENOTSUP;
+    }
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
+                            KVM_MSR_EXIT_REASON_FILTER);
+    if (ret < 0) {
+        error_report("Could not enable user space MSRs: %s",
+                     strerror(-ret));
+        exit(1);
+    }
+
+    if (!kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
+                        kvm_rdmsr_core_thread_count, NULL)) {
+        error_report("Could not install MSR_CORE_THREAD_COUNT handler!");
+        exit(1);
+    }
+
+    return 0;
+}
+
+static void kvm_vm_enable_energy_msrs(KVMState *s)
+{
+    bool r;
+    if (s->msr_energy.enable == true) {
+        r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                           kvm_rdmsr_rapl_power_unit, NULL);
+        if (!r) {
+            error_report("Could not install MSR_RAPL_POWER_UNIT \
+                                handler");
+            exit(1);
+        }
+
+        r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                           kvm_rdmsr_pkg_power_limit, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_POWER_LIMIT \
+                                handler");
+            exit(1);
+        }
+
+        r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                           kvm_rdmsr_pkg_power_info, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_POWER_INFO \
+                                handler");
+            exit(1);
+        }
+        r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                           kvm_rdmsr_pkg_energy_status, NULL);
+        if (!r) {
+            error_report("Could not install MSR_PKG_ENERGY_STATUS \
+                                handler");
+            exit(1);
+        }
+    }
+    return;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     uint64_t identity_base = 0xfffbc000;
-    uint64_t shadow_mem;
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3030,24 +3217,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
 
-    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
-    if (has_exception_payload) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
-        if (ret < 0) {
-            error_report("kvm: Failed to enable exception payload cap: %s",
-                         strerror(-ret));
-            return ret;
-        }
+    ret = kvm_vm_enable_exception_payload(s);
+    if (ret < 0) {
+        return ret;
     }
 
-    has_triple_fault_event = kvm_check_extension(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT);
-    if (has_triple_fault_event) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_TRIPLE_FAULT_EVENT, 0, true);
-        if (ret < 0) {
-            error_report("kvm: Failed to enable triple fault event cap: %s",
-                         strerror(-ret));
-            return ret;
-        }
+    ret = kvm_vm_enable_triple_fault_event(s);
+    if (ret < 0) {
+        return ret;
     }
 
     if (s->xen_version) {
@@ -3078,22 +3255,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
 
-    /*
-     * On older Intel CPUs, KVM uses vm86 mode to emulate 16-bit code directly.
-     * In order to use vm86 mode, an EPT identity map and a TSS  are needed.
-     * Since these must be part of guest physical memory, we need to allocate
-     * them, both by setting their start addresses in the kernel and by
-     * creating a corresponding e820 entry. We need 4 pages before the BIOS,
-     * so this value allows up to 16M BIOSes.
-     */
-    identity_base = 0xfeffc000;
-    ret = kvm_vm_ioctl(s, KVM_SET_IDENTITY_MAP_ADDR, &identity_base);
+    ret = kvm_vm_set_identity_map_addr(s, &identity_base);
     if (ret < 0) {
         return ret;
     }
 
-    /* Set TSS base one page after EPT identity map. */
-    ret = kvm_vm_ioctl(s, KVM_SET_TSS_ADDR, identity_base + 0x1000);
+    ret = kvm_vm_set_tss_addr(s, identity_base + 0x1000);
     if (ret < 0) {
         return ret;
     }
@@ -3101,13 +3268,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /* Tell fw_cfg to notify the BIOS to reserve the range. */
     e820_add_entry(identity_base, 0x4000, E820_RESERVED);
 
-    shadow_mem = object_property_get_int(OBJECT(s), "kvm-shadow-mem", &error_abort);
-    if (shadow_mem != -1) {
-        shadow_mem /= 4096;
-        ret = kvm_vm_ioctl(s, KVM_SET_NR_MMU_PAGES, shadow_mem);
-        if (ret < 0) {
-            return ret;
-        }
+    ret = kvm_vm_set_nr_mmu_pages(s);
+    if (ret < 0) {
+        return ret;
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
@@ -3118,20 +3281,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (enable_cpu_pm) {
-        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
-/* Work around for kernel header with a typo. TODO: fix header and drop. */
-#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
-#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
-#endif
-        if (disable_exits) {
-            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
-                              KVM_X86_DISABLE_EXITS_HLT |
-                              KVM_X86_DISABLE_EXITS_PAUSE |
-                              KVM_X86_DISABLE_EXITS_CSTATE);
-        }
-
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-                                disable_exits);
+        ret = kvm_vm_enable_disable_exits(s);
         if (ret < 0) {
             error_report("kvm: guest stopping CPU not supported: %s",
                          strerror(-ret));
@@ -3142,16 +3292,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         X86MachineState *x86ms = X86_MACHINE(ms);
 
         if (x86ms->bus_lock_ratelimit > 0) {
-            ret = kvm_check_extension(s, KVM_CAP_X86_BUS_LOCK_EXIT);
-            if (!(ret & KVM_BUS_LOCK_DETECTION_EXIT)) {
-                error_report("kvm: bus lock detection unsupported");
-                return -ENOTSUP;
-            }
-            ret = kvm_vm_enable_cap(s, KVM_CAP_X86_BUS_LOCK_EXIT, 0,
-                                    KVM_BUS_LOCK_DETECTION_EXIT);
+            ret = kvm_vm_enable_bus_lock_exit(s);
             if (ret < 0) {
-                error_report("kvm: Failed to enable bus lock detection cap: %s",
-                             strerror(-ret));
                 return ret;
             }
             ratelimit_init(&bus_lock_ratelimit_ctrl);
@@ -3160,80 +3302,23 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (s->notify_vmexit != NOTIFY_VMEXIT_OPTION_DISABLE &&
-        kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
-            uint64_t notify_window_flags =
-                ((uint64_t)s->notify_window << 32) |
-                KVM_X86_NOTIFY_VMEXIT_ENABLED |
-                KVM_X86_NOTIFY_VMEXIT_USER;
-            ret = kvm_vm_enable_cap(s, KVM_CAP_X86_NOTIFY_VMEXIT, 0,
-                                    notify_window_flags);
-            if (ret < 0) {
-                error_report("kvm: Failed to enable notify vmexit cap: %s",
-                             strerror(-ret));
-                return ret;
-            }
+    ret = kvm_vm_enable_notify_vmexit(s);
+    if (ret < 0) {
+        return ret;
     }
-    if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
-        bool r;
 
-        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
-                                KVM_MSR_EXIT_REASON_FILTER);
-        if (ret) {
-            error_report("Could not enable user space MSRs: %s",
-                         strerror(-ret));
-            exit(1);
-        }
-
-        r = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
-                           kvm_rdmsr_core_thread_count, NULL);
-        if (!r) {
-            error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
-                         strerror(-ret));
-            exit(1);
+    if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
+        ret = kvm_vm_enable_userspace_msr(s);
+        if (ret < 0) {
+            return ret;
         }
 
         if (s->msr_energy.enable == true) {
-            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
-                               kvm_rdmsr_rapl_power_unit, NULL);
-            if (!r) {
-                error_report("Could not install MSR_RAPL_POWER_UNIT \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-
-            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
-                               kvm_rdmsr_pkg_power_limit, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_POWER_LIMIT \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-
-            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
-                               kvm_rdmsr_pkg_power_info, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_POWER_INFO \
-                                handler: %s",
-                             strerror(-ret));
+            kvm_vm_enable_energy_msrs(s);
+            if (kvm_msr_energy_thread_init(s, ms)) {
+                error_report("kvm : error RAPL feature requirement not met");
                 exit(1);
             }
-            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
-                               kvm_rdmsr_pkg_energy_status, NULL);
-            if (!r) {
-                error_report("Could not install MSR_PKG_ENERGY_STATUS \
-                                handler: %s",
-                             strerror(-ret));
-                exit(1);
-            }
-            r = kvm_msr_energy_thread_init(s, ms);
-            if (r) {
-                error_report("kvm : error RAPL feature requirement not meet");
-                exit(1);
-            }
-
         }
     }
 
-- 
2.42.0


