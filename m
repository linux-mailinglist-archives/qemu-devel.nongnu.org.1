Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A985A0B106
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 09:26:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFlk-0002MB-V9; Mon, 13 Jan 2025 03:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXFlL-0002Ls-VG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:25:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXFlJ-0002MZ-0g
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736756726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xFEN9TlefhyYrQ1mTrfyTpl/j7YjywRg75PKg5OFOe8=;
 b=EXfjeu0cQmPehHHKcodq+3SAFRHnGpYQlwnmwP+3QvjzygfwyZ5tXVeIkvdj304fdP1W6s
 yu09Ix7lwPcHmlZpbofANu+/5M1MGH1Vbz6A8sxBDsa3REXfQnYqVD8c/T3mDyXB/3P9GN
 sqktY6DTBL1pXy3GAILSoeiFI6j9NEE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-6sL7LVqjNCSAuTC1hH38oA-1; Mon,
 13 Jan 2025 03:25:21 -0500
X-MC-Unique: 6sL7LVqjNCSAuTC1hH38oA-1
X-Mimecast-MFC-AGG-ID: 6sL7LVqjNCSAuTC1hH38oA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15A91956056; Mon, 13 Jan 2025 08:25:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.194])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36E811956056; Mon, 13 Jan 2025 08:25:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>
Subject: [PATCH v2] tests/functional: Convert the kvm_xen_guest avocado test
Date: Mon, 13 Jan 2025 09:25:15 +0100
Message-ID: <20250113082516.57894-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the serial console to execute the commands in the guest instead
of using ssh since we don't have ssh support in the functional
framework yet.

Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Add "quiet" to KERNEL_DEFAULT to avoid races on the serial console

 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  2 +
 .../test_x86_64_kvm_xen.py}                   | 83 +++++++++++--------
 3 files changed, 52 insertions(+), 35 deletions(-)
 rename tests/{avocado/kvm_xen_guest.py => functional/test_x86_64_kvm_xen.py} (64%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ec8ff6b3a..045eb206bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -486,7 +486,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
-F: tests/avocado/kvm_xen_guest.py
+F: tests/functional/test_x86_64_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
 ------------------------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f47366ee3d..7974814d6b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -42,6 +42,7 @@ test_timeouts = {
   'riscv64_tuxrun' : 120,
   's390x_ccw_virtio' : 420,
   'sh4_tuxrun' : 240,
+  'x86_64_kvm_xen' : 180,
 }
 
 tests_generic_system = [
@@ -267,6 +268,7 @@ tests_x86_64_system_thorough = [
   'netdev_ethtool',
   'virtio_gpu',
   'x86_64_hotplug_cpu',
+  'x86_64_kvm_xen',
   'x86_64_tuxrun',
 ]
 
diff --git a/tests/avocado/kvm_xen_guest.py b/tests/functional/test_x86_64_kvm_xen.py
old mode 100644
new mode 100755
similarity index 64%
rename from tests/avocado/kvm_xen_guest.py
rename to tests/functional/test_x86_64_kvm_xen.py
index f8cb458d5d..273c1e69fb
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # KVM Xen guest functional tests
 #
 # Copyright © 2021 Red Hat, Inc.
@@ -13,19 +15,12 @@
 
 from qemu.machine import machine
 
-from avocado_qemu import LinuxSSHMixIn
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 
-class KVMXenGuest(QemuSystemTest, LinuxSSHMixIn):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:q35
-    :avocado: tags=accel:kvm
-    :avocado: tags=kvm_xen_guest
-    """
+class KVMXenGuest(QemuSystemTest):
 
-    KERNEL_DEFAULT = 'printk.time=0 root=/dev/xvda console=ttyS0'
+    KERNEL_DEFAULT = 'printk.time=0 root=/dev/xvda console=ttyS0 quiet'
 
     kernel_path = None
     kernel_params = None
@@ -33,14 +28,15 @@ class KVMXenGuest(QemuSystemTest, LinuxSSHMixIn):
     # Fetch assets from the kvm-xen-guest subdir of my shared test
     # images directory on fileserver.linaro.org where you can find
     # build instructions for how they where assembled.
-    def get_asset(self, name, sha1):
-        base_url = ('https://fileserver.linaro.org/s/'
-                    'kE4nCFLdQcoBF9t/download?'
-                    'path=%2Fkvm-xen-guest&files=' )
-        url = base_url + name
-        # use explicit name rather than failing to neatly parse the
-        # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+    ASSET_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
+         'path=%2Fkvm-xen-guest&files=bzImage'),
+        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset(
+        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
+         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
+        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
@@ -51,10 +47,8 @@ def common_vm_setup(self):
         self.vm.add_args("-accel", "kvm,xen-version=0x4000a,kernel-irqchip=split")
         self.vm.add_args("-smp", "2")
 
-        self.kernel_path = self.get_asset("bzImage",
-                                          "367962983d0d32109998a70b45dcee4672d0b045")
-        self.rootfs = self.get_asset("rootfs.ext4",
-                                     "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.rootfs = self.ASSET_ROOTFS.fetch()
 
     def run_and_check(self):
         self.vm.add_args('-kernel', self.kernel_path,
@@ -79,10 +73,11 @@ def run_and_check(self):
         console_pattern = 'Starting dropbear sshd: OK'
         wait_for_console_pattern(self, console_pattern, 'Oops')
         self.log.info('sshd ready')
-        self.ssh_connect('root', '', False)
 
-        self.ssh_command('cat /proc/cmdline')
-        self.ssh_command('dmesg | grep -e "Grant table initialized"')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline', 'xen')
+        exec_command_and_wait_for_pattern(self, 'dmesg | grep "Grant table"',
+                                          'Grant table initialized')
+        wait_for_console_pattern(self, '#', 'Oops')
 
     def test_kvm_xen_guest(self):
         """
@@ -94,7 +89,9 @@ def test_kvm_xen_guest(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq.*msi /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq.*msi /proc/interrupts',
+                                'virtio0-output')
 
     def test_kvm_xen_guest_nomsi(self):
         """
@@ -106,7 +103,9 @@ def test_kvm_xen_guest_nomsi(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks pci=nomsi')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq.* /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq.* /proc/interrupts',
+                                'virtio0')
 
     def test_kvm_xen_guest_noapic_nomsi(self):
         """
@@ -118,7 +117,9 @@ def test_kvm_xen_guest_noapic_nomsi(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks noapic pci=nomsi')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq /proc/interrupts',
+                                'virtio0')
 
     def test_kvm_xen_guest_vapic(self):
         """
@@ -130,8 +131,13 @@ def test_kvm_xen_guest_vapic(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq /proc/interrupts')
-        self.ssh_command('grep PCI-MSI /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq /proc/interrupts',
+                                'acpi')
+        wait_for_console_pattern(self, '#')
+        exec_command_and_wait_for_pattern(self,
+                                'grep PCI-MSI /proc/interrupts',
+                                'virtio0-output')
 
     def test_kvm_xen_guest_novector(self):
         """
@@ -143,7 +149,9 @@ def test_kvm_xen_guest_novector(self):
                               ' xen_emul_unplug=ide-disks' +
                               ' xen_no_vector_callback')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'fasteoi')
 
     def test_kvm_xen_guest_novector_nomsi(self):
         """
@@ -156,7 +164,9 @@ def test_kvm_xen_guest_novector_nomsi(self):
                               ' xen_emul_unplug=ide-disks pci=nomsi' +
                               ' xen_no_vector_callback')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'IO-APIC')
 
     def test_kvm_xen_guest_novector_noapic(self):
         """
@@ -168,4 +178,9 @@ def test_kvm_xen_guest_novector_noapic(self):
                               ' xen_emul_unplug=ide-disks' +
                               ' xen_no_vector_callback noapic')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'XT-PIC')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.47.1


