Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F97CDCD6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Hr-0004nj-Mb; Wed, 18 Oct 2023 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HI-0004WG-Mp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt6HE-0007zl-SB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697634474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXvbhaQkakmXqvXdRpF/EntaW/hW4T+v9GiVFzYKkVg=;
 b=CqlRych2RhlaldF+gsozkTfU0mRYwdszG8rV0/k8Sa9EPOSthHDmRJlVUfuih18nIArJ6N
 Ate0FR3QIrHkDF1bMZYCPsu76ncSOPx/Z800uQl9m71nVdEfgHYHF9YudzYXuYwRNArjxM
 lwoN7dYRVrzDl1FCylJZaU8L5j6751Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-d5NGA_b3OY2BgA6bBAuWpQ-1; Wed, 18 Oct 2023 09:07:48 -0400
X-MC-Unique: d5NGA_b3OY2BgA6bBAuWpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79B8C28AC1EB;
 Wed, 18 Oct 2023 13:07:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86C0520268C8;
 Wed, 18 Oct 2023 13:07:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 17/25] tests/avocado: s390x cpu topology entitlement tests
Date: Wed, 18 Oct 2023 15:07:08 +0200
Message-ID: <20231018130716.286638-18-thuth@redhat.com>
In-Reply-To: <20231018130716.286638-1-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Test changes in the entitlement from both a guest and a host point of
view, depending on the polarization.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231016183925.2384704-18-nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/s390_topology.py | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
index 8166cee134..24fac9a54d 100644
--- a/tests/avocado/s390_topology.py
+++ b/tests/avocado/s390_topology.py
@@ -243,3 +243,65 @@ def test_polarization(self):
         res = self.vm.qmp('query-s390x-cpu-polarization')
         self.assertEqual(res['return']['polarization'], 'horizontal')
         self.check_topology(0, 0, 0, 0, 'medium', False)
+
+
+    def check_polarization(self, polarization):
+        #We need to wait for the change to have been propagated to the kernel
+        exec_command_and_wait_for_pattern(self,
+            "\n".join([
+                "timeout 1 sh -c 'while true",
+                'do',
+                '    syspath="/sys/devices/system/cpu/cpu0/polarization"',
+                '    polarization="$(cat "$syspath")" || exit',
+               f'    if [ "$polarization" = "{polarization}" ]; then',
+                '        exit 0',
+                '    fi',
+                '    sleep 0.01',
+                #searched for strings mustn't show up in command, '' to obfuscate
+                "done' && echo succ''ess || echo fail''ure",
+            ]),
+            "success", "failure")
+
+
+    def test_entitlement(self):
+        """
+        This test verifies that QEMU modifies the entitlement
+        after a guest request and that the guest sees the change.
+
+        :avocado: tags=arch:s390x
+        :avocado: tags=machine:s390-ccw-virtio
+        """
+        self.kernel_init()
+        self.vm.launch()
+        self.wait_until_booted()
+
+        self.system_init()
+
+        self.check_polarization('horizontal')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        self.guest_set_dispatching('1')
+        self.check_polarization('vertical:medium')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'low'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:low')
+        self.check_topology(0, 0, 0, 0, 'low', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'medium'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:medium')
+        self.check_topology(0, 0, 0, 0, 'medium', False)
+
+        res = self.vm.qmp('set-cpu-topology',
+                          {'core-id': 0, 'entitlement': 'high'})
+        self.assertEqual(res['return'], {})
+        self.check_polarization('vertical:high')
+        self.check_topology(0, 0, 0, 0, 'high', False)
+
+        self.guest_set_dispatching('0');
+        self.check_polarization("horizontal")
+        self.check_topology(0, 0, 0, 0, 'high', False)
-- 
2.41.0


