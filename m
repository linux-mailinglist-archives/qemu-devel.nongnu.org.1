Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6C82653D
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWY0-00020q-7C; Sun, 07 Jan 2024 12:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXo-0001nD-NZ; Sun, 07 Jan 2024 12:02:44 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXm-0007an-RU; Sun, 07 Jan 2024 12:02:40 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28be8ebcdc1so521689a91.0; 
 Sun, 07 Jan 2024 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646957; x=1705251757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=TFupAU3eRRedZNBOqZX2ti0mujlWAbgKhZvrISNJQhwFtxeFZXH2tzlKBDElTWVoa6
 JSDqe76VkhWONbKfjctFklS71YOnwP1M2+6jJKbNw5hk71xCZG1GaVWQSJDxILME9Dz2
 lqPqAxa4STIegQaLwgSBURVx6uobKtr85H6rWmAyeQVtnMMNNGryu/e1mxq0TcjZQ7+U
 +BukVI2HjVM16+8/gMKe7LapX+qvOVfQhbt12iMrD209OHo1xoeDta5JRIGjL9E13tr8
 Gfr2B4B+qJOBNzDcpMGgmuuGMTv6wlCNnyi50oQriamlZ6ZHKs+Sa4w9rq11Cfz8ELAx
 Zn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646957; x=1705251757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=TtV7/msOZUy4NDC6EPAW7TFCZoVJNY2r7K/WBlCLuLfxdG2jB1nY0kXPhyeB48mj4X
 B7e4h6WaJ97e5m2EFElPCbh9ezaTbWiYHhMocOSIqPrIZQIFa/YCUK0bKpJtBGVqmVpd
 Egba+WBIOOP7Wa7QHdbhDdnGIYmgWSXRCGEtPLoeSI+5bqJ79+xJPx+hLTNwjZiLb4sE
 0h0XGN/Jc1Dwg+WaTKtCTDoVMgUhpCpfrEa0gRLI7isLUEcUK0FHckNn9PY6SfsjVHph
 WKRcGbHKu/W8mMSO5xKqavDuXwfV4w0yerWF8VYAfVBYePjOtXLlXpHhj+WOK34v74BR
 Vmxg==
X-Gm-Message-State: AOJu0Yxik/n1E8a+3ztE7wUYF6EUqBEhDOWE27SlDlNL4oMT95U4blgJ
 SucMDfyrmopbEm8SHmTPlRO72WZlA0o=
X-Google-Smtp-Source: AGHT+IGpVYZH+WxnWpoCV5wMccBY2sxR9/AlZEMxNAz0KrpF9S/IPDXr62OXB4nFej6dlVf3Zu9J3w==
X-Received: by 2002:a17:902:ce8c:b0:1d4:399d:8511 with SMTP id
 f12-20020a170902ce8c00b001d4399d8511mr939223plg.84.1704646956660; 
 Sun, 07 Jan 2024 09:02:36 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:02:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 6/9] tests/avocado: Add ppc pseries and powernv hash MMU tests
Date: Mon,  8 Jan 2024 03:01:16 +1000
Message-ID: <20240107170119.82222-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

POWER CPUs support hash and radix MMU modes. Linux supports running in
either mode, but defaults to radix. To keep up testing of QEMU's hash
MMU implementation, add some Linux hash boot tests.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_powernv.py | 23 +++++++++++++++++++----
 tests/avocado/ppc_pseries.py | 20 +++++++++++++++++---
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
index d0e5c07bde..4342941d5d 100644
--- a/tests/avocado/ppc_powernv.py
+++ b/tests/avocado/ppc_powernv.py
@@ -12,11 +12,11 @@
 class powernvMachine(QemuSystemTest):
 
     timeout = 90
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
-    def do_test_linux_boot(self):
+    def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
@@ -25,9 +25,8 @@ def do_test_linux_boot(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
         self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line)
+                         '-append', command_line)
         self.vm.launch()
 
     def test_linux_boot(self):
@@ -54,6 +53,22 @@ def test_linux_smp_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_linux_smp_hpt_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
+                                'disable_radix')
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
+                                 self.panic_message)
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
     def test_linux_smt_boot(self):
         """
         :avocado: tags=arch:ppc64
diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
index a8311e6555..74aaa4ac4a 100644
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/avocado/ppc_pseries.py
@@ -12,11 +12,11 @@
 class pseriesMachine(QemuSystemTest):
 
     timeout = 90
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
-    def do_test_ppc64_linux_boot(self):
+    def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
                       '/ppc/ppc64/vmlinuz')
@@ -24,7 +24,6 @@ def do_test_ppc64_linux_boot(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
@@ -62,6 +61,21 @@ def test_ppc64_linux_smp_boot(self):
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
+    def test_ppc64_linux_hpt_smp_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_ppc64_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
+                                      'disable_radix')
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, 'hash-mmu: Initializing hash mmu',
+                                 self.panic_message)
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
     def test_ppc64_linux_smt_boot(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.42.0


