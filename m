Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E04B5491E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Sep 2025 12:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0i5-0001Fh-WD; Fri, 12 Sep 2025 06:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hg-00017G-Vz
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hP-00024l-R4
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=suGJpy3gLCm9Dbc80Kpi8tkFRxnWzaUloxsQ75d5WUQ=;
 b=YRq0cZSb0R4qFCReWCZKLXh67GkxcGwunchXg1GOzLIcylDZ73DTyp8AHNokagFOHZ1/tt
 AK/FZgKDK2TyMoSB0KwPzQa8UDaTkRsAtZee45NKEMQC7NtMN1lSuzObNT9FamXysM4E1L
 jgL9UKsEp+Kzk02GkoN6Y5xcJBV8ZNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-gPVJ_ssWNl6aOeNuojDyvg-1; Fri,
 12 Sep 2025 06:08:05 -0400
X-MC-Unique: gPVJ_ssWNl6aOeNuojDyvg-1
X-Mimecast-MFC-AGG-ID: gPVJ_ssWNl6aOeNuojDyvg_1757671684
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41C6B1944E43; Fri, 12 Sep 2025 10:08:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC89B1944CCA; Fri, 12 Sep 2025 10:08:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 2/4] tests/functional: Test whether the
 vmstate-static-checker script works fine
Date: Fri, 12 Sep 2025 12:07:53 +0200
Message-ID: <20250912100755.316518-3-thuth@redhat.com>
In-Reply-To: <20250912100755.316518-1-thuth@redhat.com>
References: <20250912100755.316518-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We've got two vmstate dump files in the repository which are meant
for verifying whether the vmstate-static-checker.py works as expected.
Since running this manually is a cumbersome job, let's add an automated
test for this instead that runs the script with the two dump files
and checks for the expected output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                 |  1 +
 tests/functional/x86_64/meson.build         |  1 +
 tests/functional/x86_64/test_bad_vmstate.py | 58 +++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100755 tests/functional/x86_64/test_bad_vmstate.py

diff --git a/MAINTAINERS b/MAINTAINERS
index bd8eb349649..9c8bd7b1180 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3604,6 +3604,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/functional/migration.py
 F: tests/functional/*/*migration.py
+F: tests/functional/x86_64/test_bad_vmstate.py
 F: tests/data/vmstate-static-checker/
 F: tests/qtest/migration/
 F: tests/qtest/migration-*
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index d0b4667bb8a..ef12ac43b37 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -10,6 +10,7 @@ test_x86_64_timeouts = {
 }
 
 tests_x86_64_system_quick = [
+  'bad_vmstate',
   'cpu_model_versions',
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/functional/x86_64/test_bad_vmstate.py b/tests/functional/x86_64/test_bad_vmstate.py
new file mode 100755
index 00000000000..40098a8490b
--- /dev/null
+++ b/tests/functional/x86_64/test_bad_vmstate.py
@@ -0,0 +1,58 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+'''Test whether the vmstate-static-checker script detects problems correctly'''
+
+import subprocess
+
+from qemu_test import QemuBaseTest
+
+
+EXPECTED_OUTPUT='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
+Section "fw_cfg" does not exist in dest
+Section "fusbh200-ehci-usb" version error: 2 > 1
+Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
+Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
+Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
+Section "cfi.pflash01": Entry "Description" missing
+Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
+Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
+Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
+Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
+Section "sun-fdtwo" Description "fdc": version error: 2 > 1
+Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
+Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
+'''
+
+class BadVmStateTest(QemuBaseTest):
+    '''Test class for testing vmstat-static-checker script with bad input'''
+
+    def test_checker(self):
+        """
+        Test whether the checker script correctly detects the changes
+        between dump1.json and dump2.json.
+        """
+        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump1.json')
+        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
+                                  'dump2.json')
+        checkerscript = self.data_file('..', '..', 'scripts',
+                                       'vmstate-static-checker.py')
+
+        self.log.info('Comparing %s with %s', src_json, dst_json)
+        cp = subprocess.run([checkerscript, '-s', src_json, '-d', dst_json],
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            text=True, check=False)
+        if cp.returncode != 13:
+            self.fail('Unexpected return code of vmstate-static-checker: ' +
+                      cp.returncode)
+        if cp.stdout != EXPECTED_OUTPUT:
+            self.log.info('vmstate-static-checker output:\n%s', cp.stdout)
+            self.log.info('expected output:\n%s', EXPECTED_OUTPUT)
+            self.fail('Unexpected vmstate-static-checker output!')
+
+
+if __name__ == '__main__':
+    QemuBaseTest.main()
-- 
2.51.0


