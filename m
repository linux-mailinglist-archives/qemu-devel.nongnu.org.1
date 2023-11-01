Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 332037DE6DA
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:45:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI4Y-0004DZ-BI; Wed, 01 Nov 2023 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyI3w-00041d-Sr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:43:41 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyI3t-0000t2-QF
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:43:40 -0400
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so322233a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698871410; x=1699476210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWE9lKzNbrNWCnNTSJAjEsSbfNnQcvmJYhS05d+itcs=;
 b=Dvym3UNu8UsX7fS9U0qJZL2/ulfQ+AWjdQ3YbIGJdKDSE8mXCFDctdIi5DWaTv1/Z5
 l8mDn42HYH7W/gnH1Ja26Q0Lt7sM1cbdAlfcwYYSQSj86cqP5SbHy5sQvN37/HACsAJu
 S+QeLPeTNoNczs74S3sFcE+fbmPYvXSRC2w03PrIcrPOKhlE0gzXqh2jtlZSXwRAys6H
 YkcgCvQy0fUIPguqkM+P44FGcMXeBo1qDD+HpOM2GPvYH/7rwVh/rdMEvnXHHgLhlH5x
 kp9BL1ck5lvDlzssqjKEESlWkKw2l1lXHqJn7DKAki7DkYZ4JEpyaMJHH561Tbl/E618
 tS+A==
X-Gm-Message-State: AOJu0YwUKQloVwzbX+/BItp7Tqmo5Mec66hPv9FDoSb6G1LBJ03PYTqC
 qIiDOd9MM1aOl6BaSb/gZu4sX1zlHic=
X-Google-Smtp-Source: AGHT+IE84Hm7O4oyJdvwBaSz79X37dz71y6het5lVLn2dya4VSRUNSdrg13nQNZNnD1obPuVSVsUUw==
X-Received: by 2002:a50:9f4e:0:b0:543:6e4f:37b with SMTP id
 b72-20020a509f4e000000b005436e4f037bmr5461749edf.36.1698871409654; 
 Wed, 01 Nov 2023 13:43:29 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 x16-20020a50d610000000b0053dff5568acsm1484033edi.58.2023.11.01.13.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:43:29 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/avocado: Allow newer versions of tesseract in the
 nextcube test
Date: Wed,  1 Nov 2023 21:43:22 +0100
Message-ID: <20231101204323.35533-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Current Linux distros ship version 5 of the tesseract OCR software,
so the nextcube screen test is ignored there. Let's make the check
more flexible to allow newer versions, too, and remove the old v3
test since most Linux distros don't ship this version anymore.

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


