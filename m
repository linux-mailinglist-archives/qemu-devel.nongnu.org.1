Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A035BA9814B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfX-0003Yf-Fl; Wed, 23 Apr 2025 03:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfT-0003VZ-Ue
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UfP-0003K8-Em
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0emzPW6NvZSJLz3dV5t6+/JjM51H7IL5Y1yOyWnVSc=;
 b=ay4rRjqsYnWBgsT01DV3VUgGcMZeCZb6TGxr69WenRr50S5PRjSyd+AURcYBQgsnzJ1/CB
 DrQJc97BJA1ZcsN1qR1YqXXQ8IxlCaMB6/708/lSF5ry5HpfVv2R3gn0BR74ZvYsvkBYvR
 A/+MicdO/mCbzjnysvEigaEWMGuMTkM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-qLVdGVw0P2i9-d10Pq7dmg-1; Wed,
 23 Apr 2025 03:37:07 -0400
X-MC-Unique: qLVdGVw0P2i9-d10Pq7dmg-1
X-Mimecast-MFC-AGG-ID: qLVdGVw0P2i9-d10Pq7dmg_1745393826
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17848180087A; Wed, 23 Apr 2025 07:37:06 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43AE519560A3; Wed, 23 Apr 2025 07:37:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 23/29] tests/functional: Convert the SMMU test to the
 functional framework
Date: Wed, 23 Apr 2025 09:36:03 +0200
Message-ID: <20250423073610.271585-24-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

This test was using cloudinit and a "dnf install" command in the guest
to exercise the NIC with SMMU enabled. Since we don't have the cloudinit
stuff in the functional framework and we should not rely on having access
to external networks (once our ASSETs have been cached), we rather boot
into the initrd first, manually mount the root disk and then use the
check_http_download() function from the functional framework here instead
for testing whether the network works as expected.

Unfortunately, there seems to be a small race when using the files
from Fedora 33: To enter the initrd shell, we have to send a "return"
once. But it does not seem to work if we send it too early. Using a
sleep(0.2) makes it work reliably for me, but to make it even more
unlikely to trigger this situation, let's better limit the Fedora 33
tests to only run with KVM.

Finally, while we're at it, we also add some lines for testing writes
to the hard disk, as we already do it in the test_intel_iommu test.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20250414113031.151105-14-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                           |   2 +-
 tests/avocado/smmu.py                 | 139 -----------------
 tests/functional/meson.build          |   2 +
 tests/functional/test_aarch64_smmu.py | 205 ++++++++++++++++++++++++++
 4 files changed, 208 insertions(+), 140 deletions(-)
 delete mode 100644 tests/avocado/smmu.py
 create mode 100755 tests/functional/test_aarch64_smmu.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e29910cbd77..07f77c048e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -211,7 +211,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
-F: tests/avocado/smmu.py
+F: tests/functional/test_aarch64_smmu.py
 
 AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
diff --git a/tests/avocado/smmu.py b/tests/avocado/smmu.py
deleted file mode 100644
index 83fd79e922e..00000000000
--- a/tests/avocado/smmu.py
+++ /dev/null
@@ -1,139 +0,0 @@
-# SMMUv3 Functional tests
-#
-# Copyright (c) 2021 Red Hat, Inc.
-#
-# Author:
-#  Eric Auger <eric.auger@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-import os
-
-from avocado import skipUnless
-from avocado_qemu import BUILD_DIR
-from avocado_qemu.linuxtest import LinuxTest
-
-@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-class SMMU(LinuxTest):
-    """
-    :avocado: tags=accel:kvm
-    :avocado: tags=cpu:host
-    :avocado: tags=arch:aarch64
-    :avocado: tags=machine:virt
-    :avocado: tags=distro:fedora
-    :avocado: tags=smmu
-    :avocado: tags=flaky
-    """
-
-    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
-    kernel_path = None
-    initrd_path = None
-    kernel_params = None
-
-    def set_up_boot(self):
-        path = self.download_boot()
-        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
-                         'drive=drv0,id=virtio-disk0,bootindex=1,'
-                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
-        self.vm.add_args('-drive',
-                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
-
-    def setUp(self):
-        super(SMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
-
-    def common_vm_setup(self, custom_kernel=False):
-        self.require_accelerator("kvm")
-        self.vm.add_args("-accel", "kvm")
-        self.vm.add_args("-cpu", "host")
-        self.vm.add_args("-machine", "iommu=smmuv3")
-        self.vm.add_args("-d", "guest_errors")
-        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
-                         'edk2-aarch64-code.fd'))
-        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
-        self.vm.add_args('-object',
-                         'rng-random,id=rng0,filename=/dev/urandom')
-
-        if custom_kernel is False:
-            return
-
-        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
-        initrd_url = self.distro.pxeboot_url + 'initrd.img'
-        self.kernel_path = self.fetch_asset(kernel_url)
-        self.initrd_path = self.fetch_asset(initrd_url)
-
-    def run_and_check(self):
-        if self.kernel_path:
-            self.vm.add_args('-kernel', self.kernel_path,
-                             '-append', self.kernel_params,
-                             '-initrd', self.initrd_path)
-        self.launch_and_wait()
-        self.ssh_command('cat /proc/cmdline')
-        self.ssh_command('dnf -y install numactl-devel')
-
-
-    # 5.3 kernel without RIL #
-
-    def test_smmu_noril(self):
-        """
-        :avocado: tags=smmu_noril
-        :avocado: tags=smmu_noril_tests
-        :avocado: tags=distro_version:31
-        """
-        self.common_vm_setup()
-        self.run_and_check()
-
-    def test_smmu_noril_passthrough(self):
-        """
-        :avocado: tags=smmu_noril_passthrough
-        :avocado: tags=smmu_noril_tests
-        :avocado: tags=distro_version:31
-        """
-        self.common_vm_setup(True)
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' iommu.passthrough=on')
-        self.run_and_check()
-
-    def test_smmu_noril_nostrict(self):
-        """
-        :avocado: tags=smmu_noril_nostrict
-        :avocado: tags=smmu_noril_tests
-        :avocado: tags=distro_version:31
-        """
-        self.common_vm_setup(True)
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' iommu.strict=0')
-        self.run_and_check()
-
-    # 5.8 kernel featuring range invalidation
-    # >= v5.7 kernel
-
-    def test_smmu_ril(self):
-        """
-        :avocado: tags=smmu_ril
-        :avocado: tags=smmu_ril_tests
-        :avocado: tags=distro_version:33
-        """
-        self.common_vm_setup()
-        self.run_and_check()
-
-    def test_smmu_ril_passthrough(self):
-        """
-        :avocado: tags=smmu_ril_passthrough
-        :avocado: tags=smmu_ril_tests
-        :avocado: tags=distro_version:33
-        """
-        self.common_vm_setup(True)
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' iommu.passthrough=on')
-        self.run_and_check()
-
-    def test_smmu_ril_nostrict(self):
-        """
-        :avocado: tags=smmu_ril_nostrict
-        :avocado: tags=smmu_ril_tests
-        :avocado: tags=distro_version:33
-        """
-        self.common_vm_setup(True)
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' iommu.strict=0')
-        self.run_and_check()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 985ac5c27fe..b317ad42c5a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -18,6 +18,7 @@ test_timeouts = {
   'aarch64_rme_sbsaref' : 1200,
   'aarch64_sbsaref_alpine' : 1200,
   'aarch64_sbsaref_freebsd' : 720,
+  'aarch64_smmu' : 720,
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 360,
   'aarch64_virt_gpu' : 480,
@@ -88,6 +89,7 @@ tests_aarch64_system_thorough = [
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
+  'aarch64_smmu',
   'aarch64_tcg_plugins',
   'aarch64_tuxrun',
   'aarch64_virt',
diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
new file mode 100755
index 00000000000..c65d0f28178
--- /dev/null
+++ b/tests/functional/test_aarch64_smmu.py
@@ -0,0 +1,205 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# SMMUv3 Functional tests
+#
+# Copyright (c) 2021 Red Hat, Inc.
+#
+# Author:
+#  Eric Auger <eric.auger@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import time
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import BUILD_DIR
+from qemu.utils import kvm_available
+
+
+class SMMU(LinuxKernelTest):
+
+    default_kernel_params = ('earlyprintk=pl011,0x9000000 no_timer_check '
+                             'printk.time=1 rd_NO_PLYMOUTH net.ifnames=0 '
+                             'console=ttyAMA0 rd.rescue')
+    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
+    kernel_path = None
+    initrd_path = None
+    kernel_params = None
+
+    GUEST_PORT = 8080
+
+    def set_up_boot(self, path):
+        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
+                         'drive=drv0,id=virtio-disk0,bootindex=1,'
+                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
+        self.vm.add_args('-drive',
+                f'file={path},if=none,cache=writethrough,id=drv0,snapshot=on')
+
+        self.vm.add_args('-netdev',
+                         'user,id=n1,hostfwd=tcp:127.0.0.1:0-:%d' %
+                         self.GUEST_PORT)
+        self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
+
+    def common_vm_setup(self, kernel, initrd, disk):
+        self.require_accelerator("kvm")
+        self.require_netdev('user')
+        self.set_machine("virt")
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-cpu", "host")
+        self.vm.add_args("-machine", "iommu=smmuv3")
+        self.vm.add_args("-d", "guest_errors")
+        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
+                         'edk2-aarch64-code.fd'))
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
+        self.vm.add_args('-object',
+                         'rng-random,id=rng0,filename=/dev/urandom')
+
+        self.kernel_path = kernel.fetch()
+        self.initrd_path = initrd.fetch()
+        self.set_up_boot(disk.fetch())
+
+    def run_and_check(self, filename, hashsum):
+        self.vm.add_args('-initrd', self.initrd_path)
+        self.vm.add_args('-append', self.kernel_params)
+        self.launch_kernel(self.kernel_path, initrd=self.initrd_path,
+                           wait_for='attach it to a bug report.')
+        prompt = '# '
+        # Fedora 33 requires 'return' to be pressed to enter the shell.
+        # There seems to be a small race between detecting the previous ':'
+        # and sending the newline, so we need to add a small delay here.
+        self.wait_for_console_pattern(':')
+        time.sleep(0.2)
+        exec_command_and_wait_for_pattern(self, '\n', prompt)
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline',
+                                          self.kernel_params)
+
+        # Checking for SMMU enablement:
+        self.log.info("Checking whether SMMU has been enabled...")
+        exec_command_and_wait_for_pattern(self, 'dmesg | grep smmu',
+                                          'arm-smmu-v3')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self,
+                                    'find /sys/kernel/iommu_groups/ -type l',
+                                    'devices/0000:00:')
+        self.wait_for_console_pattern(prompt)
+
+        # Copy a file (checked later), umount afterwards to drop disk cache:
+        self.log.info("Checking hard disk...")
+        exec_command_and_wait_for_pattern(self,
+                        "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done",
+                        "vda2")
+        exec_command_and_wait_for_pattern(self, 'mount /dev/vda2 /sysroot',
+                                          'mounted filesystem')
+        exec_command_and_wait_for_pattern(self, 'cp /bin/vi /sysroot/root/vi',
+                                          prompt)
+        exec_command_and_wait_for_pattern(self, 'umount /sysroot', prompt)
+        # Switch from initrd to the cloud image filesystem:
+        exec_command_and_wait_for_pattern(self, 'mount /dev/vda2 /sysroot',
+                                          prompt)
+        exec_command_and_wait_for_pattern(self,
+                ('for d in dev proc sys run ; do '
+                 'mount -o bind /$d /sysroot/$d ; done'), prompt)
+        exec_command_and_wait_for_pattern(self, 'chroot /sysroot', prompt)
+        # Check files on the hard disk:
+        exec_command_and_wait_for_pattern(self,
+            ('if diff -q /root/vi /usr/bin/vi ; then echo "file" "ok" ; '
+             'else echo "files differ"; fi'), 'file ok')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self, f'sha256sum {filename}',
+                                          hashsum)
+
+        # Check virtio-net via HTTP:
+        exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
+        self.check_http_download(filename, hashsum, self.GUEST_PORT)
+
+
+    # 5.3 kernel without RIL #
+
+    ASSET_KERNEL_F31 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/31/Server/aarch64/os/images/pxeboot/vmlinuz'),
+        '3ae07fcafbfc8e4abeb693035a74fe10698faae15e9ccd48882a9167800c1527')
+
+    ASSET_INITRD_F31 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/31/Server/aarch64/os/images/pxeboot/initrd.img'),
+        '9f3146b28bc531c689f3c5f114cb74e4bd7bd548e0ba19fa77921d8bd256755a')
+
+    ASSET_DISK_F31 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Cloud/aarch64/images/Fedora-Cloud-Base-31-1.9.aarch64.qcow2'),
+        '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf16fe49')
+
+    F31_FILENAME = '/boot/initramfs-5.3.7-301.fc31.aarch64.img'
+    F31_HSUM = '1a4beec6607d94df73d9dd1b4985c9c23dd0fdcf4e6ca1351d477f190df7bef9'
+
+    def test_smmu_noril(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
+                             self.ASSET_DISK_F31)
+        self.kernel_params = self.default_kernel_params
+        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
+
+    def test_smmu_noril_passthrough(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
+                             self.ASSET_DISK_F31)
+        self.kernel_params = (self.default_kernel_params +
+                              ' iommu.passthrough=on')
+        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
+
+    def test_smmu_noril_nostrict(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F31, self.ASSET_INITRD_F31,
+                             self.ASSET_DISK_F31)
+        self.kernel_params = (self.default_kernel_params +
+                              ' iommu.strict=0')
+        self.run_and_check(self.F31_FILENAME, self.F31_HSUM)
+
+
+    # 5.8 kernel featuring range invalidation
+    # >= v5.7 kernel
+
+    ASSET_KERNEL_F33 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/33/Server/aarch64/os/images/pxeboot/vmlinuz'),
+        'd8b1e6f7241f339d8e7609c456cf0461ffa4583ed07e0b55c7d1d8a0c154aa89')
+
+    ASSET_INITRD_F33 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/33/Server/aarch64/os/images/pxeboot/initrd.img'),
+        '92513f55295c2c16a777f7b6c35ccd70a438e9e1e40b6ba39e0e60900615b3df')
+
+    ASSET_DISK_F33 = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/33/Cloud/aarch64/images/Fedora-Cloud-Base-33-1.2.aarch64.qcow2'),
+        'e7f75cdfd523fe5ac2ca9eeece68edc1a81f386a17f969c1d1c7c87031008a6b')
+
+    F33_FILENAME = '/boot/initramfs-5.8.15-301.fc33.aarch64.img'
+    F33_HSUM = '079cfad0caa82e84c8ca1fb0897a4999dd769f262216099f518619e807a550d9'
+
+    def test_smmu_ril(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
+                             self.ASSET_DISK_F33)
+        self.kernel_params = self.default_kernel_params
+        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
+
+    def test_smmu_ril_passthrough(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
+                             self.ASSET_DISK_F33)
+        self.kernel_params = (self.default_kernel_params +
+                              ' iommu.passthrough=on')
+        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
+
+    def test_smmu_ril_nostrict(self):
+        self.common_vm_setup(self.ASSET_KERNEL_F33, self.ASSET_INITRD_F33,
+                             self.ASSET_DISK_F33)
+        self.kernel_params = (self.default_kernel_params +
+                              ' iommu.strict=0')
+        self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.49.0


