Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06483939B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:49:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJ1i-000694-R4; Tue, 23 Jan 2024 10:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSJ0i-0003Ry-SE; Tue, 23 Jan 2024 10:48:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSJ0h-0000oi-5E; Tue, 23 Jan 2024 10:48:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ACA2B4692B;
 Tue, 23 Jan 2024 18:47:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C5A5469EBA;
 Tue, 23 Jan 2024 18:47:11 +0300 (MSK)
Received: (nullmailer pid 3847936 invoked by uid 1000);
 Tue, 23 Jan 2024 15:47:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 52/54] s390x/pci: avoid double enable/disable of aif
Date: Tue, 23 Jan 2024 18:46:53 +0300
Message-Id: <20240123154708.3847837-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240123123124@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Use a flag to keep track of whether AIF is currently enabled.  This can be
used to avoid enabling/disabling AIF multiple times as well as to determine
whether or not it should be disabled during reset processing.

Fixes: d0bc7091c2 ("s390x/pci: enable adapter event notification for interpreted devices")
Reported-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20240118185151.265329-2-mjrosato@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 07b2c8e034d80ff92e202405c494d2ff80fcf848)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index ff41e4106d..1ee510436c 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -27,6 +27,7 @@ bool s390_pci_kvm_interp_allowed(void)
 
 int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
 {
+    int rc;
     struct kvm_s390_zpci_op args = {
         .fh = pbdev->fh,
         .op = KVM_S390_ZPCIOP_REG_AEN,
@@ -38,15 +39,35 @@ int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist)
         .u.reg_aen.flags = (assist) ? 0 : KVM_S390_ZPCIOP_REGAEN_HOST
     };
 
-    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (pbdev->aif) {
+        return -EINVAL;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (rc == 0) {
+        pbdev->aif = true;
+    }
+
+    return rc;
 }
 
 int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
 {
+    int rc;
+
     struct kvm_s390_zpci_op args = {
         .fh = pbdev->fh,
         .op = KVM_S390_ZPCIOP_DEREG_AEN
     };
 
-    return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (!pbdev->aif) {
+        return -EINVAL;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
+    if (rc == 0) {
+        pbdev->aif = false;
+    }
+
+    return rc;
 }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index b1bdbeaeb5..435e788867 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -361,6 +361,7 @@ struct S390PCIBusDevice {
     bool unplug_requested;
     bool interp;
     bool forwarding_assist;
+    bool aif;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
-- 
2.39.2


