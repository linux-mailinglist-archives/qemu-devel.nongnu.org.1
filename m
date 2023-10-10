Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3807BF4E5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Y8-0004cc-Qa; Tue, 10 Oct 2023 03:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Y3-0004ak-Eo; Tue, 10 Oct 2023 03:53:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Y1-0005GS-Jh; Tue, 10 Oct 2023 03:52:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-692b2bdfce9so4775163b3a.3; 
 Tue, 10 Oct 2023 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924375; x=1697529175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNwNk6v5s/mWYlSRNEECJ0K7X37JqAfWAFjFfycrRY0=;
 b=TCokQRj18mqU3ftklDcGv0sTDp/nvWPAdsFVpTsQXOw68KF1+J/4IJDaIRjMeH6np4
 EuoaCzMeFfUMcz5pUH5VUkquokJq8z1kzAMtPLb4iT9TMsJ0QtxxtD1Qwd8j1OhCNm25
 vnOelyJqoSr8MJ7oCaepiXFvuGo/UdQL2vmz9y+MVUM1AzvvmkMe+rcap2JYQU0ai/Od
 PYzPmW4HDYYgXdST9re7y4JTLwKVw0tIDBh6NrJQ0u+dmOxSkQ7mv33yvOvY6VOrx6PW
 hBtS7+9i4ZTYcFew5DfO/CA7ALy1IgyJ2GGFkU6tvZ1+BfAqP0b5G2FPLtSZLMul38Ac
 zZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924375; x=1697529175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNwNk6v5s/mWYlSRNEECJ0K7X37JqAfWAFjFfycrRY0=;
 b=WKLQKd8I6MNs/6fOt48s81yIvYbOM25ZSZDKeBFPG04iNQFlKDe/b6jVfOjk6S7OX3
 fOTZf1WpKDH0W3uiZKZLiRGlHEesgeGTRPMuahB2oiPyk9sfO+74C2aeTgBkww7SK9Dg
 fSqysVQEoRkJWQiQErQW17JR2xd6+LGVyRld7QF//KuX8VTc3USk3/V7VjhlMTY5LDKp
 Fmh1B6JZ/YtU04vt/pKxiRrz2YhHnlzcVHGslE/bov5zpRDBqBlJKBe6qm7zYw9Ycyy6
 fapg3c1PyOnejDxw1v9uv77vR5f9raYWih8QNfYpPmmqb7x0XGyBvfL+VrSXRlZrH9o3
 N55g==
X-Gm-Message-State: AOJu0YxHOfL7YgcNee87Ya2E2cvMj7UyskqqLAZJWL+qzB6tSd//rr3t
 FcCXoHwWRG+nBJ3KV8UR5wIz1tLW2J8=
X-Google-Smtp-Source: AGHT+IEZ7jbEeZI0gelwMGzVXD/vYwcL0ynkXCtgd6mYPdwmcNB86f9Nd1DOc4KPm3s3ZHl2ZQEC/w==
X-Received: by 2002:a05:6a21:3290:b0:15d:ec88:356e with SMTP id
 yt16-20020a056a21329000b0015dec88356emr22672435pzb.41.1696924375405; 
 Tue, 10 Oct 2023 00:52:55 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:52:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 02/11] tests/avocado: Add ppc pseries and powernv Hash MMU
 tests
Date: Tue, 10 Oct 2023 17:52:29 +1000
Message-ID: <20231010075238.95646-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

The Hash MMU mode is supported along side Radix in POWER hardware, and
Linux supports running in either mode. Radix is the default so to keep
up testing of QEMU Hash MMU, add some explicit Hash MMU tests.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_powernv.py | 21 ++++++++++++++++++---
 tests/avocado/ppc_pseries.py | 20 +++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
index d0e5c07bde..2be322c47d 100644
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
+    def do_test_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
@@ -25,7 +25,6 @@ def do_test_linux_boot(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         self.vm.set_console()
-        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
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


