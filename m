Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F32980ACC1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBgFp-0000is-Qx; Fri, 08 Dec 2023 14:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFf-0000ds-Oe
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFb-0003ev-Cy
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702062661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtGy8l+fgmdQS+kFDaMnC380yWtdx1MWMjnafi+N5hE=;
 b=BKm2ux7n6YGOAWXpsmliPlRHUdsAcosh28pfVPdZgxRTO87f+5bZBffJ+1+7QJWYz51SzV
 sIur7w+kqgNW3zNWDSlyPXyAyzbHEqqUz4YR/zUsI6mj+DluBL24FvpMfJB4sJpKUDqtRm
 jNTFQP0vSkRAHDgXD8+0VTQ2rmdVg1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-NG8nsRIfMeOT9mJg1nEguw-1; Fri, 08 Dec 2023 14:09:41 -0500
X-MC-Unique: NG8nsRIfMeOT9mJg1nEguw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 271FE185A784;
 Fri,  8 Dec 2023 19:09:41 +0000 (UTC)
Received: from p1.localdomain.com (ovpn-114-104.gru2.redhat.com
 [10.97.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22DAB112131D;
 Fri,  8 Dec 2023 19:09:37 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
Date: Fri,  8 Dec 2023 14:09:07 -0500
Message-ID: <20231208190911.102879-7-crosa@redhat.com>
In-Reply-To: <20231208190911.102879-1-crosa@redhat.com>
References: <20231208190911.102879-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some of these tests actually require the root filesystem image,
obtained through Avocado's asset feature and kept in a common cache
location, to be writable.

This makes a distinction between the tests that actually have this
requirement and those who don't.  The goal is to be as safe as
possible, avoiding causing cache misses (because the assets get
modified and thus need to be dowloaded again) while avoid copying the
root filesystem backing file whenever possible.

This also allow these tests to be run in parallel with newer Avocado
versions.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/kvm_xen_guest.py | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
index ec4052a1fe..d73fa888ef 100644
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/avocado/kvm_xen_guest.py
@@ -10,6 +10,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+import shutil
 
 from qemu.machine import machine
 
@@ -43,7 +44,7 @@ def get_asset(self, name, sha1):
         return self.fetch_asset(name=f"qemu-kvm-xen-guest-{name}",
                                 locations=(url), asset_hash=sha1)
 
-    def common_vm_setup(self):
+    def common_vm_setup(self, readwrite=False):
         # We also catch lack of KVM_XEN support if we fail to launch
         self.require_accelerator("kvm")
 
@@ -56,11 +57,19 @@ def common_vm_setup(self):
                                           "367962983d0d32109998a70b45dcee4672d0b045")
         self.rootfs = self.get_asset("rootfs.ext4",
                                      "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
+        if readwrite:
+            dest = os.path.join(self.workdir, os.path.basename(self.rootfs))
+            shutil.copy(self.rootfs, dest)
+            self.rootfs = dest
 
-    def run_and_check(self):
+    def run_and_check(self, readwrite=False):
+        if readwrite:
+            drive = f"file={self.rootfs},if=none,format=raw,id=drv0"
+        else:
+            drive = f"file={self.rootfs},if=none,readonly=on,format=raw,id=drv0"
         self.vm.add_args('-kernel', self.kernel_path,
                          '-append', self.kernel_params,
-                         '-drive',  f"file={self.rootfs},if=none,format=raw,id=drv0",
+                         '-drive',  drive,
                          '-device', 'xen-disk,drive=drv0,vdev=xvda',
                          '-device', 'virtio-net-pci,netdev=unet',
                          '-netdev', 'user,id=unet,hostfwd=:127.0.0.1:0-:22')
@@ -90,11 +99,11 @@ def test_kvm_xen_guest(self):
         :avocado: tags=kvm_xen_guest
         """
 
-        self.common_vm_setup()
+        self.common_vm_setup(True)
 
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks')
-        self.run_and_check()
+        self.run_and_check(True)
         self.ssh_command('grep xen-pirq.*msi /proc/interrupts')
 
     def test_kvm_xen_guest_nomsi(self):
@@ -102,11 +111,11 @@ def test_kvm_xen_guest_nomsi(self):
         :avocado: tags=kvm_xen_guest_nomsi
         """
 
-        self.common_vm_setup()
+        self.common_vm_setup(True)
 
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks pci=nomsi')
-        self.run_and_check()
+        self.run_and_check(True)
         self.ssh_command('grep xen-pirq.* /proc/interrupts')
 
     def test_kvm_xen_guest_noapic_nomsi(self):
@@ -114,11 +123,11 @@ def test_kvm_xen_guest_noapic_nomsi(self):
         :avocado: tags=kvm_xen_guest_noapic_nomsi
         """
 
-        self.common_vm_setup()
+        self.common_vm_setup(True)
 
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks noapic pci=nomsi')
-        self.run_and_check()
+        self.run_and_check(True)
         self.ssh_command('grep xen-pirq /proc/interrupts')
 
     def test_kvm_xen_guest_vapic(self):
-- 
2.43.0


