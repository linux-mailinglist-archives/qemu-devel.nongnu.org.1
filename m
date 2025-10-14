Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD755BDA9F9
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 18:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hxJ-0006xL-JQ; Tue, 14 Oct 2025 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8hxF-0006x6-Hx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:32:53 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8hxB-0000lQ-EI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:32:53 -0400
DKIM-Signature: a=rsa-sha256; bh=A/t61K85+aS3zHtZ2WVX8OE59mwl8FA0e9zvZXDQF14=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1760459564; v=1;
 b=URQqxP4h8i6QEgOEVkv4JRgydSYJm6IE8vkg3EFxeu2nGic4WmhltPGBeHf7EJAycg7UJQPs
 z4Am+L1UGriQ2Zp/0S61NzeuRIgPdD75Poeij150/Ptp+82tP3wv9SqaaKgfS/sZiuKkvuc19cq
 gyBEQqg6mWyzqo2oas6oo9fwGbSWMxKVRY6cNnYRrisMVYyUd/okkf+T1pL5dc6eqvkmaHYju0V
 0YhRhoodp+07eJ9DtxI//U/Kxmbk78b0xLiyjPqn6BVRkTJYy18qwSY8qtWUJwpmZYK9w1iCJ7B
 W5iaNKlSpmGfWraUKcROBRBGkpSVA8aK9MelbG0J9D0dQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 9F0C32391D;
 Tue, 14 Oct 2025 16:32:44 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Tue, 14 Oct 2025 16:23:51 +0000
Subject: [PATCH qemu v8 1/1] Honor guest PAT on x86, absent Bochs display
Message-ID: <176045956423.5579.13349691093596703310-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <176045956423.5579.13349691093596703310-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: myrslint <qemu.haziness801@passinbox.com>

On x86_64, where most CPUs support self-snoop, it is preferrable to
always honor guest PAT. Not doing so is a quirk. There is a default
enabled KVM quirk flag which enforces not doing so due to a former bug
in Bochs display driver.

The bug has been fixed but not enough has yet passed since so we only
disable said quirk flag if a Bochs display is not configured for the
virtual machine.

This commit also moves around a bit of code that would be called when
the initialization of a VM is done.

Signed-off-by: myrslint <qemu.haziness801@passinbox.com>
---
 accel/kvm/kvm-all.c        |  1 +
 accel/stubs/kvm-stub.c     |  1 +
 hw/display/bochs-display.c | 17 +++++++++++++++
 include/system/kvm.h       |  9 ++++++++
 target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 58802f7c3c..b1ae36d6a1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -103,6 +103,7 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
+bool kvm_bochs_drm_quirk;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba97..a69c89e1ad 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -24,6 +24,7 @@ bool kvm_gsi_direct_mapping;
 bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_msi_use_devid;
+bool kvm_bochs_drm_quirk;
=20
 void kvm_flush_coalesced_mmio_buffer(void)
 {
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c974..e8def68b41 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -20,6 +20,8 @@
 #include "ui/qemu-pixman.h"
 #include "qom/object.h"
=20
+#include "system/kvm.h"
+
 typedef struct BochsDisplayMode {
     pixman_format_code_t format;
     uint32_t             bytepp;
@@ -309,6 +311,21 @@ static void bochs_display_realize(PCIDevice *dev, Error =
**errp)
     }
=20
     memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
+
+    /*
+     * On x86_64, where most CPUs support self-snoop, it is preferrable to
+     * always honor guest PAT. Not doing so is a quirk. There is a default
+     * enabled KVM quirk flag which enforces not doing so due to a former bug
+     * in Bochs display driver.
+     *
+     * The bug has been fixed but not enough has yet passed since so we only
+     * disable said quirk flag if a Bochs display is not configured for the
+     * virtual machine.
+     *
+     * The following flag tells KVM initialization code not to disable that
+     * quirk flag.
+     */
+    kvm_bochs_drm_quirk =3D true;
 }
=20
 static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 4fc09e3891..45ddb2e0ee 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -43,6 +43,7 @@ extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
 extern bool kvm_pre_fault_memory_supported;
+extern bool kvm_bochs_drm_quirk;
=20
 #define kvm_enabled()           (kvm_allowed)
 /**
@@ -144,6 +145,13 @@ extern bool kvm_pre_fault_memory_supported;
  */
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
=20
+/**
+ * kvm_has_bochs_drm:
+ * Returns: true if KVM is possible and a Bochs DRM driver is
+ * in use for display.
+ */
+#define kvm_has_bochs_drm() (kvm_bochs_drm_quirk)
+
 #else
=20
 #define kvm_enabled()           (0)
@@ -158,6 +166,7 @@ extern bool kvm_pre_fault_memory_supported;
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
 #define kvm_msi_devid_required() (false)
+#define kvm_has_bochs_drm() (false)
=20
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
=20
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index db40caa341..4d2a01ca0e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2692,13 +2692,13 @@ static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu,
     return true;
 }
=20
-static Notifier smram_machine_done;
+static Notifier kvm_machine_done;
 static KVMMemoryListener smram_listener;
 static AddressSpace smram_address_space;
 static MemoryRegion smram_as_root;
 static MemoryRegion smram_as_mem;
=20
-static void register_smram_listener(Notifier *n, void *unused)
+static void register_smram_listener(void)
 {
     CPUState *cpu;
     MemoryRegion *smram =3D
@@ -2731,6 +2731,37 @@ static void register_smram_listener(Notifier *n, void =
*unused)
     }
 }
=20
+static bool kvm_x86_smm_enabled(void)
+{
+    return object_dynamic_cast(OBJECT(current_machine), TYPE_X86_MACHINE) &&
+        x86_machine_is_smm_enabled(X86_MACHINE(current_machine));
+}
+
+static int kvm_x86_disable_quirsk2_mask(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_DISABLE_QUIRKS2);
+}
+
+static int kvm_disable_ignore_guest_pat(void)
+{
+    return kvm_vm_enable_cap(kvm_state, KVM_CAP_DISABLE_QUIRKS2, 0, \
+                             KVM_X86_QUIRK_IGNORE_GUEST_PAT);
+}
+
+static void handle_machine_done(Notifier *n, void *unused)
+{
+    if (kvm_x86_smm_enabled()) {
+        register_smram_listener();
+    }
+    if (!kvm_has_bochs_drm() && \
+        (kvm_x86_disable_quirsk2_mask() & KVM_X86_QUIRK_IGNORE_GUEST_PAT)) {
+        if (kvm_disable_ignore_guest_pat()) {
+            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                         "modifiable but we failed to disable it");
+        }
+    }
+}
+
 static void *kvm_msr_energy_thread(void *data)
 {
     KVMState *s =3D data;
@@ -3311,11 +3342,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
=20
-    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
-        smram_machine_done.notify =3D register_smram_listener;
-        qemu_add_machine_init_done_notifier(&smram_machine_done);
-    }
+    kvm_machine_done.notify =3D handle_machine_done;
+    qemu_add_machine_init_done_notifier(&kvm_machine_done);
=20
     if (enable_cpu_pm) {
         ret =3D kvm_vm_enable_disable_exits(s);
--=20
2.49.1

