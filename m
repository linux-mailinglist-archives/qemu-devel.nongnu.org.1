Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E517BF4F8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YX-0005oQ-RY; Tue, 10 Oct 2023 03:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YV-0005hg-FU; Tue, 10 Oct 2023 03:53:27 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YP-0005Jm-MX; Tue, 10 Oct 2023 03:53:27 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c615df24c0so3647999a34.1; 
 Tue, 10 Oct 2023 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924400; x=1697529200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLNYJ8t4jqLnyryhAA2gveg7y+jnACsL6CwNdvnZIrM=;
 b=gXSfAUV13+n329L8YzEP208ECjCiOAemcVG9SHjhCuvC6aceamkyXvlu4aC9I4vmdX
 NASSyL4B6NugAsr2il9ul6tkdn4/M7bjSt07rhSxmlsjH1KRQLJ8UlibCzkDsuDg6MIG
 XIeTKLL4u1ncJIIt0djNsY4OhhlHx/I78R4hEarLLv/evbWECAjQjoqmjGGZoQCu8hsn
 PbdfPbLecPCaKYcb3bsgtBFfkVAvQPvMpaGNKugIU1Q/oaz/6PxlUQjGVURKLGDDu/Aw
 1AQZSbo/xIH6GXQLyZMbmzAIpkCtSTOuRzrBe5786oTzjeDWE0w7rjMaOmWkGRj4bz0F
 ZPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924400; x=1697529200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLNYJ8t4jqLnyryhAA2gveg7y+jnACsL6CwNdvnZIrM=;
 b=SJ3QWqBqKZbPuBkaSrGYnR1m3k6ZznnsBB8ZC1PnPGn0DDoXiDPVywKluq04qes6Tr
 bKcxyLyDHuGfG3zZfTF4wr/+vk5Bzv3gMKSltcq1qYsOLQ7OopqQQtPzbrk6Wa00OYg0
 GOLcXKHKwYpVUQffBOhs/eBoK12fQHFxUKLGs3qJ3RA0OuITIVs8EFrxnjUqNh6AMVYZ
 JfGEK8AiuczQX7UlVNJcSaxcLzMYnPBgFrMicTuKVrI/FlDrFBhvZnTl8GdUb7UsmQZJ
 lN34og6WFyyoza312s7hnAxjt+duZT+VeR0KJBIw4ZSXWPezACLLchZ+9/Fo0S6J19Oj
 di6g==
X-Gm-Message-State: AOJu0YxR76kPI5zipUDpYqksyArWQv44plECe5cwJNFxm1oJ391gd7Bk
 pcPRrRHB1xxZmiqaC4d1QnHwN6QK338=
X-Google-Smtp-Source: AGHT+IFwCh5mIGoNAK1aKuCO2X3Z1H/XvGbQu+ELyg2TMew9bitKmKaq0fLn8RQuTttSeDp/DM+nEw==
X-Received: by 2002:a05:6870:e307:b0:1bb:a227:7008 with SMTP id
 z7-20020a056870e30700b001bba2277008mr19284238oad.3.1696924399169; 
 Tue, 10 Oct 2023 00:53:19 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 08/11] tests/avocado: Add ppc MacOS tests
Date: Tue, 10 Oct 2023 17:52:35 +1000
Message-ID: <20231010075238.95646-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Similarly to the AIX test, this adds some tests that can boot MacOS9
and OSX images that are provided.
---
 tests/avocado/ppc/macos9.ppm | Bin 0 -> 921615 bytes
 tests/avocado/ppc_macos.py   |  90 +++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/avocado/ppc/macos9.ppm
 create mode 100644 tests/avocado/ppc_macos.py

diff --git a/tests/avocado/ppc/macos9.ppm b/tests/avocado/ppc/macos9.ppm
new file mode 100644
index 0000000000000000000000000000000000000000..662d1a5a0fec47a589dbc03ed3b10b3d653c07f1
GIT binary patch
literal 921615
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

literal 0
HcmV?d00001

diff --git a/tests/avocado/ppc_macos.py b/tests/avocado/ppc_macos.py
new file mode 100644
index 0000000000..055fc3aca4
--- /dev/null
+++ b/tests/avocado/ppc_macos.py
@@ -0,0 +1,90 @@
+# Functional test that boots MacOS on ppc mac99
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import time
+import tempfile
+import filecmp
+import os
+
+from typing import List
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class PPCMacOSTest(QemuSystemTest):
+
+    timeout = 240
+
+    def test_macos9(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:mac99
+        :avocado: tags=device:framebuffer
+        """
+
+        basedir = os.getenv('AVOCADO_TEST_BASEDIR')
+        screenshot_path = os.path.join(basedir, 'ppc/macos9.ppm')
+
+        image = os.getenv('MACOS9_IMAGE')
+        if not image:
+            self.cancel('No MACOS9_IMAGE environment variable defined')
+        drive_path = self.fetch_asset(image)
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'via=pmu')
+        self.vm.add_args('-m', '1g')
+        self.vm.add_args('-cpu', 'G4')
+        self.vm.add_args('-drive', 'file=' + drive_path)
+#        self.vm.add_args('-net', 'nic,model=rtl8139')
+#        self.vm.add_args('-net', 'user,hostfwd=:127.0.0.1:2223-:22,hostname=qemu')
+        self.vm.add_args('-vga', 'std')
+        self.vm.add_args('-g', '640x480')
+        self.vm.launch()
+
+        # This comes up after 60 seconds on a fast x86 CPU. Give it
+        # 180s to be sure.
+        time.sleep(180)
+        with tempfile.NamedTemporaryFile(suffix='.ppm',
+                                         prefix='screendump-', delete=False) as ppmfile:
+            self.vm.command('screendump', filename=ppmfile.name)
+            if not filecmp.cmp(ppmfile.name, screenshot_path):
+                self.fail('Screenshot does not match')
+
+    def test_macos10(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:mac99
+        :avocado: tags=device:framebuffer
+        """
+
+        basedir = os.getenv('AVOCADO_TEST_BASEDIR')
+        screenshot_path = os.path.join(basedir, 'ppc/macos10.ppm')
+
+        image = os.getenv('MACOS10_IMAGE')
+        if not image:
+            self.cancel('No MACOS10_IMAGE environment variable defined')
+        drive_path = self.fetch_asset(image)
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'via=pmu')
+        self.vm.add_args('-m', '1g')
+        self.vm.add_args('-cpu', 'G4')
+        self.vm.add_args('-drive', 'file=' + drive_path)
+#        self.vm.add_args('-net', 'nic,model=rtl8139')
+#        self.vm.add_args('-net', 'user,hostfwd=:127.0.0.1:2223-:22,hostname=qemu')
+        self.vm.add_args('-vga', 'std')
+        self.vm.add_args('-g', '640x480')
+        self.vm.launch()
+
+        # This comes up after 60 seconds on a fast x86 CPU. Give it
+        # 180s to be sure.
+        time.sleep(180)
+        with tempfile.NamedTemporaryFile(suffix='.ppm',
+                                         prefix='screendump-', delete=False) as ppmfile:
+            self.vm.command('screendump', filename=ppmfile.name)
+            if not filecmp.cmp(ppmfile.name, screenshot_path):
+                self.fail('Screenshot does not match')
-- 
2.42.0


