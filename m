Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE57EDB7C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 07:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3VjV-0001YQ-4l; Thu, 16 Nov 2023 01:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3VjS-0001Y4-3S
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 01:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3VjQ-0005uw-4y
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 01:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700115603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UyczLx7Nt+KEhdC5+z/cpjvPq2cY3WgIOOj9SsTFP3c=;
 b=KrMKH2jZlJhJdc31ZHRDlbcIUNiJkCTlBhd25xBgtlzz5VYPkXjSa9XvglxcAZqBvRnyPV
 0vZKV2IwxtZHwMhaCIVv5UIwg+Puhz7ylJjIETXWQQOcCDg9nBjdMOlIu21JsJ9rU0gcRl
 CU661IRuDMYToq/qq0+tNTVJCQRfJ0Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-MRP4IrAuNNun2slKyZjglQ-1; Thu,
 16 Nov 2023 01:19:59 -0500
X-MC-Unique: MRP4IrAuNNun2slKyZjglQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3601C0434E;
 Thu, 16 Nov 2023 06:19:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4072A492BE0;
 Thu, 16 Nov 2023 06:19:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH] tests/avocado/mem-addr-space-check: Replace assertEquals()
 for Python 3.12
Date: Thu, 16 Nov 2023 07:19:56 +0100
Message-ID: <20231116061956.14676-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

assertEquals() has been removed in Python 3.12 and should be replaced by
assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: The test has just been merged, that's why I missed this file in
 my earlier patch that replaces the assertEquals()

 tests/avocado/mem-addr-space-check.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
index be949222a4..363c3f12a6 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/avocado/mem-addr-space-check.py
@@ -49,7 +49,7 @@ def test_phybits_low_pse36(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_low_pae(self):
@@ -69,7 +69,7 @@ def test_phybits_low_pae(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_ok_pentium_pse36(self):
@@ -149,7 +149,7 @@ def test_phybits_low_nonpse36(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     # now lets test some 64-bit CPU cases.
@@ -179,7 +179,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_low_tcg_q35_71_amd(self):
@@ -202,7 +202,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_ok_tcg_q35_70_amd(self):
@@ -288,7 +288,7 @@ def test_phybits_low_tcg_q35_71_amd_41bits(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_ok_tcg_q35_71_amd_41bits(self):
@@ -332,7 +332,7 @@ def test_phybits_low_tcg_q35_intel_cxl(self):
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
     def test_phybits_ok_tcg_q35_intel_cxl(self):
-- 
2.41.0


