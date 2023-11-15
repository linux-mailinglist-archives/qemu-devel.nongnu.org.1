Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F330C7EBDA5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:19:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AAk-0007wG-Nn; Wed, 15 Nov 2023 02:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AAP-0007UR-2v
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:18:29 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3AAM-0002U6-Td
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032706; x=1731568706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M2B4nh3hZ5GVdKM3X9vAzcE9TW8rBgmpyNXfrVBas0M=;
 b=YpdmHfSB6pCXrf5I2urKDipYMHteKTGLnvsES1u87PJbWp56H3ccnkwH
 YHO76eh5IzJUGdFtjv0lRhqWlNL21A23H5X5b/0DrZEnkAO8mnhleS/oB
 XHhxfGebGYVO0rrFumu0fN9er3JKBm2ydMqEMCQCzKtW7k9Yk8XTcNJvY
 cHvnrCO1KScAooxNG23PHa9KwKEki+WfpoJj2keU2h3h00QqmOhZNg+tr
 uhwvihX4oOyi8KyO+c4ernoXV77bc99Jp6YMQB8vdDFyGdl8B9eiuL0Tl
 sqlvuR7fk5xtOsh/+Ze8lofVds2VFoiWZt7WC/BNhGgei2wUAhZRp+/pm w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622762"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622762"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714798496"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714798496"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:18:19 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 26/70] i386/tdx: Initialize TDX before creating TD vcpus
Date: Wed, 15 Nov 2023 02:14:35 -0500
Message-Id: <20231115071519.2864957-27-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Invoke KVM_TDX_INIT in kvm_arch_pre_create_vcpu() that KVM_TDX_INIT
configures global TD configurations, e.g. the canonical CPUID config,
and must be executed prior to creating vCPUs.

Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.

Note, this doesn't address the fact that QEMU may change the CPUID
configuration when creating vCPUs, i.e. punts on refactoring QEMU to
provide a stable CPUID config prior to kvm_arch_init().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v3:
- Pass @errp in tdx_pre_create_vcpu() and pass error info to it. (Daniel)
---
 accel/kvm/kvm-all.c        |  9 +++++++-
 target/i386/kvm/kvm.c      |  9 ++++++++
 target/i386/kvm/tdx-stub.c |  5 +++++
 target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      |  4 ++++
 5 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6b5f4d62f961..a92fff471b58 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -441,8 +441,15 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
+    /*
+     * tdx_pre_create_vcpu() may call cpu_x86_cpuid(). It in turn may call
+     * kvm_vm_ioctl(). Set cpu->kvm_state in advance to avoid NULL pointer
+     * dereference.
+     */
+    cpu->kvm_state = s;
     ret = kvm_arch_pre_create_vcpu(cpu, errp);
     if (ret < 0) {
+        cpu->kvm_state = NULL;
         goto err;
     }
 
@@ -450,11 +457,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     if (ret < 0) {
         error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
                          kvm_arch_vcpu_id(cpu));
+        cpu->kvm_state = NULL;
         goto err;
     }
 
     cpu->kvm_fd = ret;
-    cpu->kvm_state = s;
     cpu->vcpu_dirty = true;
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dafe4d262977..fc840653ceb6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2268,6 +2268,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return r;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    if (is_tdx_vm()) {
+        return tdx_pre_create_vcpu(cpu, errp);
+    }
+
+    return 0;
+}
+
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 1d866d5496bf..3877d432a397 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -6,3 +6,8 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
 {
     return -EINVAL;
 }
+
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1f5d8117d1a9..122a37c93de3 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -467,6 +467,49 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
     return 0;
 }
 
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct kvm_tdx_init_vm *init_vm;
+    int r = 0;
+
+    qemu_mutex_lock(&tdx_guest->lock);
+    if (tdx_guest->initialized) {
+        goto out;
+    }
+
+    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
+                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
+
+    r = kvm_vm_enable_cap(kvm_state, KVM_CAP_MAX_VCPUS, 0, ms->smp.cpus);
+    if (r < 0) {
+        error_setg(errp, "Unable to set MAX VCPUS to %d", ms->smp.cpus);
+        goto out_free;
+    }
+
+    init_vm->cpuid.nent = kvm_x86_arch_cpuid(env, init_vm->cpuid.entries, 0);
+
+    init_vm->attributes = tdx_guest->attributes;
+
+    do {
+        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
+    } while (r == -EAGAIN);
+    if (r < 0) {
+        error_setg_errno(errp, -r, "KVM_TDX_INIT_VM failed");
+        goto out_free;
+    }
+
+    tdx_guest->initialized = true;
+
+out_free:
+    g_free(init_vm);
+out:
+    qemu_mutex_unlock(&tdx_guest->lock);
+    return r;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -479,6 +522,8 @@ static void tdx_guest_init(Object *obj)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
 
+    qemu_mutex_init(&tdx->lock);
+
     tdx->attributes = 0;
 }
 
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 06599b65b827..432077723ac5 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -17,6 +17,9 @@ typedef struct TdxGuestClass {
 typedef struct TdxGuest {
     ConfidentialGuestSupport parent_obj;
 
+    QemuMutex lock;
+
+    bool initialized;
     uint64_t attributes;    /* TD attributes */
 } TdxGuest;
 
@@ -29,5 +32,6 @@ bool is_tdx_vm(void);
 int tdx_kvm_init(MachineState *ms, Error **errp);
 void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
                              uint32_t *ret);
+int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


