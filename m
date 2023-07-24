Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6375FCAE
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNypC-0001N7-Hl; Mon, 24 Jul 2023 12:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNypA-0001MR-W8
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp9-0006xm-Ed
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyDnabCQzl6gPHWrtz83iEReskzaxBX9DyQ1sJhD//8=;
 b=IA4GK91huV/aT/OgEbviSDfd3YH3uCrwyZEV/DqLOX4bwTFZSTUoDEMqnpXIEXIbbiw5bi
 ETsSrvdpBF5jE0Hd4wFQaPywrz678iO3Od61fY5EIxYxtkjc7kSd30IJ9lFiZb9WdAuQZP
 tcmcCZZ9djEu4de5fySNAOvaKz/4WdY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-Zg5cChXnNUy1zhauy-mwdQ-1; Mon, 24 Jul 2023 12:54:15 -0400
X-MC-Unique: Zg5cChXnNUy1zhauy-mwdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA7903C1395A;
 Mon, 24 Jul 2023 16:54:13 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C174C48FB01;
 Mon, 24 Jul 2023 16:54:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/16] tests/avocado/machine_s390_ccw_virtio: Skip the flaky
 virtio-gpu test by default
Date: Mon, 24 Jul 2023 18:53:49 +0200
Message-Id: <20230724165349.55714-17-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

The virtio-gpu test is known to be flaky - that's why we also did
not enable the test_s390x_fedora in the gitlab CI. However, a flaky
test can also be annoying when testing locally, so let's rather skip
this subtest by default and start running the test_s390x_fedora test
in the gitlab CI again (since the other things that are tested here
are quite valuable).

Message-Id: <20230724084851.24251-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/machine_s390_ccw_virtio.py | 51 +++++++++++++-----------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index 78152f2ad1..e7a2a20ba6 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -159,7 +159,6 @@ def test_s390x_devices(self):
                                           'MemTotal:         115640 kB')
 
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_s390x_fedora(self):
 
         """
@@ -229,31 +228,35 @@ def test_s390x_fedora(self):
         # writing to the framebuffer. Since the PPM is uncompressed, we then
         # can simply read the written "magic bytes" back from the PPM file to
         # check whether the framebuffer is working as expected.
-        self.log.info("Test screendump of virtio-gpu device")
-        exec_command_and_wait_for_pattern(self,
+        # Unfortunately, this test is flaky, so we don't run it by default
+        if os.getenv('QEMU_TEST_FLAKY_TESTS'):
+            self.log.info("Test screendump of virtio-gpu device")
+            exec_command_and_wait_for_pattern(self,
                         'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
                         'virtio_gpudrmfb frame buffer device')
-        exec_command_and_wait_for_pattern(self,
-            'echo -e "\e[?25l" > /dev/tty0', ':/#')
-        exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
-            'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
-            'done',
-            ':/#')
-        exec_command_and_wait_for_pattern(self,
-            'dd if=fox.txt of=/dev/fb0 bs=1000 oflag=sync,nocache ; rm fox.txt',
-            '12+0 records out')
-        with tempfile.NamedTemporaryFile(suffix='.ppm',
-                                         prefix='qemu-scrdump-') as ppmfile:
-            self.vm.command('screendump', filename=ppmfile.name)
-            ppmfile.seek(0)
-            line = ppmfile.readline()
-            self.assertEqual(line, b"P6\n")
-            line = ppmfile.readline()
-            self.assertEqual(line, b"1280 800\n")
-            line = ppmfile.readline()
-            self.assertEqual(line, b"255\n")
-            line = ppmfile.readline(256)
-            self.assertEqual(line, b"The quick fox jumps over a lazy dog\n")
+            exec_command_and_wait_for_pattern(self,
+                'echo -e "\e[?25l" > /dev/tty0', ':/#')
+            exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
+                'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
+                'done',
+                ':/#')
+            exec_command_and_wait_for_pattern(self,
+                'dd if=fox.txt of=/dev/fb0 bs=1000 oflag=sync,nocache ; rm fox.txt',
+                '12+0 records out')
+            with tempfile.NamedTemporaryFile(suffix='.ppm',
+                                             prefix='qemu-scrdump-') as ppmfile:
+                self.vm.command('screendump', filename=ppmfile.name)
+                ppmfile.seek(0)
+                line = ppmfile.readline()
+                self.assertEqual(line, b"P6\n")
+                line = ppmfile.readline()
+                self.assertEqual(line, b"1280 800\n")
+                line = ppmfile.readline()
+                self.assertEqual(line, b"255\n")
+                line = ppmfile.readline(256)
+                self.assertEqual(line, b"The quick fox jumps over a lazy dog\n")
+        else:
+            self.log.info("Skipped flaky screendump of virtio-gpu device test")
 
         # Hot-plug a virtio-crypto device and see whether it gets accepted
         self.log.info("Test hot-plug virtio-crypto device")
-- 
2.39.3


