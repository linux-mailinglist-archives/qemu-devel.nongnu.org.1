Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44DD832C4E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:26:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkB-0002HG-El; Fri, 19 Jan 2024 10:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk9-0002Gl-Cm
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk7-00018W-M1
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKLvOD11JrYTwE+r/+i24Roob614JvuQWcM+pDlJsLI=;
 b=RvTiqoY9NqYf/mHcEZXXLj8ELsSWf5kXWEedwsTJczefQmiCjZjsqUGayKmy2DsCFkNmRk
 64DpjplbKEJnWh+u3fkm9T6JFF3m4wz3S5f1aW+vjWtPBHX2auM+px8+tAoK9NrFeURaM9
 P1zHpvRjFHdTVJR6mLBzmfI69MYPFws=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-ybEAZrPbOUWFd94WCiSn0A-1; Fri,
 19 Jan 2024 10:25:11 -0500
X-MC-Unique: ybEAZrPbOUWFd94WCiSn0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF9D5383CD80;
 Fri, 19 Jan 2024 15:25:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97C8740C95AD;
 Fri, 19 Jan 2024 15:25:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/11] s390x/pci: avoid double enable/disable of aif
Date: Fri, 19 Jan 2024 16:24:57 +0100
Message-ID: <20240119152507.55182-2-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/hw/s390x/s390-pci-bus.h |  1 +
 hw/s390x/s390-pci-kvm.c         | 25 +++++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

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
-- 
2.43.0


