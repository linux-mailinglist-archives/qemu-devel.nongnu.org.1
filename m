Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 248CF7EE667
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkZ-0002Sx-1O; Thu, 16 Nov 2023 13:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkS-0002RU-JA
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkQ-00043Z-Mg
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRnaGY+Jev9ZahpeHvw73uuMO5QTSDopK7RVrPjV6uY=;
 b=f/LyCU+KwpV1CihROFVL5QwHMZnAfsh/4qrAlsOg2L6B12fl7O0Cgg5bccR1OBmLzsNf2u
 E2R1aI/hrmXVFfFZAh+WGHfvgrVG2mgFAmyarXnx7MWiWbucs+pv9H72DF88TwQ+WReb7I
 OZxNPcLfpaR0qAF/E/R0w9Am8tzLfNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-sFFypTdIMF-y_2H-8aO6OQ-1; Thu, 16 Nov 2023 13:05:47 -0500
X-MC-Unique: sFFypTdIMF-y_2H-8aO6OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5389811E7D;
 Thu, 16 Nov 2023 18:05:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDD51121306;
 Thu, 16 Nov 2023 18:05:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 08/10] tests/avocado/mem-addr-space-check: Replace
 assertEquals() for Python 3.12
Date: Thu, 16 Nov 2023 19:05:32 +0100
Message-ID: <20231116180534.566469-9-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

assertEquals() has been removed in Python 3.12 and should be replaced by
assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Message-ID: <20231116061956.14676-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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


