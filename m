Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D797CDCC2
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6IK-0007Ch-BF; Wed, 18 Oct 2023 09:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HR-0004Yo-Cb
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HN-000828-AT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOY3fpgB5ggOII78QIxqnK0sbWPRh2pjhTv8MC8lKs4=;
 b=axaTFEKHLIi1IjNbzqO0DJMxAW0nqlMG4It4qBHiFGp1xO3CuPpOO92tlZn949uVihCBaG
 Nyple4DyBqMIZwFWsGDcct9kKmtTShLCy4hIuCuA0zbOdRt0Z+irXPuP8uP8PK8Kl9HI9R
 3KwEeFH6sxvoEag0bQ1RW5TYPq28QuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-fN2-SotxPfe1G6PVjtiMMQ-1; Wed, 18 Oct 2023 09:07:46 -0400
X-MC-Unique: fN2-SotxPfe1G6PVjtiMMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01F54185A797;
 Wed, 18 Oct 2023 13:07:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB92420268C8;
 Wed, 18 Oct 2023 13:07:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 16/25] tests/avocado: s390x cpu topology polarization
Date: Wed, 18 Oct 2023 15:07:07 +0200
Message-ID: <20231018130716.286638-17-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierre Morel <pmorel@linux.ibm.com>

Polarization is changed on a request from the guest.
Let's verify the polarization is accordingly set by QEMU.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-17-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/s390_topology.py | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 9078b45281..8166cee134 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -41,6 +41,7 @@ class S390CPUTopology(QemuSystemTest):
     The polarization is changed on a request from the guest.
     """
     timeout = 90
+    event_timeout = 10
 
     KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
                                   'root=/dev/ram '
@@ -103,6 +104,14 @@ def kernel_init(self):
                          '-initrd', initrd_path,
                          '-append', kernel_command_line)
 
+    def system_init(self):
+        self.log.info("System init")
+        exec_command_and_wait_for_pattern(self,
+                """ mount proc -t proc /proc;
+                    mount sys -t sysfs /sys;
+                    cat /sys/devices/system/cpu/dispatching """,
+                    '0')
+
     def test_single(self):
         """
         This test checks the simplest topology with a single CPU.
@@ -198,3 +207,39 @@ def test_dash_device(self):
         self.check_topology(3, 1, 1, 1, 'high', False)
         self.check_topology(4, 1, 1, 1, 'medium', False)
         self.check_topology(5, 2, 1, 1, 'high', True)
+
+
+    def guest_set_dispatching(self, dispatching):
+        exec_command(self,
+                f'echo {dispatching} > /sys/devices/system/cpu/dispatching')
+        self.vm.event_wait('CPU_POLARIZATION_CHANGE', self.event_timeout)
+        exec_command_and_wait_for_pattern(self,
+                'cat /sys/devices/system/cpu/dispatching', dispatching)
+
+
+    def test_polarization(self):
+        """
+        This test verifies that QEMU modifies the entitlement change after
+        several guest polarization change requests.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('1');
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'vertical')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('0');
+        res = self.vm.qmp('query-s390x-cpu-polarization')
+        self.assertEqual(res['return']['polarization'], 'horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
-- 
2.41.0


