Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8159A66B7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Oct 2024 13:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhI-0002AE-AO; Mon, 21 Oct 2024 07:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh3-000274-SR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh1-0001hb-GE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJYtZo1vXIjtDGHa6evZDZF+F/vY/lnYUsfFw11/hpw=;
 b=VjxtVps9YULEOdMNUwt3UKr5cleNmeuauCq53NAzhv3Lvo1+/8h154+Yg+DpzB/Vkxo2WI
 tglEDfdIwAYDGKlJq8G0FZdmywyRNQRw2Pgo7Fyby/acN2ODkHIufVxoifJPcIDnVwTJ97
 swI3ajmvpnnOEaIOIwuoijv8h8A2/BY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-vyLTX4jeOJqpk2vJm6Zeog-1; Mon,
 21 Oct 2024 07:35:21 -0400
X-MC-Unique: vyLTX4jeOJqpk2vJm6Zeog-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42B3519560AA; Mon, 21 Oct 2024 11:35:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0947619560AA; Mon, 21 Oct 2024 11:35:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/21] tests/functional: Convert the Avocado ppc64 tuxrun tests
Date: Mon, 21 Oct 2024 13:34:43 +0200
Message-ID: <20241021113500.122500-7-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Move the tests to a new file so that they can be run via
qemu-system-ppc64 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-3-thuth@redhat.com>
---
 MAINTAINERS                           |   1 +
 tests/avocado/tuxrun_baselines.py     |  92 ---------------------
 tests/functional/test_ppc64_tuxrun.py | 110 ++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 92 deletions(-)
 create mode 100755 tests/functional/test_ppc64_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d1a9959031..8f4a58f850 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1484,6 +1484,7 @@ F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
 F: tests/functional/test_ppc64_pseries.py
 F: tests/functional/test_ppc64_hv.py
+F: tests/functional/test_ppc64_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Cédric Le Goater <clg@kaod.org>
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 736e4aa289..56c8bdb2dc 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -182,63 +182,6 @@ def common_tuxrun(self,
         self.vm.launch()
         self.run_tuxtest_tests(haltmsg)
 
-    def ppc64_common_tuxrun(self, sums, prefix):
-        # add device args to command line.
-        self.require_netdev('user')
-        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
-                         '-device', 'virtio-net,netdev=vnet')
-        self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',
-                         '-device', '{"driver":"virtio-net-pci","netdev":'
-                         '"hostnet0","id":"net0","mac":"52:54:00:4c:e3:86",'
-                         '"bus":"pci.0","addr":"0x9"}')
-        self.vm.add_args('-device', '{"driver":"qemu-xhci","p2":15,"p3":15,'
-                         '"id":"usb","bus":"pci.0","addr":"0x2"}')
-        self.vm.add_args('-device', '{"driver":"virtio-scsi-pci","id":"scsi0"'
-                         ',"bus":"pci.0","addr":"0x3"}')
-        self.vm.add_args('-device', '{"driver":"virtio-serial-pci","id":'
-                         '"virtio-serial0","bus":"pci.0","addr":"0x4"}')
-        self.vm.add_args('-device', '{"driver":"scsi-cd","bus":"scsi0.0"'
-                         ',"channel":0,"scsi-id":0,"lun":0,"device_id":'
-                         '"drive-scsi0-0-0-0","id":"scsi0-0-0-0"}')
-        self.vm.add_args('-device', '{"driver":"virtio-balloon-pci",'
-                         '"id":"balloon0","bus":"pci.0","addr":"0x6"}')
-        self.vm.add_args('-audiodev', '{"id":"audio1","driver":"none"}')
-        self.vm.add_args('-device', '{"driver":"usb-tablet","id":"input0"'
-                         ',"bus":"usb.0","port":"1"}')
-        self.vm.add_args('-device', '{"driver":"usb-kbd","id":"input1"'
-                         ',"bus":"usb.0","port":"2"}')
-        self.vm.add_args('-device', '{"driver":"VGA","id":"video0",'
-                         '"vgamem_mb":16,"bus":"pci.0","addr":"0x7"}')
-        self.vm.add_args('-object', '{"qom-type":"rng-random","id":"objrng0"'
-                         ',"filename":"/dev/urandom"}',
-                         '-device', '{"driver":"virtio-rng-pci","rng":"objrng0"'
-                         ',"id":"rng0","bus":"pci.0","addr":"0x8"}')
-        self.vm.add_args('-object', '{"qom-type":"cryptodev-backend-builtin",'
-                         '"id":"objcrypto0","queues":1}',
-                         '-device', '{"driver":"virtio-crypto-pci",'
-                         '"cryptodev":"objcrypto0","id":"crypto0","bus"'
-                         ':"pci.0","addr":"0xa"}')
-        self.vm.add_args('-device', '{"driver":"spapr-pci-host-bridge"'
-                         ',"index":1,"id":"pci.1"}')
-        self.vm.add_args('-device', '{"driver":"spapr-vscsi","id":"scsi1"'
-                         ',"reg":12288}')
-        self.vm.add_args('-m', '2G,slots=32,maxmem=4G',
-                         '-object', 'memory-backend-ram,id=ram1,size=1G',
-                         '-device', 'pc-dimm,id=dimm1,memdev=ram1')
-
-        # Create a temporary qcow2 and launch the test-case
-        with tempfile.NamedTemporaryFile(prefix=prefix,
-                                         suffix='.qcow2') as qcow2:
-            process.run(self.qemu_img + ' create -f qcow2 ' +
-                        qcow2.name + ' 1G')
-
-            self.vm.add_args('-drive', 'file=' + qcow2.name +
-                         ',format=qcow2,if=none,id='
-                         'drive-virtio-disk1',
-                         '-device', 'virtio-blk-pci,bus=pci.0,'
-                         'addr=0xb,drive=drive-virtio-disk1,id=virtio-disk1'
-                         ',bootindex=2')
-            self.common_tuxrun(csums=sums, drive="scsi-hd")
 
     #
     # The tests themselves. The configuration is derived from how
@@ -436,41 +379,6 @@ def test_ppc32(self):
 
         self.common_tuxrun(csums=sums, drive="virtio-blk-pci")
 
-    def test_ppc64(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=cpu:POWER10
-        :avocado: tags=endian:big
-        :avocado: tags=console:hvc0
-        :avocado: tags=tuxboot:ppc64
-        :avocado: tags=image:vmlinux
-        :avocado: tags=extradev:driver=spapr-vscsi
-        :avocado: tags=root:sda
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff",
-                 "vmlinux" :
-                 "f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728" }
-        self.ppc64_common_tuxrun(sums, prefix='tuxrun_ppc64_')
-
-    def test_ppc64le(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=cpu:POWER10
-        :avocado: tags=console:hvc0
-        :avocado: tags=tuxboot:ppc64le
-        :avocado: tags=image:vmlinux
-        :avocado: tags=extradev:driver=spapr-vscsi
-        :avocado: tags=root:sda
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "b442678c93fb8abe1f7d3bfa20556488de6b475c22c8fed363f42cf81a0a3906",
-                 "vmlinux" :
-                 "979eb61b445a010fb13e2b927126991f8ceef9c590fa2be0996c00e293e80cf2" }
-        self.ppc64_common_tuxrun(sums, prefix='tuxrun_ppc64le_')
-
     def test_riscv32(self):
         """
         :avocado: tags=arch:riscv32
diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
new file mode 100755
index 0000000000..552b53c97a
--- /dev/null
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -0,0 +1,110 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots known good tuxboot images the same way
+# that tuxrun (www.tuxrun.org) does. This tool is used by things like
+# the LKFT project to run regression tests on kernels.
+#
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import tempfile
+
+from qemu_test import run_cmd, Asset
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunPPC64Test(TuxRunBaselineTest):
+
+    def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
+        self.set_machine('pseries')
+        self.cpu='POWER10'
+        self.console='hvc0'
+        self.root='sda'
+        self.extradev='spapr-vscsi'
+        # add device args to command line.
+        self.require_netdev('user')
+        self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
+                         '-device', 'virtio-net,netdev=vnet')
+        self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',
+                         '-device', '{"driver":"virtio-net-pci","netdev":'
+                         '"hostnet0","id":"net0","mac":"52:54:00:4c:e3:86",'
+                         '"bus":"pci.0","addr":"0x9"}')
+        self.vm.add_args('-device', '{"driver":"qemu-xhci","p2":15,"p3":15,'
+                         '"id":"usb","bus":"pci.0","addr":"0x2"}')
+        self.vm.add_args('-device', '{"driver":"virtio-scsi-pci","id":"scsi0"'
+                         ',"bus":"pci.0","addr":"0x3"}')
+        self.vm.add_args('-device', '{"driver":"virtio-serial-pci","id":'
+                         '"virtio-serial0","bus":"pci.0","addr":"0x4"}')
+        self.vm.add_args('-device', '{"driver":"scsi-cd","bus":"scsi0.0"'
+                         ',"channel":0,"scsi-id":0,"lun":0,"device_id":'
+                         '"drive-scsi0-0-0-0","id":"scsi0-0-0-0"}')
+        self.vm.add_args('-device', '{"driver":"virtio-balloon-pci",'
+                         '"id":"balloon0","bus":"pci.0","addr":"0x6"}')
+        self.vm.add_args('-audiodev', '{"id":"audio1","driver":"none"}')
+        self.vm.add_args('-device', '{"driver":"usb-tablet","id":"input0"'
+                         ',"bus":"usb.0","port":"1"}')
+        self.vm.add_args('-device', '{"driver":"usb-kbd","id":"input1"'
+                         ',"bus":"usb.0","port":"2"}')
+        self.vm.add_args('-device', '{"driver":"VGA","id":"video0",'
+                         '"vgamem_mb":16,"bus":"pci.0","addr":"0x7"}')
+        self.vm.add_args('-object', '{"qom-type":"rng-random","id":"objrng0"'
+                         ',"filename":"/dev/urandom"}',
+                         '-device', '{"driver":"virtio-rng-pci","rng":"objrng0"'
+                         ',"id":"rng0","bus":"pci.0","addr":"0x8"}')
+        self.vm.add_args('-object', '{"qom-type":"cryptodev-backend-builtin",'
+                         '"id":"objcrypto0","queues":1}',
+                         '-device', '{"driver":"virtio-crypto-pci",'
+                         '"cryptodev":"objcrypto0","id":"crypto0","bus"'
+                         ':"pci.0","addr":"0xa"}')
+        self.vm.add_args('-device', '{"driver":"spapr-pci-host-bridge"'
+                         ',"index":1,"id":"pci.1"}')
+        self.vm.add_args('-device', '{"driver":"spapr-vscsi","id":"scsi1"'
+                         ',"reg":12288}')
+        self.vm.add_args('-m', '2G,slots=32,maxmem=4G',
+                         '-object', 'memory-backend-ram,id=ram1,size=1G',
+                         '-device', 'pc-dimm,id=dimm1,memdev=ram1')
+
+        # Create a temporary qcow2 and launch the test-case
+        with tempfile.NamedTemporaryFile(prefix=prefix,
+                                         suffix='.qcow2') as qcow2:
+            run_cmd([self.qemu_img, 'create', '-f', 'qcow2', qcow2.name, ' 1G'])
+
+            self.vm.add_args('-drive', 'file=' + qcow2.name +
+                         ',format=qcow2,if=none,id='
+                         'drive-virtio-disk1',
+                         '-device', 'virtio-blk-pci,bus=pci.0,'
+                         'addr=0xb,drive=drive-virtio-disk1,id=virtio-disk1'
+                         ',bootindex=2')
+            self.common_tuxrun(kernel_asset, rootfs_asset=rootfs_asset,
+                               drive="scsi-hd")
+
+    ASSET_PPC64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/ppc64/vmlinux',
+        '1d953e81a4379e537fc8e41e05a0a59d9b453eef97aa03d47866c6c45b00bdff')
+    ASSET_PPC64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/ppc64/rootfs.ext4.zst',
+        'f22a9b9e924174a4c199f4c7e5d91a2339fcfe51c6eafd0907dc3e09b64ab728')
+
+    def test_ppc64(self):
+        self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64_KERNEL,
+                                 rootfs_asset=self.ASSET_PPC64_ROOTFS,
+                                 prefix='tuxrun_ppc64_')
+
+    ASSET_PPC64LE_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/ppc64le/vmlinux',
+        '979eb61b445a010fb13e2b927126991f8ceef9c590fa2be0996c00e293e80cf2')
+    ASSET_PPC64LE_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/ppc64le/rootfs.ext4.zst',
+        'b442678c93fb8abe1f7d3bfa20556488de6b475c22c8fed363f42cf81a0a3906')
+
+    def test_ppc64le(self):
+        self.ppc64_common_tuxrun(kernel_asset=self.ASSET_PPC64LE_KERNEL,
+                                 rootfs_asset=self.ASSET_PPC64LE_ROOTFS,
+                                 prefix='tuxrun_ppc64le_')
+
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


