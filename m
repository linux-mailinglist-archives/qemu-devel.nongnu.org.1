Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CEA2FB08
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 21:49:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaeK-0005zO-0e; Mon, 10 Feb 2025 15:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thae9-0004pi-DE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thae1-00041N-JU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:48 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38de17a5fc9so686341f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220280; x=1739825080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9KWIiGOWq55nxx0C4B7NMOGhhvAoCPOGFcu0xxlyb8=;
 b=eSa9mDTVeQMo8N33+FIUVT+1+y4H86s2PqQDzEyBSF9T11lpSEQ8QLDBOFpiX48pSP
 VgPWnrmVhR3Um9ci6m3HI3kPstbJA9SQ9X99eI0mXl+5U2pI0o27OLJ3pFaY9QJGPPPp
 pUKEduGBIOECl6YSzVO+eBSq/UL0wbGyl0TLbOXe9wjO+BdGXvRp4KdMx3/XsXYdvXsv
 SApWFPEhmwSZ1t9N5C39oWRI85NvSdFcbEP8gWBN8psfpiiFRRtcS2+PPSWsc5DM4st8
 yw1fY1QDhRUOu5YCKL4Krh5zf8Xxh8GW/ThH9s7qWSTBd6WVZjPGeSw5Fo+E+KccPMTE
 1Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220280; x=1739825080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9KWIiGOWq55nxx0C4B7NMOGhhvAoCPOGFcu0xxlyb8=;
 b=F9l/iwfCHcRIn0j+zWiB/mZ2CX3qwjK7tNyHZo7ugs0Su89VkSHalQAGq1Fi0f1wlq
 fHkcG/3RDH0YjI4yHQIhu0bttv1lEY5rAf9S3QVwnbxh5zYpbRRlTAf8ahIh/t7eeJ7l
 drxd7OwXA0RZgQ6IeamUkClVmoxAZDAfpOAIn3b+3KaQ0KquPw/r1r526mEc49urdjDB
 1ac3AHdHoi0di2cAVuSjHI1YxfpkcTN9BRTRtmuzJhz2A7rG7vsMQWv1pbjorHHtypsv
 ahkxV1/PI8oqDKYHVNAcr2Z6eq2rcdtj3Umrg2ryMIAFGtQMleNSmvYYH/kv7kwj7ZC7
 otBA==
X-Gm-Message-State: AOJu0Yw2C+fnmgBruEVc5md906HGEjbmWjBy/Ly2GhF+Wi46Y5O2Phqe
 CeaYBvnKQESgDm8WErDs19WAzraGIatCcQ+lFZGi4JZp0afJQSP2Ey5Z8AbahLh5q1Jqf9DTWuB
 Wq3g=
X-Gm-Gg: ASbGnctNRL9cBvYgkoI0HoIdgpoP6oEp+6ZMdQiOi9OeWNH71sD+h18eMXZY88l4C8j
 4B5Oo27wgzlfSyaAm/F6QG6SqN/35vIlvDjxN19yKvsh1gWSA37w9MUKqqHeUlpFB+eg6gKtuNL
 BweEF9FM0o2khQMYJF5PLaEbznHA7VwGJv5n4wYiN0XrJPBnnxIJvfNJHnybXGgVoMjkVHN+1TV
 o43G8r+T976ROWKcd4gXJmPBusnoDZBbiIT04SEMw6j0i7rWaInfBhICh4ExtcjxU7laJFDzkxX
 iOxnU7MFK+LpxeYaBGztk3bWPFFgp08bE70Bl71km8KftfPfW/3R+CLcRFWOnKziQw==
X-Google-Smtp-Source: AGHT+IHlnne0RSOYgQHJ96Ui1DlCfkmOgeXoP/oqUhd4VlLF0R/zvHoRrB1JUMmMd7hs9P+TmTLRTA==
X-Received: by 2002:a05:6000:2a7:b0:38d:b448:65c4 with SMTP id
 ffacd0b85a97d-38dc959fec4mr11531269f8f.55.1739220279727; 
 Mon, 10 Feb 2025 12:44:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd9c48173sm5410642f8f.37.2025.02.10.12.44.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 30/32] tests/functional: Have microblaze tests inherit common
 parent class
Date: Mon, 10 Feb 2025 21:42:02 +0100
Message-ID: <20250210204204.54407-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Have the MicroblazeMachine class being common to both
MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
classes. Move the xmaton and ballerina tests to the parent class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-16-philmd@linaro.org>
---
 .../functional/test_microblaze_s3adsp1800.py  | 23 +++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 29 ++-----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c4226f49cf3..177c8a685bc 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,6 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -20,6 +21,10 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
     def do_ballerina_be_test(self, machine):
         self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
@@ -34,6 +39,24 @@ def do_ballerina_be_test(self, machine):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def do_xmaton_le_test(self, machine):
+        self.require_netdev('user')
+        self.set_machine(machine)
+        self.archive_extract(self.ASSET_IMAGE_LE)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
+        tftproot = self.scratch_file('day13')
+        self.vm.add_args('-nic', f'user,tftp={tftproot}')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
+class MicroblazeBigEndianMachine(MicroblazeMachine):
+
     def test_microblaze_s3adsp1800_legacy_be(self):
         self.do_ballerina_be_test('petalogix-s3adsp1800')
 
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 60aab4a45e8..56645bd0bb2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,34 +7,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest
 
+from test_microblaze_s3adsp1800 import MicroblazeMachine
 
-class MicroblazeelMachine(QemuSystemTest):
-
-    timeout = 90
-
-    ASSET_IMAGE_LE = Asset(
-        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
-        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
-
-    def do_xmaton_le_test(self, machine):
-        self.require_netdev('user')
-        self.set_machine(machine)
-        self.archive_extract(self.ASSET_IMAGE_LE)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
-        tftproot = self.scratch_file('day13')
-        self.vm.add_args('-nic', f'user,tftp={tftproot}')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        wait_for_console_pattern(self, 'buildroot login:')
-        exec_command_and_wait_for_pattern(self, 'root', '#')
-        exec_command_and_wait_for_pattern(self,
-                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
-                '821cd3cab8efd16ad6ee5acc3642a8ea')
+class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
     def test_microblaze_s3adsp1800_legacy_le(self):
         self.do_xmaton_le_test('petalogix-s3adsp1800')
-- 
2.47.1


