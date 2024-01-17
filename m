Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA188307B7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:14:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6fL-0005Wb-JW; Wed, 17 Jan 2024 09:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fF-0005PG-Qe; Wed, 17 Jan 2024 09:13:09 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6fD-0002oh-NF; Wed, 17 Jan 2024 09:13:09 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3606f507efeso53971865ab.3; 
 Wed, 17 Jan 2024 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500785; x=1706105585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=cWkrZcYigI+P0gHq7yCLhTzfylDK/i4+KUKDBDqWeM0tRQyYVlFUetGmADVa4EYN2p
 VWV4R4HJPtjX/O5XqzHLWpi+n9kSPFaz8aEq80tAZmb5c2CpkvWRLzhkvHb8hl6ylBaJ
 tZ9QcORKUGMabzBDAsFg2bpFgyrzbqhJc7+jzKd7z6YyRHnGMf45OSR9b+N+ZI3lJcOM
 iIHa5ydJhPPoL/17nsvrTcyVszQdtCAb9lFg29XOKK1xpo+Or2sgZMKIgbZtooXwx322
 9Yk9ElwEVULIZdrHoEo5lJ/lp+CyuAA+0AgSh2pf+PHUO/NzPlEss/RY42XpU29Hl8cW
 i+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500785; x=1706105585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLpVpr4lXcxtiYkgYwO8f+zCCPIx0i1aEW37ifuFYyc=;
 b=q1yosg5HKmFJSARImsO1IXNkrM2RKdbgryOmFkGz9BpKHXpXpzuEuVk6cEPyNkkV43
 8zF0502db+Dg8ZzmoWocYA1SD8egK+59Ogs3QOFPe5u+fEdhuzk5FBathe4hXf1hrhPd
 KVZ2Jnu4OJfraplJze1hv4gs924mGI0Gt1R6CcmiXyXKQzlxrCuply8GPFWkMHHBoZT6
 /TPpFY7JY6On6zv54kgzk9ViGSdgDf9VJDffr1MWsoGPk1fi48gZzIcWimutpMs2QZPW
 mkPXAVfM2Z9XRk/sT9BUVs+31kI+R5fFvgZPU8kLptYtnuX5iYFLkTeN0t+ClfHQ97pJ
 oJqg==
X-Gm-Message-State: AOJu0Yzo85WqXfVkapcprYWC4w6nGr9RYpGg+X2UiOPEfC5WTiaqmxZS
 ISFYEtCGB1tprt1ltTcqkcPQPDS1mig=
X-Google-Smtp-Source: AGHT+IEQglE7SJ1Oa6n12Kl0ghdVGhJMfAlB/e4xtxvuM3kB7h4IM9Ez0Fj2mTihGL7lGj94cBam5w==
X-Received: by 2002:a05:6e02:605:b0:361:962f:ba0d with SMTP id
 t5-20020a056e02060500b00361962fba0dmr1112261ils.39.1705500785640; 
 Wed, 17 Jan 2024 06:13:05 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:13:05 -0800 (PST)
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
Subject: [PATCH v2 5/8] tests/avocado: Add ppc pseries and powernv hash MMU
 tests
Date: Thu, 18 Jan 2024 00:12:20 +1000
Message-ID: <20240117141224.90462-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x132.google.com
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


