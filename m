Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4574B008
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhv-0003PS-FS; Fri, 07 Jul 2023 07:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhp-0003O8-6p; Fri, 07 Jul 2023 07:32:57 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhl-0006oD-8t; Fri, 07 Jul 2023 07:32:56 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6b74b37fbe0so1690016a34.1; 
 Fri, 07 Jul 2023 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729570; x=1691321570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRvRXA7Kh7MmoEvnAsBLLz4TkYuG2taDUOr4AOTd1gE=;
 b=iVavzohH2BB6L+iLZfg6l+lg7aFpFk9X+n6dyPQZ/T4L8WGtx9oFn1Z/MX3bk2vV8s
 ckAOhpLKA+HSg6Ok/+Urwcwr5wVmXKC83iWg3kWt3bE7AZJdRfPXBM+yjDA6LqPAFcai
 VxQw1lEDp85CiTk7cFUIaZl5lm8kEPS7mJntN9EdlPsstZe1U6HTOV04azEAeVOfLFdJ
 t/ZnUrR2SzfhEWNPdqT5EmWPR+gOMqymK/gFjXYUNUF5AWMbm9ZfnSHikQYttBqzWev+
 nZJn+EbTwXR/TJbcSjkUtnWxqJDjNPvnS7B9qgX2Wp+ht8TOUltCH3yl39L3bcoiw2A5
 kvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729570; x=1691321570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRvRXA7Kh7MmoEvnAsBLLz4TkYuG2taDUOr4AOTd1gE=;
 b=Dar8M0I/mp71Zm0Oc0gdkMv7XYYdJceLwGH+qJsm1EFvyUOhsv6x5Vby9HTE8JYHNI
 yPI2dlv9rxegYfDom9QfL67keENfsGToMB9UiYqJ/oR2Srs32opOuJ0BUgmUBMb8ESgr
 FNqDAaUIX+/f3fcz1L8iHtc3c4rej/epaWsEC8bBJYdTaK4MAmajHwP107YoQF9QlxSP
 ItazVqn3w681jtkJ+JSfoqtnzOfVz0fCRQ9bSzpNLXF4WKc+sS03cYb6RFI5GhvwbZuS
 Gg6YXBXZ1BnxK74g4qU2dQcORx+056nBiv2DVw7JqW3U9xRSIaEJEitTar3q1WW3OO1N
 OovQ==
X-Gm-Message-State: ABy/qLbHqH5YAtIbSuNeBAW0Y7beuAyM7a/8b1SL4vN4TknGzLe0WNAJ
 t5VybmSk+8HqLdwq7hzohVB9gfOiWA4=
X-Google-Smtp-Source: APBJJlHxRxsxr8vHvEvSik4XJTEWKQzHogDovrNf6URItz6SjNEyOcWUvxmq7BSlcLnHjijRUlrrLw==
X-Received: by 2002:a9d:7391:0:b0:6b7:4c0a:5de7 with SMTP id
 j17-20020a9d7391000000b006b74c0a5de7mr4602390otk.33.1688729570148; 
 Fri, 07 Jul 2023 04:32:50 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:49 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 34/60] tests/avocado: Add powernv machine test script
Date: Fri,  7 Jul 2023 08:30:42 -0300
Message-ID: <20230707113108.7145-35-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

This copies ppc_pseries.py to start a set of powernv tests, including
a Linux boot test for the newly added SMT mode.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230705120631.27670-5-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 tests/avocado/ppc_powernv.py | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 tests/avocado/ppc_powernv.py

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
new file mode 100644
index 0000000000..d0e5c07bde
--- /dev/null
+++ b/tests/avocado/ppc_powernv.py
@@ -0,0 +1,87 @@
+# Test that Linux kernel boots on ppc powernv machines and check the console
+#
+# Copyright (c) 2018, 2020 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class powernvMachine(QemuSystemTest):
+
+    timeout = 90
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    panic_message = 'Kernel panic - not syncing'
+    good_message = 'VFS: Cannot open root device'
+
+    def do_test_linux_boot(self):
+        self.require_accelerator("tcg")
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
+                      '/ppc/ppc64/vmlinuz')
+        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+    def test_linux_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.do_test_linux_boot()
+        console_pattern = 'VFS: Cannot open root device'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+
+    def test_linux_smp_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_linux_boot()
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_linux_smt_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4,threads=4')
+        self.do_test_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_linux_big_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
+
+        # powernv does not support NUMA
+        self.do_test_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
-- 
2.41.0


