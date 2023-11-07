Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D97E4857
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QsZ-0002qC-Do; Tue, 07 Nov 2023 13:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsW-0002nj-CB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsR-0007NQ-NV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRKWf+bSHa5OE55zlM7uSc3kgZtggzSYT+UT2TKPw9s=;
 b=HY0DV7OhfWeTRpg5qQiUL+An083tKQL1owTOoXorAaoUh6IV91EwYa2+MwrqeP4sCI3AdF
 4VxpjJVuUMQOO8P7gL8jtFBigWP028npcTfnf6vh5Zv51kN6zvakp8XufQyzrVdZPQbXYG
 mBPiMym0Sm2uC2HpChA17rQfvC/R788=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-yomrT2ihPVmHyDmtxgD4Iw-1; Tue, 07 Nov 2023 13:32:36 -0500
X-MC-Unique: yomrT2ihPVmHyDmtxgD4Iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9706811E8D;
 Tue,  7 Nov 2023 18:32:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 207CE2166B26;
 Tue,  7 Nov 2023 18:32:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/11] tests/avocado: Allow newer versions of tesseract in the
 nextcube test
Date: Tue,  7 Nov 2023 19:32:20 +0100
Message-ID: <20231107183228.276424-4-thuth@redhat.com>
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <huth@tuxfamily.org>

Current Linux distros ship version 5 of the tesseract OCR software,
so the nextcube screen test is ignored there. Let's make the check
more flexible to allow newer versions, too, and remove the old v3
test since most Linux distros don't ship this version anymore.

Message-ID: <20231101204323.35533-1-huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/avocado/machine_m68k_nextcube.py | 15 +++------------
 tests/avocado/tesseract_utils.py       |  4 ++--
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/tests/avocado/machine_m68k_nextcube.py b/tests/avocado/machine_m68k_nextcube.py
index f1205d7fc0..1f3c883910 100644
--- a/tests/avocado/machine_m68k_nextcube.py
+++ b/tests/avocado/machine_m68k_nextcube.py
@@ -55,25 +55,16 @@ def test_bootrom_framebuffer_size(self):
         self.assertEqual(width, 1120)
         self.assertEqual(height, 832)
 
-    @skipUnless(tesseract_available(3), 'tesseract v3 OCR tool not available')
-    def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
-        screenshot_path = os.path.join(self.workdir, "dump.ppm")
-        self.check_bootrom_framebuffer(screenshot_path)
-        lines = tesseract_ocr(screenshot_path, tesseract_version=3)
-        text = '\n'.join(lines)
-        self.assertIn('Backplane', text)
-        self.assertIn('Ethernet address', text)
-
     # Tesseract 4 adds a new OCR engine based on LSTM neural networks. The
     # new version is faster and more accurate than version 3. The drawback is
     # that it is still alpha-level software.
-    @skipUnless(tesseract_available(4), 'tesseract v4 OCR tool not available')
-    def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
+    @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
+    def test_bootrom_framebuffer_ocr_with_tesseract(self):
         screenshot_path = os.path.join(self.workdir, "dump.ppm")
         self.check_bootrom_framebuffer(screenshot_path)
         lines = tesseract_ocr(screenshot_path, tesseract_version=4)
         text = '\n'.join(lines)
-        self.assertIn('Testing the FPU, SCC', text)
+        self.assertIn('Testing the FPU', text)
         self.assertIn('System test failed. Error code', text)
         self.assertIn('Boot command', text)
         self.assertIn('Next>', text)
diff --git a/tests/avocado/tesseract_utils.py b/tests/avocado/tesseract_utils.py
index 72cd9ab798..476f528147 100644
--- a/tests/avocado/tesseract_utils.py
+++ b/tests/avocado/tesseract_utils.py
@@ -21,13 +21,13 @@ def tesseract_available(expected_version):
         version = res.stdout_text.split()[1]
     except IndexError:
         version = res.stderr_text.split()[1]
-    return int(version.split('.')[0]) == expected_version
+    return int(version.split('.')[0]) >= expected_version
 
     match = re.match(r'tesseract\s(\d)', res)
     if match is None:
         return False
     # now this is guaranteed to be a digit
-    return int(match.groups()[0]) == expected_version
+    return int(match.groups()[0]) >= expected_version
 
 
 def tesseract_ocr(image_path, tesseract_args='', tesseract_version=3):
-- 
2.41.0


